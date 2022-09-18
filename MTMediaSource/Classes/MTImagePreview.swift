//
//  MTImagePreview.swift
//  MTMediaSource
//
//  Created by PanGu on 2022/9/18.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

open class MTImagePreview: UIViewController{
    public var fileName: String?
    public var imageUrl: URL?
    
    public lazy var titleView: UIView = {
        let view = UIView()
        return view
    }()
    
    public lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    public lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    
    public lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.maximumZoomScale = 2
        view.minimumZoomScale = 1
        return view
    }()
    
    public lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        tap.numberOfTapsRequired = 2
        return tap
    }()
    
    public lazy var backButton: MTButton = {
        let btn = MTButton()
        btn.iconSize = MTBasic.imagePreviewBackImageSize
        btn.iconNormal = MTBasic.imagePreviewBackImage
        btn.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        return btn
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    open func loadRemoteImage(){
        guard let imageUrl = self.imageUrl else{
            handleLoadFailure()
            return
        }
        
        imageView.kf.setImage(with: imageUrl, placeholder: nil, options: nil) { result in
            switch result {
            case let .success(imgResult):
                self.imageView.image = imgResult.image
                self.handleLoadSuccess()
            case .failure:
                self.handleLoadFailure()
            }
        }
    }
    
    open func handleLoadSuccess(){
        
    }
    
    open func handleLoadFailure(){
        
    }
}

//MARK:- Actions
extension MTImagePreview{
    @objc open func tapImage(){
        if scrollView.zoomScale > 1 {
            scrollView.setZoomScale(1, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    
    @objc open func tapBack(){
        
    }
}

extension MTImagePreview: UIScrollViewDelegate{
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

//MARK:-- Configure UI
extension MTImagePreview{
    private func configureUI(){
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(topView)
        topView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
        }
        
        topView.addSubview(titleView)
        titleView.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        titleView.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.left.equalTo(10)
            $0.width.height.equalTo(32)
            $0.centerY.equalToSuperview()
        }
    }
}

