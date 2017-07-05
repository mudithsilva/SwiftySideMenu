//
//  SwiftySideMenuImageView.swift
//  navigationTest
//
//  Created by Mudith Chathuranga on 5/30/17.
//  Copyright © 2017 Mudith Chathuranga. All rights reserved.
//

import UIKit

public class SwiftySideMenuImageView: UIView {
    
    @IBOutlet weak var menuButtonImage: UIImageView!
    @IBAction func openMenu(_ sender: UIButton) {
        SwiftySideMenuInfo.shared.swiftySideMenu.menuButtonClicked()
    }
    
    class func getMenuImageView() -> SwiftySideMenuImageView {
        return UINib(nibName: "SwiftySideMenuImageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuImageView
    }
    
    class func addMenuImageView(addMenuViewTo parentView: UIView) {
        let childView = UINib(nibName: "SwiftySideMenuImageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuImageView
        childView.frame = parentView.bounds
        parentView.addSubview(childView)
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
