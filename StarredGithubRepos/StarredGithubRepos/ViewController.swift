//
//  ViewController.swift
//  StarredGithubRepos
//
//  Created by Robert Brambley on 4/23/16.
//  Copyright © 2016 AATT. All rights reserved.
//

import OctoKit
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchStarredRepositories { (repositories: Array<OCTRepository>) in
            for repository in repositories {
                print("repository: \(repository.name) \(repository.stargazersCount)")
            }
        }
    }

    func fetchStarredRepositories(completion: (Array<OCTRepository> -> Void)!) {
        let user:OCTUser = OCTUser.init(rawLogin: "login", server: OCTServer.dotComServer())
        let client:OCTClient = OCTClient.unauthenticatedClientWithUser(user)
        
        var repositories:Array<OCTRepository> = Array<OCTRepository>()
    
        client.searchRepositoriesWithQuery("stars:>0", orderBy:"stars", ascending:false).subscribeNext(
            { (repositorySearchResults: AnyObject!) -> Void in
                repositories.appendContentsOf(repositorySearchResults.repositories as! Array)//(repository as? OCTRepository)!)
            },
            error: { (error: NSError!) -> Void in
                NSLog(error.localizedDescription)
            },
            completed: {
                if(completion != nil) {
                    completion(repositories)
                }
            }
        );
    }
}

