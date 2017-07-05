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
        return UINib(nibName: "SwiftySideMenuTopBannerSampleOne", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuTopBannerSampleOne
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
