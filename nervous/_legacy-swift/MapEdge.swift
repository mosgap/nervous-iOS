//
//  MapEdge.swift
//  nervous
//
//  Created by Sam Sulaimanov on 10/11/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc(MapEdge)
class MapEdge: NSManagedObject {
   
    @NSManaged var id: NSNumber?
    @NSManaged var source_uuid: NSString?
    @NSManaged var target_uuid: NSString?
    @NSManaged var weight: NSNumber?
    @NSManaged var timestamp: NSNumber?
    @NSManaged var level: NSNumber?

    
}