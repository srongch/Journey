//
//  ColorExtension.swift
//  SportShare
//
//  Created by Chhem Sronglong on 01/03/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static var textBlue: UIColor  { return UIColor(red: 0.0/255, green: 58.0/255, blue: 145.0/255, alpha: 1.0) }
    
//    https://github.com/TrustWallet/trust-wallet-ios/blob/master/Trust/Extensions/UIColor.swift
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
}
