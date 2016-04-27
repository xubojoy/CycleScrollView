//
//  ViewController.swift
//  WXCycleScrollView
//
//  Created by Welkin Xie on 4/18/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  Github: https://github.com/WelkinXie/WXCycleScrollView
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var cycleScrollView: WXCycleScrollView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let images: [String]
        
        // Local Image
        if view.tag == 11 {
            images = ["1", "2", "3"]
            cycleScrollView = WXCycleScrollView(frame: CGRectMake(0, 0, CGRectGetWidth(view.frame), 198), imageNames: images)
            cycleScrollView?.tag = 111;
        }
        // Web Image
        else {
            images = [
                "http://7xneqd.com1.z0.glb.clouddn.com/cycle1.png",
                "http://7xneqd.com1.z0.glb.clouddn.com/cycle2.png",
                "http://7xneqd.com1.z0.glb.clouddn.com/cycle3.png"
            ]
            cycleScrollView = WXCycleScrollView(frame: CGRectMake(0, 0, CGRectGetWidth(view.frame), 198), imageURLs: images, placeHolder: UIImage(named: "1"))
            cycleScrollView?.tag = 100;
        }
        cycleScrollView?.delegate = self
        tableView.tableHeaderView = cycleScrollView
        
        // Optional
//        cycleScrollView?.autoScrollTimeInterval = 4;
//        cycleScrollView?.waveColor = UIColor.lightGrayColor()
//        cycleScrollView?.needWave = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: WXCycleScrollViewDelegate {
    
    func cycleScrollViewDidTapped(cycleScrollView: WXCycleScrollView, index: Int) {
        
        let locate: String
        if cycleScrollView.tag == 111 {
            locate = "Local Image"
        } else {
            locate = "Web Image"
        }
        print("\(locate) index \(index) tapped.")
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(UITableViewCell.classForCoder()))
        cell?.textLabel?.text = String(format: "%li", indexPath.row)
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

