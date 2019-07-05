//
//  CodableResponse.swift
//  Journey
//
//  Created by Chhem Sronglong on 24/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation


struct CarListResult<T: Codable>: Codable {
    let poiList: [T]
}

struct CarInfoResults<T: Codable>: Codable {
    let carList: [T]
}
