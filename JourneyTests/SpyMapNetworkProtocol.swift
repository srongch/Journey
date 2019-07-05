//
//  SpyMapNetworkProtocol.swift
//  JourneyTests
//
//  Created by Chhem Sronglong on 26/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation
@testable import Journey

class SpyMapNetworkProtocol : NSObject, MapLoadingProtocol {
    
    var didCall_taskDidChangeStatus: ((_ isError : Bool) -> Void)?
    var didCall_taskFinish: ((_ count : Int) -> Void)?
    
    func addPointtoMap(carPoint: CarPoint) {
//        didCall_taskDidChangeStatus?(true)
    }
    
    func refresh() {
//        didCall_taskDidChangeStatus?(false)
    }
    
    func error(error: String) {
        didCall_taskDidChangeStatus?(true)
    }
    
    func finish(pointCount : Int){
        didCall_taskFinish?(pointCount)
    }
    

}
