//
//  MTPlayerPreviewItem.swift
//  MTMediaSource
//
//  Created by PanGu on 2022/9/19.
/*
    预览项
 */

import Foundation


public class MTPlayerPreviewItem{
    public var filename: String?
    public var fileId: String!
    public var fileUrl: String!
    public var headerStr: String?
    public var pureHeaderStr: String?
    public var isEncryted: Bool = false
    public var loadingTips: [String] = []
    public var bufferModel: MTFkBufferModel?
    public var source: String?
    public var fileetag: String?
    public var fileidx: String?
    public var isLocalPath: Bool = false
    
    public init(){
        
    }
}
