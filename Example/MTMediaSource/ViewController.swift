//
//  ViewController.swift
//  MTMediaSource
//
//  Created by Hippie Fox on 09/17/2022.
//  Copyright (c) 2022 Hippie Fox. All rights reserved.
//

import UIKit
import MTMediaSource

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        MTBasic.isLogEnabled = true
        MTLog("let's start!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

