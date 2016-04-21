//
//  WXCycleScrollView.swift
//  WXCycleScrollView
//
//  Created by Welkin Xie on 4/18/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//

import UIKit

public class WXCycleScrollView: UIView, UIScrollViewDelegate {
    
    let scrollView : UIScrollView
    let pageControl : UIPageControl
    var delegate : WXCycleScrollViewDelegate?
    
    private var waveView : WXCycleScrollWaveView
    private var scrollTimer : NSTimer?
    
    var autoScrollTimeInterval = 3.0 {
        didSet(newScrollTime) {
            self.resetTimer()
        }
    }
    
    var waveColor = UIColor.whiteColor() {
        didSet(newWaveColor) {
            self.waveView.waveColor = self.waveColor.CGColor
        }
    }
    
    var needWave = true {
        didSet(newNeed) {
            self.waveView.hidden = !self.needWave
            self.pageControl.frame = CGRectMake(0, CGRectGetHeight(frame) - (self.needWave ? 28 : 20), CGRectGetWidth(frame), 15)
        }
    }
    
    
    public convenience init(frame: CGRect, imageURLs: Array<String>, placeHolder: UIImage?) {
        self.init(frame: frame, imageCount: imageURLs.count)
        
        var index = 0
        for subview in self.scrollView.subviews {
            if subview.isMemberOfClass(UIImageView) {
                let imageView = subview as! UIImageView
                if !WXCycleScrollImageManager.isImageExisted(imageURLs[index]) {
                    imageView.image = placeHolder
                    imageView.setWebImage(imageURLs[index])
                } else {
                    imageView.setCachedImage(imageURLs[index])
                }
                index += 1
            }
        }
    }
    
    public convenience init(frame: CGRect, imageNames: Array<String>) {
        self.init(frame: frame, imageCount: imageNames.count)
        
        var index = 0
        for subview in self.scrollView.subviews {
            if subview.isMemberOfClass(UIImageView) {
                let imageView = subview as! UIImageView
                imageView.image = UIImage.init(named: imageNames[index])
            }
            index += 1
        }
    }
    
    private init(frame: CGRect, imageCount: Int) {
        self.scrollView = UIScrollView.init(frame: CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)))
        self.pageControl = UIPageControl.init(frame: CGRectMake(0, CGRectGetHeight(frame) - 28, CGRectGetWidth(frame), 15))
        self.waveView = WXCycleScrollWaveView.init(frame: CGRectMake(0, CGRectGetHeight(frame) - 9, CGRectGetWidth(frame), 10))

        super.init(frame: frame)
                
        let width = CGRectGetWidth(frame) * CGFloat(imageCount)
        let realFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), width, CGRectGetHeight(frame))
        
        self.scrollView.delegate = self
        self.scrollView.contentSize = realFrame.size
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        
        self.pageControl.numberOfPages = imageCount
        self.pageControl.currentPage = 0
        
        for index in 0 ..< imageCount {
            let imageFrame = CGRectMake(CGRectGetWidth(frame) * CGFloat(index), 0, CGRectGetWidth(frame), CGRectGetHeight(frame))
                let imageView = UIImageView.init(frame: imageFrame)
                imageView.tag = 100 + index
                imageView.backgroundColor = UIColor.groupTableViewBackgroundColor()
                imageView.userInteractionEnabled = true
    
                let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(WXCycleScrollView.imagePressed))
                imageView.addGestureRecognizer(tapGesture)
                
                self.scrollView.addSubview(imageView)
        }
        self.addSubview(self.scrollView)
        self.addSubview(self.pageControl)
        self.addSubview(self.waveView)
        
        self.resetTimer()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetTimer() {
        self.scrollTimer?.invalidate()
        self.scrollTimer = NSTimer.scheduledTimerWithTimeInterval(self.autoScrollTimeInterval, target: self, selector: #selector(scrollToNextImage), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(self.scrollTimer!, forMode: NSRunLoopCommonModes)
    }
    
    func scrollToNextImage() {
        UIView.animateWithDuration(0.3, animations: {
            let newOffset = self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame)
            self.scrollView.contentOffset.x = newOffset >= self.scrollView.contentSize.width ? 0 : newOffset
        }){ _ in
            self.pageControl.currentPage = Int(self.scrollView.contentOffset.x / CGRectGetWidth(self.frame))
        }
    }
    
    func imagePressed(sender: UITapGestureRecognizer) {
        self.delegate?.cycleScrollViewDidTapped!(self, index: sender.view!.tag - 100)
    }
    
    // MARK: - UIScrollViewDelegate
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.waveView.wave()
        self.scrollTimer?.invalidate()
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.waveView.wave()
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x / CGRectGetWidth(self.frame))
        self.resetTimer()
    }

}