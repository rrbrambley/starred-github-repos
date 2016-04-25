//
//  RepositoryTableViewCell.swift
//  StarredGithubRepos
//
//  Created by Robert Brambley on 4/24/16.
//  Copyright © 2016 AATT. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}