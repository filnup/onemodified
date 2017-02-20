//
//  RandomFunction.swift
//  onemodified
//
//  Created by Phil Rosenberger on 2/20/17.
//  Copyright © 2017 onehelloworld. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat{
    
    public static func random() -> CGFloat{
        
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
        
    }
    
    public static func random(min min : CGFloat, max : CGFloat) -> CGFloat{
        
        return CGFloat.random() * (max - min) + min
        
    }
    
}
