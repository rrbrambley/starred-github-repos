//
//  RepositoryTableViewCell.swift
//  StarredGithubRepos
//
//  Created by Robert Brambley on 4/24/16.
//  Copyright © 2016 AATT. All rights reserved.
//

import PureLayout
import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel!
    var starCountLabel: UILabel!
    var topContributorLabel: UILabel!
    var contributorNameLabel: UILabel!
    var contributorActivityIndicator: UIActivityIndicatorView!
    
    struct Constants {
        static let verticalEdges: CGFloat = 16
        static let horizontalEdges: CGFloat = 16
        static let verticalSpacing: CGFloat = 32
        static let horizontalSpacing: CGFloat = 32
        static let fontSize: CGFloat = 14
    }
    
    //MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    //MARK: Internal
    
    private func setupUI() {
        nameLabel = UILabel(frame: CGRectZero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        nameLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: contentView, withOffset: Constants.horizontalEdges)
        nameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: contentView, withOffset: Constants.horizontalEdges)
        
        starCountLabel = UILabel(frame: CGRectZero)
        starCountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(starCountLabel)
        starCountLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: contentView, withOffset: -Constants.horizontalEdges)
        starCountLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: contentView, withOffset: Constants.horizontalEdges)
        
        topContributorLabel = UILabel(frame: CGRectZero)
        topContributorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topContributorLabel)
        topContributorLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: contentView, withOffset: Constants.horizontalEdges)
        topContributorLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: nameLabel, withOffset: Constants.verticalSpacing)
        topContributorLabel.text = "repository_cell:contributor".localized
        
        contributorNameLabel = UILabel(frame: CGRectZero)
        contributorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contributorNameLabel)
        contributorNameLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: contentView, withOffset: -Constants.horizontalEdges)
        contributorNameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: starCountLabel, withOffset: Constants.verticalSpacing)
        
        contributorActivityIndicator = UIActivityIndicatorView(frame: CGRectZero)
        contributorActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contributorActivityIndicator)
        contributorActivityIndicator.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: contentView, withOffset: -Constants.horizontalEdges)
        contributorActivityIndicator.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: starCountLabel, withOffset: Constants.verticalSpacing)
        contributorActivityIndicator.color = UIColor.blueColor()
        
        nameLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: starCountLabel, withOffset: Constants.horizontalSpacing)
        topContributorLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: contributorActivityIndicator, withOffset: Constants.horizontalSpacing)
    }
    
    static func heightForCell() -> CGFloat {
        let string: NSString = "repository_cell:contributor".localized as NSString
        let size: CGSize = string.sizeWithAttributes([NSFontAttributeName: fontForLabel()])
        return (Constants.verticalEdges * 2) + Constants.verticalSpacing + (size.height * 2)
    }
    
    static func fontForLabel() -> UIFont {
        return UIFont.systemFontOfSize(Constants.fontSize)
    }
}