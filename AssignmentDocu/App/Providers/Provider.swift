//
//  Provider.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 23/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import UIKit.UIApplication

protocol Provider {
    var genericCoreData: CoreDataManageable { get }
}

var provider: Provider { return UIApplication.provider }

class AppProvider: Provider {
    
    lazy var genericCoreData: CoreDataManageable = {
        return CoreDataManager(withContainerName: CoreDataContainerNames.generic)
    }()
}
