//
//  ALSiteManagerCell.swift
//  AmzonConstruction
//
//  Created by Jashu Prajapati on 8/14/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit

class ALSiteManagerCell: UITableViewCell {
    
    //MARK PROPERTIES
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblRefNo: UILabel!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
