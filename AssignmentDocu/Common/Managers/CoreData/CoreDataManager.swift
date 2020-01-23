//
//  CoreDataManager.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 23/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager: CoreDataManageable {
    var containerName: ContainerName
    
    init(withContainerName containerName: ContainerName) {
        self.containerName = containerName
    }
    
}
