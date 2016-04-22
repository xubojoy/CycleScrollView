//
//  ViewController.swift
//  WXCycleScrollView
//
//  Created by Welkin Xie on 4/18/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WXCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var cycleScrollView : WXCycleScrollView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let images : [String]
        
        // Local Image
        if self.view.tag == 11 {
            images = ["1", "2", "3"]
            self.cycleScrollView = WXCycleScrollView.init(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 198), imageNames: images)
            self.cycleScrollView?.tag = 111;
        }
        // Web Image
        else {
            images = [
                "http://7xneqd.com1.z0.glb.clouddn.com/cycle1.png",
                "http://7xneqd.com1.z0.glb.clouddn.com/cycle2.png",
                "http://7xneqd.com1.z0.glb.clouddn.com/cycle3.png"
            ]
            self.cycleScrollView = WXCycleScrollView.init(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 198), imageURLs: images, placeHolder: UIImage.init(named: "1"))
            self.cycleScrollView?.tag = 100;
        }
        self.cycleScrollView?.delegate = self
        self.tableView.tableHeaderView = cycleScrollView
        
        // Optional
//        self.cycleScrollView?.autoScrollTimeInterval = 4;
//        self.cycleScrollView?.waveColor = UIColor.lightGrayColor()
//        self.cycleScrollView?.needWave = false
    }
    
    // MARK: - WXCycleScrollViewDelegate
    func cycleScrollViewDidTapped(cycleScrollView: WXCycleScrollView, index: Int) {
        let locate : String
        if cycleScrollView.tag == 111 {
            locate = "Local Image"
        } else {
            locate = "Web Image"
        }
        print("\(locate) index \(index) tapped.")
    }
    
    // MARK: - UITableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(UITableViewCell.classForCoder()))
        cell?.textLabel?.text = String.init(format: "%li", indexPath.row)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

