//
//  LoadingProtocol.swift
//  Journey
//
//  Created by Chhem Sronglong on 25/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation

@objc protocol LoadingProtocol : NSObjectProtocol{
    func refresh()
    @objc (error:)
    func error(error : String)
}

@objc  protocol MapLoadingProtocol : LoadingProtocol {
     func addPointtoMap(carPoint : CarPoint)
    
    @objc (finish:)
     func finish(pointCount : Int)
}
