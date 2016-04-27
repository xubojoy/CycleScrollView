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
    
    var waveSpeed = 5.0
    var waveAmplitude = 5.0
    var waveTime = 1.0
    var waveColor = UIColor.whiteColor().CGColor
    
    var waveWidth: Double?
    var waveHeight: Double?
    var offsetX = 0.0
    var waveDisplayLink: CADisplayLink?
    var waveShapeLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        waveHeight = Double(frame.size.height / 2)
        waveWidth = Double(frame.size.width)
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        waveHeight = Double(frame.size.height / 2)
        waveWidth = Double(frame.size.width)
    }
    
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
        CGPathMoveToPoint(path, nil, 0, CGFloat(waveHeight!))
        
        var y = 0.0
        for x in 0...Int(waveWidth!) {
            let a = Float((360 / Double(waveWidth!)) * (Double(x) * M_PI / 180) - offsetX * M_PI / 180)
            y = waveAmplitude * Double(sinf(a)) + waveHeight!
            CGPathAddLineToPoint(path, nil, CGFloat(x), CGFloat(y))
        }
        CGPathAddLineToPoint(path, nil, CGFloat(waveWidth!), CGRectGetHeight(frame))
        CGPathAddLineToPoint(path, nil, 0, CGRectGetHeight(frame))
        CGPathCloseSubpath(path)
        
        waveShapeLayer?.path = path
    }
    
}
