//
//  ImageOneLineTableViewCell.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 25/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import UIKit

public class ImageOneLineTableViewCell: UITableViewCell {
    
    open class var cellIdentifier: String {
        return "cell.oneLineCell"
    }
    
    private enum ViewTraits {
        static let containerViewInsets = UIEdgeInsets(top: 7, left: 15, bottom: 7, right: 15)
        static let containerInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        static let imageInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        static let titleInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        static let imageSize: CGFloat = 50
        static let cornerRadius: CGFloat = 10
    }
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    public var leftImage: UIImage? {
        set { userImageView.image = newValue }
        get { return userImageView.image }
    }
    
    private let labelsContainer = UIView()
    
    private let titleLabel: Label = {
        let lbl = Label()
        lbl.textColor = .black
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
    
    private let containerView = UIView()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .default
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .appLigthGrey
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = ViewTraits.cornerRadius
        addSubview(containerView)
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.backgroundColor = .appLigthGrey
        userImageView.contentMode = .scaleAspectFill
        containerView.addSubview(userImageView)
        
        labelsContainer.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(labelsContainer)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelsContainer.addSubview(titleLabel)
        
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
            
            userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTraits.containerInsets.left),
            userImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ViewTraits.containerInsets.top),
            userImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -ViewTraits.containerInsets.bottom),
            userImageView.heightAnchor.constraint(equalToConstant: ViewTraits.imageSize),
            userImageView.widthAnchor.constraint(equalToConstant: ViewTraits.imageSize),
            
            labelsContainer.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: ViewTraits.imageInsets.left),
            labelsContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTraits.containerInsets.right),
            labelsContainer.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            labelsContainer.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: ViewTraits.containerInsets.top),
            labelsContainer.bottomAnchor.constraint(greaterThanOrEqualTo: containerView.bottomAnchor, constant: -ViewTraits.containerInsets.bottom),
            
            titleLabel.centerYAnchor.constraint(equalTo: labelsContainer.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor, constant: ViewTraits.titleInsets.left),
            titleLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor, constant: -ViewTraits.titleInsets.right)
            ])
    }
    
    public override func prepareForReuse() {
        
        super.prepareForReuse()
        
        leftImage = nil
        
        title = nil
        titleColor = .black
    }
}
