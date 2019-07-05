//
//  MapBound.swift
//  Journey
//
//  Created by Chhem Sronglong on 24/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation

@objc class MapBound : NSObject {
    var latitude1: Double
    var longtitute1: Double
    var latitude2: Double
    var longtitute2: Double
    
    @objc init(latitude1: Double,
    longtitute1: Double,
    latitude2: Double,
    longtitute2: Double) {
        self.latitude1 = latitude1
        self.longtitute1 = longtitute1
        self.latitude2 = latitude2
        self.longtitute2 = longtitute2
    }
    
    
//    https://collindonnell.com/2018/06/21/equatable-swift-nsobjects/
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? MapBound else {
            return false
        }
        print(rhs.latitude2)
        return self.latitude1 == rhs.latitude1 &&
            self.longtitute1 == rhs.longtitute1 &&
            self.latitude2 == rhs.latitude2 &&
            self.longtitute2 == rhs.longtitute2
    }
}


