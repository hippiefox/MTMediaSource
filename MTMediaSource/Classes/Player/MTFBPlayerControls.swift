//
//  MTFBPlayerControls.swift
//  MTMediaSource
//
//  Created by PanGu on 2022/9/18.
//

import Foundation

public extension MTFBPlayerControls{
    enum OtherOption{
        case slideLimit(Float)
        case fkBufferPeriodEnd
        case tryingEnd
    }
}


open class MTFBPlayerControls: MTPlayerControls{
    /// 资源准备完毕，准备播放
    public var isReadyForPlaying = false
    
    public var otherOptionBlock: ((OtherOption)->Void)?
    
    public override var playTime: TimeInterval{
        didSet{
            if isReadyForPlaying{
                tryFkBuffer()
            }
        }
    }
    
    public var bufferModel: MTFkBufferModel?{
        didSet{
            bufferControl.reset(with: bufferModel)
        }
    }
    
    public var bufferControl: MTPlayerBufferControl = MTPlayerBufferControl()
    
    /// 是否解锁所有功能
    public var isAccessAllRights: Bool = true{
        didSet{
            if isAccessAllRights{
                hideBufferLoading()
                togglePlayContol(isEnabled: true)
            }
        }
    }
    
    public lazy var otherView = MTPlayerOtherView()
    
    lazy var tryingTipsLabel: UILabel = {
        let label = UILabel()
        label.textColor = MTPlayerConfig.tryingColor
        label.font = .systemFont(ofSize: 13)
        return label
    }()


    
    open override func slide(to value: Float) {
        if bufferControl.maxSlideLimit > 0,
           value > Float(bufferControl.maxSlideLimit),
           isAccessAllRights == false{
            otherOptionBlock?(.slideLimit(value))
        }else{
            optionBlock?(.slide(value))
        }
    }
    
    public lazy var loadingTipsView: MTPlayerLoadingTipsView = {
        let view = MTPlayerLoadingTipsView()
        return view
    }()
}

//MARK:-- Configure UI
extension MTFBPlayerControls{
    open override func configureUI() {
        super.configureUI()
        //MARK: (Other View)
        otherView.isUserInteractionEnabled = false
        otherView.isHidden = true
        contentView.addSubview(otherView)
        otherView.snp.makeConstraints {
            $0.edges.equalTo(middleView)
        }

        loadingTipsView.isHidden = true
        otherView.addSubview(loadingTipsView)
        loadingTipsView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo((56))
            $0.centerY.equalToSuperview()
        }
    }
}


extension MTFBPlayerControls{
    @objc open func showBufferLoading(){
        MTLog(#function)
    }
    
    @objc open func hideBufferLoading(){
        MTLog(#function)
    }
    
    public func tryFkBuffer(){
        guard isAccessAllRights == false else{    return}
        
        guard bufferControl.isBufferEnabled == true,
              let bufferModel = self.bufferModel,
              bufferModel.k_trigger_boot > 0,
              bufferModel.m_playing_pause > 0,
              bufferModel.n_waiting_play > 0
        else{   return}
        
        if bufferControl.isBuffering == false{
            // playing state
            if bufferControl.playedDuration > 0 &&
                bufferControl.playedDuration % bufferModel.m_playing_pause == 0
            {
                // enter buffering state
                optionBlock?(.pause)
                bufferControl.playedDuration = 0
                bufferControl.isBuffering = true
                togglePlayContol(isEnabled: false)
                showFkBuffer()
                return
            }
            bufferControl.playedDuration += 1000
        }else{
            // enter pausing state
            if bufferControl.pausedDuration > 0,
               bufferControl.pausedDuration % bufferModel.n_waiting_play == 0{
                bufferControl.pausedDuration = 0
                optionBlock?(.play)
                hideBufferLoading()
                bufferControl.isBuffering = false
                togglePlayContol(isEnabled: true)
                return
            }
               
            showBufferLoading()
            bufferControl.pausedDuration += 1000
        }
    }
    
    public func showFkBuffer(){
        if let tb = bufferModel?.k_trigger_boot,
           tb > 0,
           bufferControl.bufferedTime >= (tb-1)
        {
            // buffer period end
            bufferControl.reset(with: nil)
            hideBufferLoading()
            otherOptionBlock?(.fkBufferPeriodEnd)
            togglePlayContol(isEnabled: true)
            return
        }
        showBufferLoading()
        bufferControl.bufferedTime += 1
    }
    
    public func togglePlayContol(isEnabled: Bool){
        let targetViewsInBottom: [UIView] = [playButton]
        targetViewsInBottom.forEach {
            $0.isUserInteractionEnabled = isEnabled
        }
        pan.isEnabled = isEnabled
        longPress.isEnabled = isEnabled
    }
    
    public func startTry(){
        guard bufferControl.totalTrySeconds > 0 else{   return}
        bufferControl.isTrying = true
        isAccessAllRights = true
        bufferControl.tryLeftSeconds = bufferControl.totalTrySeconds
        
        otherView.isHidden = false
        otherView.addSubview(tryingTipsLabel)
        tryingTipsLabel.snp.makeConstraints {
            $0.left.equalTo(10)
            $0.top.equalTo(20)
        }
        updateTryUI()
    }
    
    public func updateTryUI(){
        tryingTipsLabel.text = (MTPlayerConfig.tryingTips ?? "") + "(\(bufferControl.tryLeftSeconds)s"
        bufferControl.tryLeftSeconds -= 1
        if bufferControl.tryLeftSeconds < 0{
            bufferControl.isTrying = false
            isAccessAllRights = false
            otherOptionBlock?(.tryingEnd)
            tryingTipsLabel.text = MTPlayerConfig.tryingEndTips
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.tryingTipsLabel.removeFromSuperview()
                self.hideAllOtherViews()
            }
        }
    }
    
    private func hideAllOtherViews(){
        otherView.isHidden = true
        otherView.subviews.forEach {
            $0.isHidden = true
        }
    }
}
