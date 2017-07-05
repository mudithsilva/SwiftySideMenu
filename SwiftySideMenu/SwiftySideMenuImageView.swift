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
        
        let podBundle = Bundle(for: self.classForCoder())
        if let bundleURL = podBundle.url(forResource: "SwiftySideMenu", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                 return UINib(nibName: "SwiftySideMenuImageView", bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuImageView
            } else {
                return UINib(nibName: "SwiftySideMenuImageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuImageView
            }
        } else {
            return UINib(nibName: "SwiftySideMenuImageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuImageView
        }
        
//        return UINib(nibName: "SwiftySideMenuImageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuImageView
    }
    
    class func addMenuImageView(addMenuViewTo parentView: UIView) {
        
        let podBundle = Bundle(for: self.classForCoder())
        if let bundleURL = podBundle.url(forResource: "SwiftySideMenu", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                let childView = UINib(nibName: "SwiftySideMenuImageView", bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuImageView
                childView.frame = parentView.bounds
                parentView.addSubview(childView)
            } else {
                let childView = UINib(nibName: "SwiftySideMenuImageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuImageView
                childView.frame = parentView.bounds
                parentView.addSubview(childView)
            }
        } else {
            let childView = UINib(nibName: "SwiftySideMenuImageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuImageView
            childView.frame = parentView.bounds
            parentView.addSubview(childView)
        }
        
//        let childView = UINib(nibName: "SwiftySideMenuImageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuImageView
//        childView.frame = parentView.bounds
//        parentView.addSubview(childView)
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
