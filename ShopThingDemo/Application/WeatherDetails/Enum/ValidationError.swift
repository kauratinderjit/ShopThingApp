//
//  ValidationError.swift
//  ShopThingDemo
//
//  Created by Atinder Kaur on 2021-04-28.
//

import Foundation

enum ValidationError: Error {
    case emptyCurrentLoc
    case emptyTemp
    case emptyMinTemp
    case emptyMaxTemp
    
}
