//
//  Arrays+.swift
//  Psychics
//
//  Created by Wellington Moreno on 1/27/17.
//  Copyright © 2017 Wellington Moreno. All rights reserved.
//

import Foundation

extension Array {
    
    var notEmpty: Bool { return !isEmpty }
    
    var anyElement: Element? {
        
        let index = Int(arc4random_uniform(UInt32(count)))
        
        guard index >= 0 && index < count else { return first }
        return self[index]
    }
    
    var last: Element? {
        guard notEmpty else { return nil }
        
        let index = count - 1
        return self[index]
    }
}
