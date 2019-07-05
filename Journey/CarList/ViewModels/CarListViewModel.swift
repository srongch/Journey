//
//  CarListViewModel.swift
//  Journey
//
//  Created by Chhem Sronglong on 24/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation
import PromiseKit

enum FilterType {
    case all
    case taxi
    case pooling
}

class CarListViewModel: NSObject {
    
    private var carNetwork: JourneyNetworkProtocol
    private var mapBound : MapBound
    private var carList: [Model] = []
    private var carListFilterd: [Model] = []
    private var filterType: FilterType
    
    // i don need this one.
//    private var hasCar : Bool = false
//    private var hasFeel : Bool = false
    
    
    weak var delegate: LoadingProtocol?
    
    var mainLocation : (city: String, country : String) {
        return ("Derby", "UK")
    }
    
    init(carNetwork: JourneyNetworkProtocol, mapBound : MapBound, filterType : FilterType) {
        self.carNetwork = carNetwork
        self.mapBound = mapBound
        self.filterType = filterType
        super.init()
    }
    
    func fectch(){
        // get car list, car information
        firstly {
            when(fulfilled: carNetwork.getCarInformation(), carNetwork.getCarList(for: self.mapBound))
            }.done { [weak self] carInfors, careFleet in
                //TODO :
                 guard let strongSelf = self else { return }
                strongSelf.getAddress(models: careFleet,cars: carInfors)
            }.catch {[weak self] error in
                guard let strongSelf = self else { return }
                strongSelf.delegate?.error(error: error.localizedDescription)
            }.finally {}
    }
    
    //get address of each point
    private func getAddress(models : [Model], cars : [Car]){
        var prmoises = [Promise<Address>]()
        models.forEach { model in
            prmoises.append(carNetwork.getAddress(location: (model.latitude,model.longitude)))
        }
    
        firstly {
            when(fulfilled: prmoises)
            }.done {[weak self] addresess in
                self?.combineData(carFleet: models, carInfo: cars, addresses: addresess)
            }.ensure {
                
            }.catch { [weak self] error in
                guard let strongSelf = self else { return }
                strongSelf.delegate?.error(error: error.localizedDescription)
        }
        
    }
    
    // combin all the data together.
    private func combineData(carFleet : [Model], carInfo : [Car], addresses : [Address]){
      carList  = carFleet.enumerated().map { (index, model) -> Model in
            var newModel = model
        if let car = carInfo[safeIndex: index] {
            newModel.car =  car
        }
        let address = addresses.filter{$0.latitude == model.latitude && $0.longtitude == model.longitude}.first
        newModel.addreess = address?.address ?? ""
        return newModel
        }
        
       filter()
    }
    
    
    //change to didset
    func changeFilter(filterType : FilterType) {
        if (self.filterType == filterType) {return }
        self.filterType = filterType
        self.filter()
    }
    
    var getFilter : FilterType  {
        return filterType
    }
    
    private func filter(){
        switch filterType {
        case .all:
            self.carListFilterd = self.carList
        case .taxi:
            self.carListFilterd = self.carList.filter{$0.carType == .taxi}
        case .pooling:
            self.carListFilterd = self.carList.filter{$0.carType == .pooling}
        }
         self.delegate?.refresh()
    }
    
    
    //Mark : CollectionView
    
    var collectionViewInsets : UIEdgeInsets {
        return UIEdgeInsets(top: 30.0,
                            left: 20.0,
                            bottom: 30.0,
                            right: 20.0)
    }
    
    func collectionViewSizeForItem(with viewWidth : CGFloat) -> CGSize{
        let paddingSpace = self.collectionViewInsets.left * (self.collectionViewItemPerRow + 1)
        let availableWidth = viewWidth - paddingSpace
        let widthPerItem =  CGFloat(availableWidth / collectionViewItemPerRow)
        return CGSize(width: widthPerItem , height: 205)
    }
    
    var collectionViewItemPerRow : CGFloat {
        return 2
    }
    
    func numberOfItems(for section: Int) -> Int {
        return carListFilterd.count
    }
    
    func cellViewModel(for path: IndexPath) -> CarListCellViewModel {
        let car = carListFilterd[path.row]
        return CarListCellViewModel(
            viewModel: car
        )
    }
    
    

}
