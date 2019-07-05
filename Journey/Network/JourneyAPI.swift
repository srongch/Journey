//
//  JourneyAPI.swift
//  Journey
//
//  Created by Chhem Sronglong on 24/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

//https://github.com/Moya/Moya/blob/master/Examples/_shared/GitHubAPI.swift

import Foundation
import Moya


// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum Journey {
    case getList(latitude1: Double, longtitute1: Double, latitude2: Double, longtitute2: Double)
    case getAddress(latitude: Double, longtitute: Double)
}

extension Journey: TargetType {
    public var baseURL: URL {
        switch self {
        case .getAddress:
            return URL(string: "https://maps.googleapis.com/maps/api/geocode/json")!
        case .getList:
           return URL(string: "https://journey.sronglong.now.sh/api/point.js")!
        
        }
     }
    public var path: String {
        switch self {
        case .getList, .getAddress:
            return ""
        }
    }
    public var method: Moya.Method {
        switch self {
        case .getAddress: return .get
        case .getList: return .get
        }
    }
    public var task: Task {
        switch self {
        case .getAddress(let latitude, let longtitute):
            let params: [String: Any] = ["latlng": "\(latitude),\(longtitute)", "key": GOOGLE_MAP_API]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .getList(let latitude1, let longtitute1, let latitude2, let longtitute2):
            let params: [String: Any] = ["p1Lat": latitude1, "p1Lon": longtitute1, "p2Lon": longtitute2, "p2Lat": latitude2]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    public var validationType: ValidationType {
        switch self {
        case .getList:
            return .none
        default:
            return .none
        }
    }
    public var sampleData: Data {
        return Data()
//        switch self {
////        case .zen:
////            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
//        case .userProfile(let name):
//            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: String.Encoding.utf8)!
//        case .userRepositories(let name):
//            return "[{\"name\": \"\(name)\"}]".data(using: String.Encoding.utf8)!
//        }
    }
    public var headers: [String: String]? {
        return nil
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

// MARK: - Response Handlers

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}
