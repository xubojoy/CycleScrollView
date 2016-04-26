//
//  WXCycleScrollImageView.swift
//  WXCycleScrollView
//
//  Created by MacMini-bt08 on 16/4/20.
//  Copyright © 2016年 WelkinXie. All rights reserved.
//
//  Github: https://github.com/WelkinXie/WXCycleScrollView
//

import UIKit

extension UIImageView {
    
    func setWebImage(URLString: String) {
        WXCycleScrollImageManager.downloadImage(URLString) { (image) in
            dispatch_async(dispatch_get_main_queue(), {
                self.image = image
            })
        }
    }
    
    func setCachedImage(URLString: String) {
        let imagePath = WXCycleScrollViewDownloadPath.stringByAppendingPathComponent(WXCycleScrollImageManager.imageKey(URLString))
        let imageData = NSData(contentsOfFile: imagePath)
        self.image = UIImage(data: imageData!)
    }
}