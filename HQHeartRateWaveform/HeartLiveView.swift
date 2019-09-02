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
    let grid_w: CGFloat = 30.0

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
        let ww = self.frame.size.width
        let hh = self.frame.size.height

        var pos_x = ww
        var pos_y = hh / 2
        // 获取当前画布
        let context = UIGraphicsGetCurrentContext()
        // 折线宽度
        context?.setLineWidth(1)
        //消除锯齿
        context?.setShouldAntialias(true)
        // 折线颜色
        context?.setStrokeColor(UIColor.red.cgColor)
        // 起点
        context?.move(to: CGPoint.init(x: pos_x, y: pos_y))

        for point in points {
            let h = CGFloat(point.floatValue)
            pos_y = hh / 2 + (h * hh / 2)
            // 下一个点
            context?.addLine(to: CGPoint.init(x: pos_x, y: pos_y))
            pos_x -= 6
        }
        //开始划线
        context?.strokePath()
    }

    private func buildGrid() {

        let width = self.frame.size.width
        let height = self.frame.size.height

        let context = UIGraphicsGetCurrentContext()

        var pos_x: CGFloat = 0
        var pos_y: CGFloat = 0


        // 在width范围内画竖线
        while pos_x < width {

            context?.setLineWidth(0.2)
            context?.setStrokeColor(UIColor.green.cgColor)
            context?.move(to: CGPoint.init(x: pos_x, y: 1))
            context?.addLine(to: CGPoint.init(x: pos_x, y: height))
            pos_x += grid_w
            context?.strokePath()
        }
        // 在height范围内画横线
        while pos_y < height {

            context?.setLineWidth(0.2)
            context?.setStrokeColor(UIColor.green.cgColor)
            context?.move(to: CGPoint.init(x: 1, y: pos_y))
            context?.addLine(to: CGPoint.init(x: width, y: pos_y))
            pos_y += grid_w;
            context?.strokePath()
        }
        pos_x = 0
        pos_y = 0

        // 在width范围内画细的横线
        while pos_x < width {
            context?.setLineWidth(0.1)
            context?.setStrokeColor(UIColor.green.cgColor)
            context?.move(to: CGPoint.init(x: pos_x, y: 1))
            context?.addLine(to: CGPoint.init(x: pos_x, y: height))
            pos_x += grid_w / 5
            context?.strokePath()
        }

        // 在height范围内画细的竖线
        while pos_y < height {

            context?.setLineWidth(0.1)
            context?.setStrokeColor(UIColor.green.cgColor)
            context?.move(to: CGPoint.init(x: 1, y: pos_y))
            context?.addLine(to: CGPoint.init(x: width, y: pos_y))
            pos_y += grid_w / 5;
            context?.strokePath()
        }
    }

}
