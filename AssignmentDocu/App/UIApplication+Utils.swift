//
//  UIApplication+Utils.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 23/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import UIKit.UIApplication

extension UIApplication {
    
    static func appDelegate() -> AppDelegate {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            return delegate
        } else {
            fatalError("UIApplication.shared.delegate isn't instance of AppDelegate")
        }
    }
    
    static var provider: Provider = {
        return appDelegate().provider
    }()
    
}
