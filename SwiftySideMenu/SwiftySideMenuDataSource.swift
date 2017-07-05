//
//  SwiftySideMenuDataSource.swift
//  SwiftySideMenu
//
//  Created by Mudith Chathuranga on 5/30/17.
//  Copyright © 2017 Mudith Chathuranga. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol SwiftySideMenuDataSource: NSObjectProtocol {
    
    @objc func menuNavigationTabs(_ tableView: UITableView) -> [SwiftySideMenuChildViewControllers]
    
    @objc optional func menuNavigationTabs(_ tableView: UITableView, backgroundColorFor cell: SwiftySideMenuTableViewCell, indexPath: IndexPath) -> UIColor
    
    @objc optional func menuNavigationTabs(backgroundImagefor menuView: UIView) -> UIImage!
    
    @objc optional func menuNavigationTabs(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    
    @objc optional func menuNavigationTabs(subviewFor sideMenuTopBanner: UIView) -> UIView
    
}
