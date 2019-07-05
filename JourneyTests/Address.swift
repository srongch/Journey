//
//  Address.swift
//  JourneyTests
//
//  Created by Chhem Sronglong on 26/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation

@testable import Journey

extension Address {
    static func make(location: (latitude:  Double, longtitude : Double))->Address{
        var dic : [String : Address] = [
            "-1.4968924347064725,52.928250026526584" : Address(address: "Mill Dam Allotments, Markeaton St, Derby DE22 3AZ, UK", longtitude: -1.4968924347064725, latitude: 52.928250026526584),
            "-1.4917303468194072,52.944314682264675" : Address(address: "94 Ferrers Way, Derby DE22 2BD, UK", longtitude: -1.4917303468194072, latitude: 52.944314682264675),
            "-1.5009437912322252,52.9382848792051" : Address(address: "288 Kedleston Rd, Derby DE22 2TE, UK", longtitude: -1.5009437912322252, latitude: 52.9382848792051)
        ]
        return dic["\(location.longtitude),\(location.latitude)"]!
    }
}


//let model1 = Model(id: 1, latitude: 52.928250026526584, longitude: -1.4968924347064725, fleetType: "TAXI")
//let model2 = Model(id: 2, latitude: 52.944314682264675, longitude: -1.4917303468194072, fleetType: "POOLING")
//let model3 = Model(id: 3, latitude: 52.9382848792051, longitude: -1.5009437912322252, fleetType: "POOLING")
