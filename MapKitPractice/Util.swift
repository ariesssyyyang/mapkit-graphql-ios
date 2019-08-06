//
//  Util.swift
//  MapKitPractice
//
//  Created by Aries Yang on 2019/8/6.
//  Copyright © 2019 Aries Yang. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum ResponseError: Error {
    case parse
}
