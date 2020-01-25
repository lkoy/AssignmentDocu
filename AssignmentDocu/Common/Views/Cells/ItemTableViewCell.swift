//
//  ItemTableViewCell.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import UIKit

public class ItemTableViewCell: UITableViewCell {
    
    open class var cellIdentifier: String {
        return "cell.item"
    }
    
    private enum ViewTraits {
        static let containerInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let innerLabelsSpacing: CGFloat = 10
        static let imageSize: CGFloat = 50
    }
    
    private let labelsContainer = UIView()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .appBlack
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textAlignment = .left
        return lbl
    }()
    public var title: String? {
        set { titleLabel.text = newValue }
        get { return titleLabel.text }
    }
    public var titleColor: UIColor {
        set { titleLabel.textColor = newValue }
        get { return titleLabel.textColor }
    }
    
    private let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .appDarkGrey
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textAlignment = .left
        return lbl
    }()
    public var subtitle: String? {
        set { subtitleLabel.text = newValue }
        get { return subtitleLabel.text }
    }
    public var subTitleColor: UIColor {
        set { subtitleLabel.textColor = newValue }
        get { return subtitleLabel.textColor }
    }
    
    private let issuesLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .appDarkGrey
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .right
        return lbl
    }()
    public var issues: String? {
        set { issuesLabel.text = newValue }
        get { return issuesLabel.text }
    }
    public var issuesColor: UIColor {
        set { issuesLabel.textColor = newValue }
        get { return issuesLabel.textColor }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        labelsContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelsContainer)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        labelsContainer.addSubview(titleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        subtitleLabel.numberOfLines = 1
        labelsContainer.addSubview(subtitleLabel)
        
        issuesLabel.translatesAutoresizingMaskIntoConstraints = false
        issuesLabel.numberOfLines = 1
        issuesLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        labelsContainer.addSubview(issuesLabel)
        
        setupConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            labelsContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewTraits.containerInsets.top),
            labelsContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewTraits.containerInsets.left),
            labelsContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewTraits.containerInsets.right),
            labelsContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -ViewTraits.containerInsets.bottom),
            
            titleLabel.topAnchor.constraint(equalTo: labelsContainer.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: issuesLabel.leadingAnchor, constant: -ViewTraits.innerLabelsSpacing),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ViewTraits.innerLabelsSpacing),
            subtitleLabel.bottomAnchor.constraint(equalTo: labelsContainer.bottomAnchor),
            
            issuesLabel.topAnchor.constraint(equalTo: subtitleLabel.topAnchor),
            issuesLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor)
            ])
    }
    
    public override func prepareForReuse() {
        
        super.prepareForReuse()
        
        title = nil
        titleColor = .black
        
        subtitle = nil
        subTitleColor = .black
        
        issues = nil
        issuesColor = .black
        
    }
}
