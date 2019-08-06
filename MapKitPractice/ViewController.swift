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

    let initialLocation = CLLocation(latitude: 25.0478, longitude: 121.5318)
    let regionRedius: CLLocationDistance = 1000
    var restaurantList: Array<Restaurant> = [] {
        didSet {
            mapView.addAnnotations(restaurantList)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        centerMapOnLocation(location: initialLocation)
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
        let coordinate = initialLocation.coordinate
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
