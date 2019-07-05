//
//  Model.swift
//  JourneyTests
//
//  Created by Chhem Sronglong on 26/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//



import Foundation
@testable import Journey

extension Model {
    static func make()->[Model]{
        let model1 = Model(id: 1, latitude: 52.928250026526584, longitude: -1.4968924347064725, fleetType: "TAXI")
        let model2 = Model(id: 2, latitude: 52.944314682264675, longitude: -1.4917303468194072, fleetType: "POOLING")
        let model3 = Model(id: 3, latitude: 52.9382848792051, longitude: -1.5009437912322252, fleetType: "POOLING")
        
        return [model1,model2,model3]
    }
}

//{
//    "poiList": [
//    {
//    "id": 1,
//    "coordinate": {
//    "latitude": 52.928250026526584,
//    "longitude": -1.4968924347064725
//    },
//    "fleetType": "TAXI"
//    },
//    {
//    "id": 2,
//    "coordinate": {
//    "latitude": 52.944314682264675,
//    "longitude": -1.4917303468194072
//    },
//    "fleetType": "TAXI"
//    },
//    {
//    "id": 3,
//    "coordinate": {
//    "latitude": 52.9382848792051,
//    "longitude": -1.5009437912322252
//    },
//    "fleetType": "TAXI"
//    },
//    {
//    "id": 4,
//    "coordinate": {
//    "latitude": 52.93536359124935,
//    "longitude": -1.4970924848304799
//    },
//    "fleetType": "POOLING"
//    },
//    {
//    "id": 5,
//    "coordinate": {
//    "latitude": 52.94634078122264,
//    "longitude": -1.5058788005840638
//    },
//    "fleetType": "POOLING"
//    },
//    {
//    "id": 6,
//    "coordinate": {
//    "latitude": 52.944805703579696,
//    "longitude": -1.5020186343387116
//    },
//    "fleetType": "TAXI"
//    },
