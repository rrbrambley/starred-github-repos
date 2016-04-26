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
    private var contributors = [String: OCTContributor]()
    
    let reuseIdentifier: String = "RepositoryCell"
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "repository_table_view:title".localized
        self.tableView.allowsSelection = false
        self.refreshControl!.beginRefreshing()
        
        fetchRepositories()
    }

    //MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return RepositoryTableViewCell.heightForCell()
    }
    
    //MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let repository: OCTRepository = repositories![indexPath.row]
        let cell: RepositoryTableViewCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RepositoryTableViewCell
        cell.nameLabel.text = repository.name
        cell.starCountLabel.text = String(repository.stargazersCount)
        
        if let contributor = contributors[repository.objectID] {
            cell.contributorNameLabel.text = contributor.name
            cell.contributorActivityIndicator.hidden = true
            cell.contributorActivityIndicator.stopAnimating()
        } else {
            cell.contributorActivityIndicator.startAnimating()
            cell.contributorActivityIndicator.hidden = false
        }
        
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
            
            for i in 0...repositories.count-1 {
                self.fetchContributors(repositories[i], index: i)
            }
        }
    }
    
    private func fetchContributors(repository: OCTRepository, index: Int) {
        GithubDataManager.sharedInstance.fetchContributors(repository, completion: { (contributors: Array<OCTContributor>) in
            let c: OCTContributor = contributors.first!
            self.contributors[repository.objectID] = c
            self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
            print("repository: \(repository.name); top contributor: \(c.login, c.contributions)")
        })
    }
}

