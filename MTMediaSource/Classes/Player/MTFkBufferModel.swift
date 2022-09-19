//
//  MTFkBufferModel.swift
//  MTMediaSource
//
//  Created by PanGu on 2022/9/18.
//

import Foundation


open class MTFkBufferModel{
    public var k_trigger_boot: Int = 0
    public var m_playing_pause: Int = 0
    public var n_waiting_play: Int = 0
    
    public var drag_ratio: Float = 0
    /// 豪秒数
    public var min_drag_duration: Int = 0
    /// 豪秒数
    public var trial_duration: Int = 0
    
    public var bufferTag: String = ""
    public var dragTag: String = ""
    
    public var state_isBufferable = false
    public var state_isLimitDragable = false
}


open class MTPlayerBufferControl{
    public var isBuffering = false
    public var playedDuration: Int = 0
    public var pausedDuration: Int = 0
    public var bufferedTime: Int = 0
    
    /// 是否需要Buffer
    public var isBufferEnabled = false
    
    func reset(with bufferModel: MTFkBufferModel?){
        isBuffering = false
        bufferedTime = 0
        playedDuration = 0
        pausedDuration = 0
        isBufferEnabled = false
        
        if let bufferModel = bufferModel{
            isBufferEnabled = bufferModel.state_isBufferable
        }
    }
    
    public var totalTrySeconds = 0
    public var tryLeftSeconds = 0
    public var isTrying: Bool = false
    
    public var maxSlideLimit: Int = 0
}


