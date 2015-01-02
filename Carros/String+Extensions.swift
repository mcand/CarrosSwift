//
//  String+Extensions.swift
//  Carros
//
//  Created by Andre Furquin on 1/2/15.
//  Copyright (c) 2015 Andre Furquim. All rights reserved.
//

import Foundation

extension String{
    func trim() -> String{
        return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    func url() -> NSURL {
        return NSURL(string: self)!
    }
}
