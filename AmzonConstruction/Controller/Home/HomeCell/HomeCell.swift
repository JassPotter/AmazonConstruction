//
//  HomeCell.swift
//  FitnessFood
//
//  Created by Jashu Prajapati on 5/8/20.
//  Copyright © 2020 MyOwnOrganization. All rights reserved.
//

import UIKit
protocol HomeCellDelagate {
    func btnOrderNowAction_HomeCell(sender: UIButton)
}

class HomeCell: UITableViewCell {

    //MARK: PROPERTIES
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var lblTotalMeal: UILabel!
    @IBOutlet weak var btnOrderNow: UIButton!
    @IBOutlet weak var imageViewBG: UIImageView!
    
    //MARK: VARIBALES
    var delegate : HomeCellDelagate! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnOrderNowAction(_ sender: UIButton) {
        self.delegate.btnOrderNowAction_HomeCell(sender: sender)
    }
    
}
