//
//  Carro.swift
//  Carros
//
//  Created by Andre Furquin on 1/1/15.
//  Copyright (c) 2015 Andre Furquim. All rights reserved.
//

import Foundation
import CoreData

class Carro: NSManagedObject {

    @NSManaged var desc: String
    @NSManaged var latitude: String
    @NSManaged var longitude: String
    @NSManaged var nome: String
    @NSManaged var timestamp: NSDate
    @NSManaged var tipo: String
    @NSManaged var url_foto: String
    @NSManaged var url_info: String
    @NSManaged var url_video: String

}
