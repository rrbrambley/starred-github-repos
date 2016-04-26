//
//  GithubClientUtility.swift
//  StarredGithubRepos
//
//  Created by Robert Brambley on 4/25/16.
//  Copyright © 2016 AATT. All rights reserved.
//

import Foundation

class GithubClientUtility {
    class func clientID() -> String {
        return secretsDictionary().objectForKey("GithubClientID") as! String
    }
    
    class func clientSecret() -> String {
        return secretsDictionary().objectForKey("GithubClientSecret") as! String
    }
    
    class func clientIDAndSecret() -> (clientID: String, clientSecret: String) {
        return (clientID(), clientSecret())
    }
    
    private class func secretsDictionary() -> NSDictionary {
        return NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Secrets", ofType: "plist")!)!
    }
}