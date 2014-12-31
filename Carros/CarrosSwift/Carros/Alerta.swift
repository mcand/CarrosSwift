//
//  Alerta.swift
//  Carros
//
//  Created by Andre Furquin on 12/21/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import UIKit

class Alerta {
    class func alerta(msg : String, viewController: UIViewController) {
        var alert = UIAlertController(title: "Alerta", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
}
