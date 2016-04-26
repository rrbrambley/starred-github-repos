//
//  GithubAuthParams.swift
//  StarredGithubRepos
//
//  Created by Robert Brambley on 4/24/16.
//  Copyright © 2016 AATT. All rights reserved.
//

import Locksmith

class GithubAuthParams {
    static let keychainServiceName = "tt.aa.StarredGithubRepos"
    static let keyAuthToken = "authToken"
    static let keyUsername = "username"
    static let account = "StarredGithubRepos"
    
    private class func userData() -> ([String: AnyObject]?) {
        return Locksmith.loadDataForUserAccount(account, inService: keychainServiceName)
    }
    
    class func isLoggedIn() -> Bool {
        let dictionary: [String: AnyObject]? = userData()
        if(dictionary != nil) {
            return dictionary![keyAuthToken] != nil
        } else {
            return false
        }
    }
    
    class func authParams() -> (username: String, token: String)? {
        let dictionary: [String: AnyObject]? = userData()
        if(dictionary != nil) {
            return (dictionary![keyUsername] as! String, dictionary![keyAuthToken] as! String)
        } else {
            return nil
        }
    }
    
    class func save(token: String, username: String) {
        do {
            try Locksmith.saveData([keyAuthToken : token, keyUsername : username], forUserAccount: account)
        } catch {
            print(error)
        }
    }
    
    class func clear() {
        do {
            try Locksmith.deleteDataForUserAccount(account)
        } catch {
            print(error)
        }
    }
}