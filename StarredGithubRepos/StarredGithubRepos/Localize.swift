//
//  Localize.swift
//  StarredGithubRepos
//
//  Created by Robert Brambley on 4/25/16.
//  Copyright © 2016 AATT. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
}