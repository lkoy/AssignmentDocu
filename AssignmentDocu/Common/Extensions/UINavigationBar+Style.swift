//
//  UINavigationBar+Style.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 23/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import UIKit.UINavigationBar

extension UINavigationBar {
    
    public func applyStyle() {
        
        barStyle = .default
        isTranslucent = true
        isOpaque = true
        backgroundColor = .white
        tintColor = .appBlack
    }
}
