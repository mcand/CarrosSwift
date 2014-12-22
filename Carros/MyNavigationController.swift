//
//  MyNavigationController.swift
//  Carros
//
//  Created by Andre Furquin on 12/22/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {
    override func supportedInterfaceOrientations() -> Int {
        // Delega para o view controller atual (e o ultimo do array)
        return self.topViewController!.supportedInterfaceOrientations()
    }
}
