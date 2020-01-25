//
//  OneLineSchimmerTableViewCell.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import UIKit

public class OneLineSchimmerTableViewCell: UITableViewCell {
    
    open class var cellIdentifier: String {
        return "cell.oneLineSchimmer"
    }
    
    private enum ViewTraits {
        static let containerViewInsets = UIEdgeInsets(top: 7, left: 15, bottom: 7, right: 15)
        static let imageInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        static let titleInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        static let imageSize: CGFloat = 50
        static let labelsSize: CGFloat = 20
        static let cornerRadius: CGFloat = 10
    }
        
    private let userImageView = UIImageView()
    let shimmerTitleLoader = LoaderView()
        
    private let containerView = UIView()
        
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        self.selectionStyle = .gray
            
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .appVeryLigthGrey
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = ViewTraits.cornerRadius
        addSubview(containerView)
            
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.backgroundColor = .appVeryLigthGrey
        userImageView.image = UIImage(named: "image_placeholder")
        userImageView.contentMode = .scaleAspectFill
        containerView.addSubview(userImageView)
            
        shimmerTitleLoader.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(shimmerTitleLoader)
        shimmerTitleLoader.startShimmering()
            
        setupConstraints()
    }
        
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    private func setupConstraints() {
            
        NSLayoutConstraint.activate([
                
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.containerViewInsets.left),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.containerViewInsets.right),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: ViewTraits.containerViewInsets.top),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTraits.containerViewInsets.bottom),
                
            userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTraits.imageInsets.left),
            userImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ViewTraits.imageInsets.top),
            userImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -ViewTraits.imageInsets.bottom),
            userImageView.heightAnchor.constraint(equalToConstant: ViewTraits.imageSize),
            userImageView.widthAnchor.constraint(equalToConstant: ViewTraits.imageSize),
                
            shimmerTitleLoader.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            shimmerTitleLoader.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: ViewTraits.titleInsets.left),
            shimmerTitleLoader.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTraits.titleInsets.right),
            shimmerTitleLoader.heightAnchor.constraint(equalToConstant: ViewTraits.labelsSize)
        ])
    }
        
    public override func prepareForReuse() {
            
        super.prepareForReuse()
        
        userImageView.image = UIImage(named: "photo_placeholder")
    }
}
