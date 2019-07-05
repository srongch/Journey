//
//  SpyLoadingProtocol.swift
//  JourneyTests
//
//  Created by Chhem Sronglong on 26/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

//https://www.mokacoding.com/blog/testing-delegates-in-swift-with-xctest/

import Foundation
@testable import Journey

class SpyLoadingProtocol :NSObject, LoadingProtocol {
    
    func refresh() {
       didCall_taskDidChangeStatus?(false)
    }
    
    func error(error : String){
        didCall_taskDidChangeStatus?(true)
    }
    
    var didCall_taskDidChangeStatus: ((_ isError : Bool) -> Void)?
    
    
    
}
