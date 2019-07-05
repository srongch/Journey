//
//  Array.swift
//  Journey
//
//  Created by Chhem Sronglong on 26/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//
//https://www.hackingwithswift.com/example-code/language/how-to-make-array-access-safer-using-a-custom-subscript

import Foundation

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}
