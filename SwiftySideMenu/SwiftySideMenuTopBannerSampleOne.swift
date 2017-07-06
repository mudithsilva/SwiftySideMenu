//
//  SwiftySideMenuTopBannerSampleOne.swift
//  navigationTest
//
//  Created by Mudith Chathuranga on 5/30/17.
//  Copyright © 2017 Mudith Chathuranga. All rights reserved.
//

import UIKit

public class SwiftySideMenuTopBannerSampleOne: UIView {
    
    @IBOutlet weak var topBannerImage: UIImageView!
    
    
    public class func getTopBannerView() -> SwiftySideMenuTopBannerSampleOne {
        
        let podBundle = Bundle(for: SwiftySideMenuTopBannerSampleOne.self)
        if let bundleURL = podBundle.url(forResource: "SwiftySideMenu", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                return UINib(nibName: "SwiftySideMenuTopBannerSampleOne", bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuTopBannerSampleOne
            } else {
                return UINib(nibName: "SwiftySideMenuTopBannerSampleOne", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuTopBannerSampleOne
            }
        } else {
            return UINib(nibName: "SwiftySideMenuTopBannerSampleOne", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuTopBannerSampleOne
        }
        
//        return UINib(nibName: "SwiftySideMenuTopBannerSampleOne", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuTopBannerSampleOne
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
