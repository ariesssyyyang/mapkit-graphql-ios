//
//  ViewController.swift
//  MapKitPractice
//
//  Created by Aries Yang on 2019/8/4.
//  Copyright © 2019 Aries Yang. All rights reserved.
//

import UIKit
import MapKit
import Apollo

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()
    var userLocation: CLLocation? {
        didSet {
            getNearby()
        }
    }
    private let defaultLocation = CLLocation(latitude: 25.0478, longitude: 121.5318)
    let regionRedius: CLLocationDistance = 1000
    var restaurantList: Array<Restaurant> = [] {
        didSet {
            mapView.addAnnotations(restaurantList)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        centerMapOnLocation(location: userLocation ?? defaultLocation)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNearby()
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRedius, longitudinalMeters: regionRedius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    var watcher: GraphQLQueryWatcher<NearbyQuery>?

    func getNearby() {
        let coordinate = userLocation?.coordinate ?? defaultLocation.coordinate
        watcher = apollo.watch(query: NearbyQuery(latitude: coordinate.latitude, longitude: coordinate.longitude), resultHandler: { (result, error) in
            switch self.mapResponseToResult(response: result, error: error) {
            case .success(let restaurants):
                print(restaurants)
                self.restaurantList = restaurants
            case .failure(let error):
                print(error)
            }
        })
    }

    private func mapResponseToResult(response: GraphQLResult<NearbyQuery.Data>?, error: Error?) -> Result<Array<Restaurant>> {
        if let error = error {
            return .failure(error)
        }
        guard let businessList = response?.data?.search?.business else {
            return .failure(ResponseError.parse)
        }
        let restaurants = businessList.enumerated().map { (index, business) -> Restaurant in
            let name = business?.name ?? "n/a"
            let id = business?.id ?? "id\(index)"
            let district = (business?.alias ?? "n/a").components(separatedBy: "-")[1]
            let address = business?.location?.address1 ?? "n/a"
            let coordinate = business?.coordinates
            return Restaurant(
                id: id,
                name: name,
                address: district + address,
                latitude: coordinate?.latitude,
                longitude: coordinate?.longitude
            )
        }
        return .success(restaurants)
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Restaurant else { return nil }
        let identifier = "restaurant"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }

        return view
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        userLocation = location
    }
}
