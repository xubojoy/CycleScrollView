//
//  WXCycleScrollWaveView.swift
//  WXCycleScrollView
//
//  Created by Welkin Xie on 4/20/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  Github: https://github.com/WelkinXie/WXCycleScrollView
//

import UIKit

class WXCycleScrollWaveView: UIView {
    
    var waveSpeed = 1.2
    var waveTime = 1.0
    var cycleSpeed = 2.0
    var waveColor = UIColor.whiteColor().CGColor
    
    var offsetX = 0.0
    var waveDisplayLink: CADisplayLink?
    var waveShapeLayer: CAShapeLayer?
    
    func wave() {
        if waveShapeLayer != nil {
            return
        }
        waveShapeLayer = CAShapeLayer()
        waveShapeLayer?.fillColor = waveColor
        
        layer.addSublayer(waveShapeLayer!)
        
        waveDisplayLink = CADisplayLink(target: self, selector: #selector(currentWave))
        waveDisplayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
            Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.stop()
        }
    }
    
    func stop() {
        UIView.animateWithDuration(1, animations: { 
            self.alpha = 0
        }) { _ in
            self.alpha = 1
            self.waveDisplayLink?.invalidate()
            self.waveDisplayLink = nil
            self.waveShapeLayer?.path = nil
            self.waveShapeLayer = nil
        }
    }
    
    func currentWave() {
        offsetX += waveSpeed
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 0, CGRectGetHeight(frame) / 2)
        
        var y = 0.0
        for x in 0...Int(CGRectGetWidth(frame)) {
            let a = Float(0.01 * cycleSpeed * Double(x) - offsetX * 0.065)
            y = Double(CGRectGetHeight(frame)) * Double(sinf(a))
            CGPathAddLineToPoint(path, nil, CGFloat(x), CGFloat(y))
        }
        CGPathAddLineToPoint(path, nil, CGRectGetWidth(frame), CGRectGetHeight(frame))
        CGPathAddLineToPoint(path, nil, 0, CGRectGetHeight(frame))
        CGPathCloseSubpath(path)
        
        waveShapeLayer?.path = path
    }
    
}
