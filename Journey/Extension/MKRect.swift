//
//  MKRect.swift
//  Journey
//
//  Created by Chhem Sronglong on 25/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import Foundation
//https://useyourloaf.com/blog/swift-equatable-and-comparable/
extension MKMapRect: Equatable {
    public static func == (lhs: MKMapRect, rhs: MKMapRect) -> Bool {
        return lhs.size.height == rhs.size.height &&
            lhs.size.width == rhs.size.width &&
            lhs.origin.x == rhs.origin.x &&
            lhs.origin.y == rhs.origin.y
    }
}
