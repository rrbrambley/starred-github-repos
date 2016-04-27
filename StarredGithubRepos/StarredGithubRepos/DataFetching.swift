//
//  DataFetching.swift
//  StarredGithubRepos
//
//  Created by Robert Brambley on 4/27/16.
//  Copyright © 2016 AATT. All rights reserved.
//

import Foundation
import OctoKit

protocol DataFetching {
    func fetchStarredRepositories(completion: (Array<OCTRepository> -> Void)!)
    func fetchContributors(repository: OCTRepository, completion: (Array<OCTContributor> -> Void)!)
}