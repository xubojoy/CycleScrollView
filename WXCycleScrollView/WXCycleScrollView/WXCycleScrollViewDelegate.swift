
//
//  WXCycleScrollViewDelegate.swift
//  WXCycleScrollView
//
//  Created by Welkin Xie on 4/19/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//

import Foundation

@objc protocol WXCycleScrollViewDelegate {
    optional func cycleScrollViewDidTapped(cycleScrollView: WXCycleScrollView, index: Int)
}