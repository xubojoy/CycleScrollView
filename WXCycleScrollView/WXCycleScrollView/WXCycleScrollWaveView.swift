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

class WXCycleScrollWaveView: UIView, UIScrollViewDelegate {
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
        self.waveHeight = Double(frame.size.height / 2)
        self.waveWidth = Double(frame.size.width)
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.waveHeight = Double(self.frame.size.height / 2)
        self.waveWidth = Double(self.frame.size.width)
    }
    
    func wave() {
        if self.waveShapeLayer != nil {
            return
        }
        self.waveShapeLayer = CAShapeLayer()
        self.waveShapeLayer?.fillColor = self.waveColor
        
        self.layer.addSublayer(self.waveShapeLayer!)
        
        self.waveDisplayLink = CADisplayLink(target: self, selector: #selector(currentWave))
        self.waveDisplayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        
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
        self.offsetX += self.waveSpeed
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 0, CGFloat(self.waveHeight!))
        
        var y = 0.0
        for x in 0...Int(self.waveWidth!) {
            let a = Float((360 / Double(self.waveWidth!)) * (Double(x) * M_PI / 180) - self.offsetX * M_PI / 180)
            y = self.waveAmplitude * Double(sinf(a)) + self.waveHeight!
            CGPathAddLineToPoint(path, nil, CGFloat(x), CGFloat(y))
        }
        CGPathAddLineToPoint(path, nil, CGFloat(self.waveWidth!), CGRectGetHeight(self.frame))
        CGPathAddLineToPoint(path, nil, 0, CGRectGetHeight(self.frame))
        CGPathCloseSubpath(path)
        
        self.waveShapeLayer?.path = path
    }
}
