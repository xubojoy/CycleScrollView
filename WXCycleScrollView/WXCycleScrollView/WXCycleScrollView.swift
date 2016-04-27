//
//  WXCycleScrollView.swift
//  WXCycleScrollView
//
//  Created by Welkin Xie on 4/18/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  Github: https://github.com/WelkinXie/WXCycleScrollView
//

import UIKit

public class WXCycleScrollView: UIView {
    
    let scrollView: UIScrollView
    let pageControl: UIPageControl
    var delegate: WXCycleScrollViewDelegate?
    
    private var waveView: WXCycleScrollWaveView
    private var scrollTimer: NSTimer?
    
    var autoScrollTimeInterval = 3.0 {
        didSet(newScrollTime) {
            resetTimer()
        }
    }
    
    var waveColor = UIColor.whiteColor() {
        didSet(newWaveColor) {
            waveView.waveColor = waveColor.CGColor
        }
    }
    
    var needWave = true {
        didSet(newNeed) {
            waveView.hidden = !needWave
            pageControl.frame = CGRect(x: 0, y: CGRectGetHeight(frame) - (needWave ? 28 : 20), width: CGRectGetWidth(frame), height: 15)
        }
    }
    
    public convenience init(frame: CGRect, imageURLs: Array<String>, placeHolder: UIImage?) {
        self.init(frame: frame, imageCount: imageURLs.count)
        
        var index = 0
        for subview in scrollView.subviews {
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
        for subview in scrollView.subviews {
            if subview.isMemberOfClass(UIImageView) {
                let imageView = subview as! UIImageView
                imageView.image = UIImage(named: imageNames[index])
            }
            index += 1
        }
    }
    
    private init(frame: CGRect, imageCount: Int) {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(frame), height: CGRectGetHeight(frame)))
        pageControl = UIPageControl(frame: CGRect(x: 0, y: CGRectGetHeight(frame) - 28, width: CGRectGetWidth(frame), height: 15))
        waveView = WXCycleScrollWaveView(frame: CGRect(x: 0, y: CGRectGetHeight(frame) - 9, width: CGRectGetWidth(frame), height: 10))

        super.init(frame: frame)
                
        let width = CGRectGetWidth(frame) * CGFloat(imageCount)
        let realFrame = CGRect(x: CGRectGetMinX(frame), y: CGRectGetMinY(frame), width: width, height: CGRectGetHeight(frame))
        
        scrollView.delegate = self
        scrollView.contentSize = realFrame.size
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        pageControl.numberOfPages = imageCount
        pageControl.currentPage = 0
        
        for index in 0 ..< imageCount {
            let imageFrame = CGRect(x: CGRectGetWidth(frame) * CGFloat(index), y: 0, width: CGRectGetWidth(frame), height: CGRectGetHeight(frame))
                let imageView = UIImageView(frame: imageFrame)
                imageView.tag = 100 + index
                imageView.backgroundColor = UIColor.groupTableViewBackgroundColor()
                imageView.userInteractionEnabled = true
    
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(WXCycleScrollView.imagePressed))
                imageView.addGestureRecognizer(tapGesture)
                
                scrollView.addSubview(imageView)
        }
        addSubview(scrollView)
        addSubview(pageControl)
        addSubview(waveView)
        
        resetTimer()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetTimer() {
        scrollTimer?.invalidate()
        scrollTimer = NSTimer.scheduledTimerWithTimeInterval(autoScrollTimeInterval, target: self, selector: #selector(scrollToNextImage), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(scrollTimer!, forMode: NSRunLoopCommonModes)
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
        delegate?.cycleScrollViewDidTapped!(self, index: sender.view!.tag - 100)
    }

}

extension WXCycleScrollView: UIScrollViewDelegate {
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        waveView.wave()
        scrollTimer?.invalidate()
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        waveView.wave()
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGRectGetWidth(frame))
        resetTimer()
    }
    
}
