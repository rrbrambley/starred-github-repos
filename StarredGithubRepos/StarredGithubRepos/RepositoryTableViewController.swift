//
//  ViewController.swift
//  StarredGithubRepos
//
//  Created by Robert Brambley on 4/23/16.
//  Copyright © 2016 AATT. All rights reserved.
//

import OctoKit
import UIKit

class RepositoryTableViewController: UITableViewController {

    private var repositories: Array<OCTRepository>?
    
    let reuseIdentifier: String = "RepositoryCell"
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "repository_table_view:title".localized
        self.tableView.registerNib(UINib.init(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        self.refreshControl!.beginRefreshing()
        
        fetchRepositories()
    }

    //MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let repository: OCTRepository = repositories![indexPath.row]
        let cell: RepositoryTableViewCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RepositoryTableViewCell
        cell.nameLabel.text = repository.name
        cell.starCountLabel.text = String(repository.stargazersCount)
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories == nil ? 0 : self.repositories!.count
    }
    
    //MARK: Internal
    
    private func fetchRepositories() {
        GithubDataManager.sharedInstance.fetchStarredRepositories { (repositories: Array<OCTRepository>) in
            self.refreshControl?.endRefreshing()
            self.repositories = repositories
            self.tableView.reloadData()
            
            for r in repositories {
                self.fetchContributors(r)
            }
        }
    }
    
    private func fetchContributors(repository: OCTRepository) {
        GithubDataManager.sharedInstance.fetchContributors(repository, completion: { (contributors: Array<OCTContributor>) in
            let c: OCTContributor = contributors.first!
            print("repository: \(repository.name); top contributor: \(c.login, c.contributions)")
        })
    }
}

