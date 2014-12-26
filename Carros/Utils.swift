//
//  Utils.swift
//  Carros
//
//  Created by Andre Furquim on 7/5/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import UIKit

class Utils {
    
    class func isIphone() -> Bool {
        var iPhone = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
        return iPhone
    }
    
    class func isIpad() -> Bool {
        var iPad = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
        return iPad
    }
    
    class func isLandscape() -> Bool {
        let orientation = UIDevice.currentDevice().orientation
        let landscape = orientation == UIDeviceOrientation.LandscapeLeft || orientation == UIDeviceOrientation.LandscapeRight
        return landscape
    }
    
    class func isPortrait() -> Bool {
        let orientation = UIDevice.currentDevice().orientation
        let portrait = orientation == UIDeviceOrientation.Portrait
        return portrait
    }
}