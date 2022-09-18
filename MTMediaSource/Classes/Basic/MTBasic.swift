//
//  MTBasic.swift
//  MTMediaSource
//
//  Created by PanGu on 2022/9/17.
//

import Foundation


public struct MTBasic{
    public static var isLogEnabled: Bool = false
    
    public static var imagePreviewBackImage: UIImage?
    public static var imagePreviewBackImageSize: CGSize = .init(width: 22, height: 22)
}

public func MTLog(_ items: Any..., separator: String = " ", terminator: String = "\n"){
    guard MTBasic.isLogEnabled == true else{    return}
    print(items,separator:separator,terminator: terminator)
}

public func mt_baseline(_ a: CGFloat, isUseMinPixel: Bool = true)-> CGFloat{
    var screenWidth = UIScreen.main.bounds.width
    if isUseMinPixel{
        screenWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }
    return a / 375 * screenWidth
}

public let MT_SCREEN_WIDTH = UIScreen.main.bounds.width
public let MT_SCREEN_HEIGHT = UIScreen.main.bounds.height
