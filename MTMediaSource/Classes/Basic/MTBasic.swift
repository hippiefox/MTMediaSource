//
//  MTBasic.swift
//  MTMediaSource
//
//  Created by PanGu on 2022/9/17.
//

import Foundation


public struct MTBasic{
    public static var isLogEnabled: Bool = false
}

public func MTLog(_ items: Any..., separator: String = " ", terminator: String = "\n"){
    guard MTBasic.isLogEnabled == true else{    return}
    print(items,separator:separator,terminator: terminator)
}
