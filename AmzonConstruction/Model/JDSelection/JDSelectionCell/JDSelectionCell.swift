//
//  JDSelectionCell.swift
//  FitnessFood
//
//  Created by  YASH COMPUTERS on 08/05/20.
//  Copyright © 2020 MyOwnOrganization. All rights reserved.
//

import UIKit

class JDSelectionCell: UITableViewCell {

    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var btnSelection: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
