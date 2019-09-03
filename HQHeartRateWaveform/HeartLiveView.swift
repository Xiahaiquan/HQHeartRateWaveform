//
//  HeartLiveView.swift
//  OT_BASE
//
//  Created by HaiQuan on 2019/9/2.
//  Copyright © 2019 HaiQuan. All rights reserved.
//

import UIKit

class HeartLiveView: UIView {

    var points = [NSNumber]()
    let gridWidth: CGFloat = 30.0

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.black
        self.clearsContextBeforeDrawing = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        self.buildGrid()
        self.drawRate()
    }

    public func drawRateWithPoint(_ point: NSNumber) {
        self.points .insert(point, at: 0)

        DispatchQueue.main.async {
            if self.points.count > Int(self.frame.size.width / 6) {
                self.points .removeLast()
            }
            self.setNeedsDisplay()
        }
    }

}

// MARK: - 内部方法
extension HeartLiveView {
    private func drawRate() {
        let width = self.frame.size.width
        let height = self.frame.size.height

        var pointX = width
        var pointY = height / 2
        // 获取当前画布
        let context = UIGraphicsGetCurrentContext()
        // 折线宽度
        context?.setLineWidth(1)
        //消除锯齿
        context?.setShouldAntialias(true)
        // 折线颜色
        context?.setStrokeColor(UIColor.red.cgColor)
        // 起点
        context?.move(to: CGPoint.init(x: pointX, y: pointY))

        for point in points {
            let pointH = CGFloat(point.floatValue)
            pointY = height / 2 + (pointH * height / 2)
            // 下一个点
            context?.addLine(to: CGPoint.init(x: pointX, y: pointY))
            pointX -= 6
        }
        //开始划线
        context?.strokePath()
    }

    private func buildGrid() {

        let width = self.frame.size.width
        let height = self.frame.size.height

        let context = UIGraphicsGetCurrentContext()

        var pointX: CGFloat = 0
        var pointY: CGFloat = 0

        // 在width范围内画竖线
        while pointX < width {

            context?.setLineWidth(0.2)
            context?.setStrokeColor(UIColor.green.cgColor)
            context?.move(to: CGPoint.init(x: pointX, y: 1))
            context?.addLine(to: CGPoint.init(x: pointX, y: height))
            pointX += gridWidth
            context?.strokePath()
        }
        // 在height范围内画横线
        while pointY < height {

            context?.setLineWidth(0.2)
            context?.setStrokeColor(UIColor.green.cgColor)
            context?.move(to: CGPoint.init(x: 1, y: pointY))
            context?.addLine(to: CGPoint.init(x: width, y: pointY))
            pointY += gridWidth
            context?.strokePath()
        }
        pointX = 0
        pointY = 0
        
        // 在width范围内画细的横线
        while pointX < width {
            context?.setLineWidth(0.1)
            context?.setStrokeColor(UIColor.green.cgColor)
            context?.move(to: CGPoint.init(x: pointX, y: 1))
            context?.addLine(to: CGPoint.init(x: pointX, y: height))
            pointX += gridWidth / 5
            context?.strokePath()
        }

        // 在height范围内画细的竖线
        while pointY < height {

            context?.setLineWidth(0.1)
            context?.setStrokeColor(UIColor.green.cgColor)
            context?.move(to: CGPoint.init(x: 1, y: pointY))
            context?.addLine(to: CGPoint.init(x: width, y: pointY))
            pointY += gridWidth / 5
            context?.strokePath()
        }
    }

}
