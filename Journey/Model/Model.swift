//
//  Model.swift
//  Journey
//
//  Created by Chhem Sronglong on 24/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation

enum CarType : String {
    case taxi
    case pooling
    case other
}

struct Model : Codable, CarFleetProtocol{
    var id: Int
    
    var latitude: Double
    
    var longitude: Double
    
    var fleetType: String
    
    var car : Car?
    var addreess : String = ""
    
    init(
        id: Int,
        latitude: Double,
        longitude: Double,
        fleetType: String
        ) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.fleetType = fleetType
    }

    private enum CarListCodingKeys: String, CodingKey {
        case id
        case fleetType
        case coordinate
        case latitude
        case longitude
        case heading
    }
    

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CarListCodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        fleetType = try container.decodeIfPresent(String.self, forKey: .fleetType) ?? ""
        let coordinate = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .coordinate)
        longitude = try coordinate.decode(Double.self, forKey: .longitude)
        latitude = try coordinate.decode(Double.self, forKey: .latitude)
        
    }
}


extension Model {
    var carType : CarType {
        switch fleetType {
        case "TAXI":
            return .taxi
        case "POOLING":
            return .pooling
        default:
            return .other
        }
    }
}
