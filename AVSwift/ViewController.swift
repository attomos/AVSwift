//
//  ViewController.swift
//  AVSwift
//
//  Created by Nattaphoom Ch. on 6/4/14.
//  Copyright (c) 2014 nil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let kScreenWidth = UIScreen.mainScreen().bounds.width
    let kScreenHeight = UIScreen.mainScreen().bounds.height

    @lazy var label: UILabel = {
        let l = UILabel(frame: CGRectMake(100, 100, 300, 20))
        l.textColor = UIColor.blackColor()
        l.text = "ちょっと。。。"
        l.textAlignment = NSTextAlignment.Center
        l.layer.borderColor = UIColor.blackColor().CGColor
        l.layer.borderWidth = 1.0
        // TODO: change to constraint
        l.center = CGPointMake(self.kScreenWidth / 2, self.kScreenHeight / 2)
        return l
    }()
    
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var addButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "reloadZen")
        self.navigationItem.rightBarButtonItem = addButton
        self.view.addSubview(label)
        reloadZen()
    }

    func reloadZen() {
        if isLoading == true {
            return
        }
        isLoading = true
        var app = UIApplication.sharedApplication()
        app.networkActivityIndicatorVisible = isLoading
        self.navigationItem.rightBarButtonItem.enabled = !isLoading
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/plain")
        manager.GET("https://api.github.com/zen", parameters: nil,
            success: { (task: NSURLSessionDataTask!, responseObject: AnyObject!) in
                let responseString = NSString(data: responseObject as NSData, encoding: NSUTF8StringEncoding)
                dispatch_async(dispatch_get_main_queue(), {
                    self.label.text = responseString
                    self.label.textAlignment = NSTextAlignment.Center
                    self.label.numberOfLines = 0
//                    self.label.sizeToFit()
                    self.label.center = CGPointMake(self.kScreenWidth / 2, self.kScreenHeight / 2)
                    self.isLoading = false
                    self.navigationItem.rightBarButtonItem.enabled = !self.isLoading
                    app.networkActivityIndicatorVisible = self.isLoading
                })
            },
            failure: { (task: NSURLSessionDataTask!, error: NSError!) in
                println(error)
            })
    }
}