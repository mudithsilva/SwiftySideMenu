//
//  SwiftySideMenuTableViewCell.swift
//  SwiftySideMenu
//
//  Created by Mudith Chathuranga on 5/30/17.
//  Copyright © 2017 Mudith Chathuranga. All rights reserved.
//

import UIKit

class SwiftySideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tabName: UILabel!
    @IBOutlet weak var tabIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
