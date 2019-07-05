//
//  UIButton+Filter.swift
//  Journey
//
//  Created by Chhem Sronglong on 24/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import UIKit

extension UIButton {
    func setNormal(){
        self.backgroundColor = .init(white:0, alpha: 0.34)
        self.setTitleColor(.white, for: .normal)
    }
    
    func setSelected(otherButtons : [UIButton]?){
        self.backgroundColor = .white
        self.setTitleColor(.textBlue, for: .normal)
        guard let buttons = otherButtons else{
            return
        }
        buttons.forEach { $0.setNormal()}
    }
}
