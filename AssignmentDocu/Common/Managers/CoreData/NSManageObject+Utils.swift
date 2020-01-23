//
//  NSManageObject+Utils.swift
//  AssignmentDocu
//
//  Created by Iglesias, Gustavo on 23/01/2020.
//  Copyright © 2020 Gustavo Iglesias. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    static var entityName: String { return String(describing: self) }

}
