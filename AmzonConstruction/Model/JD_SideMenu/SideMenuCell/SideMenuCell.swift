//
//  SideMenuCell.swift
//  CalcVault
//
//  Created by Setblue on 24/07/18.
//  Copyright © 2018 Setblue. All rights reserved.
//
import UIKit

class SideMenuCell: UITableViewCell {
    
    //MARK: PROPERTIES
    
    @IBOutlet var viewBG: UIView!
    @IBOutlet var lblTittle: UILabel!
    @IBOutlet weak var imageViewBG: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }    
}
