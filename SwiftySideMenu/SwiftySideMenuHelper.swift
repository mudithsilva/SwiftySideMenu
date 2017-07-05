//
//  SwiftySideMenuHelper.swift
//  SwiftySideMenu
//
//  Created by Mudith Chathuranga on 5/30/17.
//  Copyright © 2017 Mudith Chathuranga. All rights reserved.
//

import Foundation
import UIKit

public struct SwiftySideMenuHelper {
    
    //static let menuWidth:CGFloat = 0.8
    static let percentThreshold:CGFloat = 0.5
    static var currentMenuWidth: CGFloat!
    static var menuWidth: CGFloat!
    
    static func shouldCloseMenu() -> Bool {
        if self.currentMenuWidth >= self.menuWidth / 2 {
            return true
        } else {
            return false
        }
    }
    
}
