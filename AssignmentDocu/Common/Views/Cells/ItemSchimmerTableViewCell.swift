//
//  ItemSchimmerTableViewCell.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import UIKit

public class ItemSchimmerTableViewCell: UITableViewCell {
    
    open class var cellIdentifier: String {
        return "cell.itemSchimmer"
    }
    
    private enum ViewTraits {
        static let containerViewInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let innerLabelsSpacing: CGFloat = 5
        static let labelsSize: CGFloat = 20
    }
        
    let shimmerTitleLoader = LoaderView()
    let shimmerSubtitleLoader = LoaderView()
        
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        self.selectionStyle = .gray
            
        shimmerTitleLoader.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shimmerTitleLoader)
        shimmerTitleLoader.startShimmering()
        
        shimmerSubtitleLoader.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shimmerSubtitleLoader)
        shimmerSubtitleLoader.startShimmering()
            
        setupConstraints()
    }
        
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    private func setupConstraints() {
            
        NSLayoutConstraint.activate([
            shimmerTitleLoader.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewTraits.containerViewInsets.top),
            shimmerTitleLoader.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewTraits.containerViewInsets.left),
            shimmerTitleLoader.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewTraits.containerViewInsets.right),
            shimmerTitleLoader.heightAnchor.constraint(equalToConstant: ViewTraits.labelsSize),
            
            shimmerSubtitleLoader.topAnchor.constraint(greaterThanOrEqualTo: shimmerTitleLoader.bottomAnchor, constant: ViewTraits.innerLabelsSpacing),
            shimmerSubtitleLoader.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewTraits.containerViewInsets.left),
            shimmerSubtitleLoader.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewTraits.containerViewInsets.right),
            shimmerSubtitleLoader.heightAnchor.constraint(equalToConstant: ViewTraits.labelsSize),
            shimmerSubtitleLoader.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -ViewTraits.containerViewInsets.bottom)
        ])
    }
}
