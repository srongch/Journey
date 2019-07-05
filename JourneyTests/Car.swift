//
//  Car.swift
//  JourneyTests
//
//  Created by Chhem Sronglong on 26/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation
@testable import Journey

extension Car{
    static func make()->[Car]{
        let car1 = Car(plate: "UIG 1579", model: "BMW-X5", color: "Brown", image: "http://pngimg.com/uploads/bmw/bmw_PNG1711.png")
         let car2 = Car(plate: "OBU 328P", model: "Bentley", color: "Silver", image: "http://pngimg.com/uploads/bentley/bentley_PNG63.png")
         let car3 = Car(plate: "XGU 991M", model: "Honda", color: "Red", image: "http://pngimg.com/uploads/honda/honda_PNG10349.png")
        return [car1,car2,car3]
    }
}


//{
//    "plate": "UIG 1579",
//    "model": "BMW-X5",
//    "color": "Brown",
//    "image": "http://pngimg.com/uploads/bmw/bmw_PNG1711.png"
//},
//{
//    "plate": "OBU 328P",
//    "model": "Bentley",
//    "color": "Silver",
//    "image": "http://pngimg.com/uploads/bentley/bentley_PNG63.png"
//},
//{
//    "plate": "XGU 991M",
//    "model": "Honda",
//    "color": "Red",
//    "image": "http://pngimg.com/uploads/honda/honda_PNG10349.png"
//},
