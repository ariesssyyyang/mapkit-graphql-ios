//
//  Restaurant.swift
//  MapKitPractice
//
//  Created by Aries Yang on 2019/8/6.
//  Copyright © 2019 Aries Yang. All rights reserved.
//

import Foundation
import MapKit

class Restaurant: NSObject, MKAnnotation {

    let id: String
    let name: String
    let address: String
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(id: String, name: String, address: String, latitude: Double? = nil, longitude: Double? = nil) {
        self.id = id
        self.name = name
        self.address = address
        self.title = name
        self.subtitle = address
        if let lat = latitude, let long = longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
}
