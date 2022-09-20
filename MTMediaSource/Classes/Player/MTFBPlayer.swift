//
//  MTFBPlayer.swift
//  MTMediaSource
//
//  Created by PanGu on 2022/9/18.
//

import Foundation

open class MTFBPlayer: MTPlayer {
    public lazy var fbPlayControls: MTFBPlayerControls = {
        let control = MTFBPlayerControls()
        control.otherOptionBlock = { [weak self] opt in
            self?.handleOther(opt: opt)
        }
        return control
    }()

    public func handleOther(opt: MTFBPlayerControls.OtherOption) {
        switch opt {
        case let .slideLimit(time):
            slideLimit(to: time)
        case .fkBufferPeriodEnd:
            fkBufferPeriodEnd()
        case .tryingEnd:
            tryingEnd()
        }
    }

    open func slideLimit(to time: Float) {
    }

    open func fkBufferPeriodEnd() {
    }

    open func tryingEnd() {
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        playControl.removeFromSuperview()
        playControl = fbPlayControls
        view.addSubview(playControl)
        playControl.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
