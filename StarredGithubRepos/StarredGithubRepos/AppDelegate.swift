//
//  AppDelegate.swift
//  StarredGithubRepos
//
//  Created by Robert Brambley on 4/23/16.
//  Copyright © 2016 AATT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK: Lifecycle
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //
        //Uncomment this to reset the auth params
        //
//        GithubAuthParams.clear()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        updateApplicationState()
        return true
    }

    //MARK: Public
    
    func updateApplicationState() {
        window?.rootViewController = UIStoryboard(name: GithubAuthParams.isLoggedIn() ? "Main" : "Login", bundle: nil).instantiateInitialViewController()
    }
    
    //MARK: Class
    
    class func sharedDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
}

