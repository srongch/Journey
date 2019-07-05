//
//  JourneyNetwork.swift
//  Journey
//
//  Created by Chhem Sronglong on 24/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//
//https://github.com/TrustWallet/trust-wallet-ios/blob/master/Trust/Core/Network/TrustNetwork.swift

import Foundation
import Moya
import PromiseKit

protocol JourneyNetworkProtocol {
    
    //Get all car information from carList.json
    func getCarInformation()-> Promise<[Car]>
    
    //Get car list from API
    func getCarList(for bounds: MapBound) -> Promise<[Model]>
    
    //Get address of each coodinate from Google Map
    func getAddress(location :(latitude : Double,longtitude : Double))-> Promise<Address>
}



final class JourneyNetwork : JourneyNetworkProtocol{

    let provider: MoyaProvider<Journey>
    
    init(provider: MoyaProvider<Journey>) {
        self.provider = provider
    }
    
    func getAddress(location: (latitude : Double,longtitude : Double)) -> Promise<Address> {
        return Promise { seal in
            provider.request(.getAddress(latitude: location.latitude, longtitute: location.longtitude)) { result in
                switch result {
                case .success(let response):
                    
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) as! [String: Any]
                        if let results = jsonResult["results"] as? [Any],
//                            let isIndexValid = results.indices.contains(0),
                            results.count > 0,
                            let first = results[0] as? [String : Any], 
                            let address = first["formatted_address"] as? String {
                          //  print(address)
                            seal.fulfill(Address(address: address,longtitude: location.1,latitude: location.0))
                        }
                        else {
                            // the value of someOptional is not set (or nil).
                            seal.fulfill(Address(address: "Address not found",longtitude: location.1,latitude: location.0))
                        }
                    
                    } catch {
                        seal.reject(error)
                    }
                    
                case .failure(let error):
                    seal.reject(error)
                    
                }
            }
        }
    }

    
    func getCarList(for bounds: MapBound) -> Promise<[Model]> {
        return Promise { seal in
            provider.request(.getList(latitude1: bounds.latitude1, longtitute1: bounds.longtitute1, latitude2: bounds.latitude2, longtitute2: bounds.longtitute2)) { result in
                switch result {
                case .success(let response):
                    do {
                        let result = try response.map(CarListResult<Model>.self).poiList
                      //  print(result)
                        seal.fulfill(result)
                    } catch {
                       seal.reject(error)
                    }
                    
                case .failure(let error):
                    seal.reject(error)
                    
                }
            }
        }
    }
    
    func getCarInformation() -> Promise<[Car]> {
        return Promise { seal in
            if let pathURL = Bundle.main.url(forResource: "carlist", withExtension: "json") {
                
                    let data = try Data(contentsOf: pathURL, options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                
                    do {
                        let decoded = try decoder.decode([Car].self, from: data)
//                        print(decoded)
                        seal.fulfill(decoded)
                    } catch {
                        print("Failed to decode JSON")
                        seal.reject(error)
                    }
            }
           
        }
    }
    
}
