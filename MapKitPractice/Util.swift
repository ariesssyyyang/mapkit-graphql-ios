//
//  Util.swift
//  MapKitPractice
//
//  Created by Aries Yang on 2019/8/6.
//  Copyright © 2019 Aries Yang. All rights reserved.
//

import Foundation
import MapKit

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum ResponseError: Error {
    case parse
}

struct Restaurant {
    let id: String
    let name: String
    let address: String
    let location: CLLocation?

    init(id: String, name: String, address: String, latitude: Double? = nil, longitude: Double? = nil) {
        self.id = id
        self.name = name
        self.address = address
        if let lat = latitude, let long = longitude {
            self.location = CLLocation(latitude: lat, longitude: long)
        } else {
            self.location = nil
        }
    }
}
