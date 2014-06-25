//
//  AppDelegate.swift
//  AVSwift
//
//  Created by Nattaphoom Ch. on 6/4/14.
//  Copyright (c) 2014 nil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    @lazy var window: UIWindow = {
        let win = UIWindow(frame: UIScreen.mainScreen().bounds)
        win.backgroundColor = UIColor.whiteColor()
        win.rootViewController = UINavigationController(rootViewController: ViewController())
        return win
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        window.makeKeyAndVisible()
        return true
    }
}