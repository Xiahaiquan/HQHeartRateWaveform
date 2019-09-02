//
//  ViewController.swift
//  HQHeartRateWaveform
//
//  Created by HaiQuan on 2019/9/2.
//  Copyright © 2019 HaiQuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

//      初始化HeartLiveView
        let heartLiveView = HeartLiveView.init(frame: CGRect.init(x: 10, y: 100, width: self.view.frame.width - 20, height: 150))
        self.view.addSubview(heartLiveView)

//         模拟心率映射值
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            let heartRateMappValue = Float.randomCGFloatNumber(lower: -0.5, upper: 0.5)
            print(heartRateMappValue)
            heartLiveView.drawRateWithPoint(NSNumber.init(value: heartRateMappValue))
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
         if timer.isValid {  timer.invalidate() }
    }

}

public extension Float {
    static func randomCGFloatNumber(lower: Float = 0,upper: Float = 1) -> Float {
        return Float(arc4random()) / Float(UInt32.max) * (upper - lower) + lower
    }
}

