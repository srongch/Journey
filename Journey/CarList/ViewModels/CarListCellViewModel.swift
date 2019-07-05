//
//  CarListCellViewModel.swift
//  Journey
//
//  Created by Chhem Sronglong on 24/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit

struct CarListCellViewModel {
    
    let viewModel : Model
//    var name : String = ""
    
    init(viewModel: Model) {
        self.viewModel = viewModel
    }
    
    var getId : String{
        return "\(viewModel.id)"
    }
    
    var plateNumber : String {
        return viewModel.car?.plate ?? ""
    }
    
    var modelName : String {
        return viewModel.car?.model ?? ""
    }
    
    var color : String {
        return viewModel.car?.color ?? ""
    }
    
    var carType : CarType {
        return self.viewModel.carType
    }
    
    var carImage : URL? {
        return URL(string: viewModel.car?.image ?? "")
    }
    
    var location : String {
        return viewModel.addreess
    }
    
    var plateNumberColor : UIColor {
        return UIColor(hex:"2B3C6A")
    }
    
    var modelColor : UIColor {
         return UIColor(hex:"717D9B")
    }
    
    var colorColor : UIColor{
         return UIColor(hex:"7C8DBD")
    }
    
    var locaionColor : UIColor {
         return UIColor(hex:"717D9B")
    }
    
}
