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
        GithubDataManager.sharedInstance.fetchStarredRepositories { (repositories: Array<OCTRepository>) in
            for repository in repositories {
                print("repository: \(repository.name) \(repository.stargazersCount)")
            }
        }
    }
}

