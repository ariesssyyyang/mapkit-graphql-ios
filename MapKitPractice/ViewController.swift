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
            if let queryData = result?.data {
                // Parse the data
            } else if let queryError = error {
                // Handle error
            }
        })
    }
}
