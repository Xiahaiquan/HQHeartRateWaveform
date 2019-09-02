# HQHeartRateWaveform

        let heartLiveView = HeartLiveView.init(frame: CGRect.init(x: 10, y: 100, width: self.view.frame.width - 20, height: 150))
        self.view.addSubview(heartLiveView)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            let heartRateMappValue = Float.randomCGFloatNumber(lower: -0.5, upper: 0.5)
            print(heartRateMappValue)
            heartLiveView.drawRateWithPoint(NSNumber.init(value: heartRateMappValue))
        }
        
![image](https://github.com/Xiahaiquan/HQHeartRateWaveform/blob/master/Image.gif)
