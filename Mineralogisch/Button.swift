//
//  Button.swift
//  Mineralogisch
//
//  Created by Jonathan Herrejón on 9/19/18.
//  Copyright © 2018 Jonathan Herrejón. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    static var x: Int!
    static var y: Int!
    
    static func getX() -> Int {
        return x
    } //end getX
    static func getY() -> Int {
        return y
    } //end getY
    static func setX(x: Int) {
        self.x = x
    }//end setX
    static func setY(y: Int) {
        self.y = y
    }//end setY
    
    
} //end class Button()
