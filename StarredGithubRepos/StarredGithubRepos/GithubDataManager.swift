//
//  GithubDataManager.swift
//  StarredGithubRepos
//
//  Created by Robert Brambley on 4/24/16.
//  Copyright © 2016 AATT. All rights reserved.
//

import Foundation
import OctoKit

class GithubDataManager {
    static let sharedInstance = GithubDataManager()
    
    private var client: OCTClient?
    
    init() {
        let user: OCTUser = OCTUser.init(rawLogin: "login", server: OCTServer.dotComServer())
        client = OCTClient.unauthenticatedClientWithUser(user)
    }

    func fetchStarredRepositories(completion: (Array<OCTRepository> -> Void)!) {
        var repositories: Array<OCTRepository> = Array<OCTRepository>()
        
        client!.searchRepositoriesWithQuery("stars:>0", orderBy:"stars", ascending:false).subscribeNext(
            { (repositorySearchResults: AnyObject!) -> Void in
                repositories.appendContentsOf(repositorySearchResults.repositories as! Array)//(repository as? OCTRepository)!)
            },
            error: { (error: NSError!) -> Void in
                print(error.localizedDescription)
            },
            completed: {
                if(completion != nil) {
                    completion(repositories)
                }
            }
        );
    }
}