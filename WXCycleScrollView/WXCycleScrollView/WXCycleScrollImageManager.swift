//
//  WXCycleScrollImageManager.swift
//  WXCycleScrollView
//
//  Created by Welkin Xie on 4/19/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  Github: https://github.com/WelkinXie/WXCycleScrollView
//

import Foundation
import UIKit

let kWXCycleScrollViewDownloadPath = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as AnyObject).stringByAppendingPathComponent("com.welkinx.WXCycleScrollViewCache") as AnyObject

class WXCycleScrollImageManager: NSObject {
    
    class func isImageExisted(URLString: String) -> Bool {
        let fileManager = NSFileManager.defaultManager()
        let imagePath = kWXCycleScrollViewDownloadPath.stringByAppendingPathComponent(imageKey(URLString))
        if fileManager.fileExistsAtPath(imagePath) {
            return true
        }
        return false
    }

    class func downloadImage(URLString: String, completion: (image: UIImage) -> Void) {
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(NSURL(string: URLString)!, completionHandler: { (data, response, error) in
            
            if data == nil {
                return
            }
            let downloadedImage = UIImage(data: data!)
            if downloadedImage == nil {
                return
            }
            completion(image: downloadedImage!)

            let imagePath = kWXCycleScrollViewDownloadPath.stringByAppendingPathComponent(imageKey(URLString))
            
            if (!NSFileManager.defaultManager().fileExistsAtPath(kWXCycleScrollViewDownloadPath as! String)) {
                do {
                    try NSFileManager.defaultManager().createDirectoryAtPath(kWXCycleScrollViewDownloadPath as! String, withIntermediateDirectories: false, attributes: nil)
                } catch {
                    return
                }
            }
            data?.writeToFile(imagePath, atomically: true)
        })
        task.resume()
    }
    
    class func imageKey(str: String) -> String {
        let data = (str as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))
        let resultBytes = UnsafeMutablePointer<CUnsignedChar>(result!.mutableBytes)
        CC_MD5(data!.bytes, CC_LONG(data!.length), resultBytes)
        
        let a = UnsafeBufferPointer<CUnsignedChar>(start: resultBytes, count: result!.length)
        let hash = NSMutableString()
        
        for i in a {
            hash.appendFormat("%02x", i)
        }
        
        return hash as String
    }

}
