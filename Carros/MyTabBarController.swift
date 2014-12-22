//
//  MyTabBarController.swift
//  Carros
//
//  Created by Andre Furquin on 12/22/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import UIKit

class MyTabBarController : UITabBarController {
    override func supportedInterfaceOrientations() -> Int {
       return self.selectedViewController!.supportedInterfaceOrientations()
    }
}
