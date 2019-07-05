//
//  MapNetwork.swift
//  Journey
//
//  Created by Chhem Sronglong on 25/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation
import PromiseKit

@objc protocol MapNetworkProtocol{
    func finishLoadingWithData(items : [MapItem])
    func error()
}

@objc public class MapNetwork: NSObject {
    
    //network protocol cant be used with Objective-c, need alot refactor.
    private var mapNetWork: JourneyNetworkProtocol
  
    init(mapNetWork: JourneyNetworkProtocol){
        self.mapNetWork = mapNetWork
        super.init()
    }
    
    weak var delegate: MapNetworkProtocol?
    
    @objc(setDelegate:)
    func setDelegate(delegate : MapNetworkProtocol){
        self.delegate = delegate
    }
    
    @objc func fetch(mapBound : MapBound){
        
        firstly {
            mapNetWork.getCarList(for: mapBound)
            }.done { [weak self] carList in
                guard let strongSelf = self else { return }
//                print(carList)
             let newList = carList.map{MapItem(model: $0)}
                strongSelf.delegate?.finishLoadingWithData(items: newList)
            }.catch { [weak self] carList in
                guard let strongSelf = self else { return }
                strongSelf.delegate?.error()
                
            }
                
        }
    }
    
    
    
    
    

