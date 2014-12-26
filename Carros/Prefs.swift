//
//  Prefs.swift
//  Carros
//
//  Created by Andre Furquin on 12/26/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import Foundation

class Prefs{
    class func setString(valor: String, chave: String){
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setValue(valor, forKey: chave)
        prefs.synchronize()
    }
    class func getString(chave: String) -> String! {
        let prefs = NSUserDefaults.standardUserDefaults()
        var s = prefs.stringForKey(chave)
        return s
    }
    class func setInt(valor: Int, chave: String) {
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setInteger(valor, forKey: chave)
        prefs.synchronize()
    }
    class func getInt(chave: String) -> Int! {
        let prefs = NSUserDefaults.standardUserDefaults()
        var s = prefs.integerForKey(chave)
        return s
    }
}
