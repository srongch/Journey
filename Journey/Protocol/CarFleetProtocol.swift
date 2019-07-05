//
//  CarFleetProtocol.swift
//  Journey
//
//  Created by Chhem Sronglong on 25/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation

protocol CarFleetProtocol {
//    {
//    "id": 1,
//    "coordinate": {
//    "latitude": 52.928250026526584,
//    "longitude": -1.4968924347064725
//    },
//    "fleetType": "TAXI"
//    }
    
    var id : Int {get set}
    var latitude: Double {get set}
    var longitude: Double {get set}
    var fleetType : String {get set}
}
