//
//  Button.swift
//  Mineralogisch
//
//  Created by Jonathan Herrejón on 9/19/18.
//  Copyright © 2018 Jonathan Herrejón. All rights reserved.
//

import UIKit

class Button: UIButton {
    var x: Int!
    var y: Int!

    public func getX() -> Int {
        return x
    } // end getX

    public func getY() -> Int {
        return y
    } // end getY

    public func setX(x: Int) {
        self.x = x
    } // end setX

    public func setY(y: Int) {
        self.y = y
    } // end setY
}
