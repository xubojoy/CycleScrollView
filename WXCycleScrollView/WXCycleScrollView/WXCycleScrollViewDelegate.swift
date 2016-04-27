
//
//  WXCycleScrollViewDelegate.swift
//  WXCycleScrollView
//
//  Created by Welkin Xie on 4/19/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  Github: https://github.com/WelkinXie/WXCycleScrollView
//

import Foundation

@objc protocol WXCycleScrollViewDelegate {
    
    optional func cycleScrollViewDidTapped(cycleScrollView: WXCycleScrollView, index: Int)

}