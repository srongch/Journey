//
//  MapItem.swift
//  Journey
//
//  Created by Chhem Sronglong on 25/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//
//Adapted from : https://medium.com/@nimjea/swift-objective-c-mixed-languages-app-16b6c9c3e9b0

import Foundation

@objc class MapItem : NSObject, CarFleetProtocol {
    
 @objc var id: Int
    
  @objc  var latitude: Double
    
  @objc  var longitude: Double
    
  @objc  var fleetType: String
    
    
    
    init(model : Model) {
        self.id = model.id
        self.fleetType = model.fleetType
        self.latitude = model.latitude
        self.longitude = model.longitude
    }
    
}
