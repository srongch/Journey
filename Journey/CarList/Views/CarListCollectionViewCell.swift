//
//  ScheduleCell.swift
//  User
//
//  Created by Chhem Sronglong on 20/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import UIKit
import Kingfisher

class CarListCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var plateNumber: UILabel!
    @IBOutlet weak var modelName: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var carType: UIImageView!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var location: UILabel!

    
    func setupCell(for viewModel : CarListCellViewModel){
        plateNumber.text = viewModel.plateNumber
        plateNumber.textColor = viewModel.plateNumberColor
        
        modelName.text = viewModel.modelName
        modelName.textColor = viewModel.modelColor
        
        color.text = viewModel.color
        color.textColor = viewModel.colorColor
        
        switch viewModel.carType {
        case .taxi:
            carType.isHidden = false
        default:
            carType.isHidden = true
        }
        
        location.text = viewModel.location
        location.textColor = viewModel.locaionColor
        
        guard let imageUrl  = viewModel.carImage else {
            carImage.image = UIImage(named: "place_holder")
            return
        }
        carImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "place_holder"), options: nil, progressBlock: nil, completionHandler: nil)
        
    }
    
    
}
