//
//  ALContractorVC.swift
//  AmzonConstruction
//
//  Created by Jashu Prajapati on 8/14/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit

class ALContractorVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar()
    }

    //MARK: NAVIGATION BAR
       func setNavigationBar() {
//         UIApplication.shared.isStatusBarHidden = false
           self.navigationController?.setNavigationBarHidden(true, animated: false)
       }
    
    // MARK: - UIBUTTON ACTION
    @IBAction func btnPageAction(_ sender: UIButton) {
        if sender.tag == 1 {
            //create new
            let contractorFormVC = ContractorFormVC.init(nibName: "ContractorFormVC", bundle: nil)
            contractorFormVC.isEditable = true
            self.navigationController?.pushViewController(contractorFormVC, animated: true)
        }
        else {
            //old list
            let vc = ALSiteManagerVC.init(nibName: "ALSiteManagerVC", bundle: nil)
            vc.intLoginType = Int(APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String)!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}
