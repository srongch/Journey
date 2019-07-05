//
//  FakeNetwork.swift
//  JourneyTests
//
//  Created by Chhem Sronglong on 26/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation
@testable import Journey
import PromiseKit
import Moya

class FakeNetwork : JourneyNetworkProtocol  {

    //don need this one.
    let provider: MoyaProvider<Journey>
    
    init(provider: MoyaProvider<Journey>) {
        self.provider = provider
    }
    
    func getCarInformation() -> Promise<[Car]> {
        //
        return Promise { seal in
            seal.fulfill(Car.make())
//            seal.reject(NSError(domain: "someDomain", code: 100, userInfo: nil))
        }
    }

    
    func getCarList(for bounds: MapBound) -> Promise<[Model]> {
        return Promise { seal in
            seal.fulfill(Model.make())
        }
    }
    
    
    
    func getAddress(location :(latitude : Double,longtitude : Double))-> Promise<Address> {
        return Promise { seal in
            //give an error when no car available
            seal.fulfill(Address.make(location: (location.latitude, location.longtitude)))
            
        }
    }
    
    
}
