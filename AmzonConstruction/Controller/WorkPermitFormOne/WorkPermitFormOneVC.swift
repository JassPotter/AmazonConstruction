//
//  WorkPermitFormOneVC.swift
//  AmzonConstruction
//
//  Created by Dhaval Nagar on 16/08/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit

class WorkPermitFormOneVC: UIViewController {

    //MARK: PROPERTIES
    @IBOutlet weak var txtSite: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtWorkToBePerformed: UITextField!
    @IBOutlet weak var txtViewOtherSafetyChecks: UITextView!
    @IBOutlet weak var viewIsAsbestosRequired: UIView!
    
    //CHECKBOX
    
    
    //MARK:VARIABLES
    var arrSites = [typeAliasDictionary]()
    var siteID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getSites()
    }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.setNavigationBar()
       }

    //MARK: NAVIGATION BAR
    func setNavigationBar() {
        UIApplication.shared.isStatusBarHidden = false
        APP_SCENE_DELEGATE.navigationController.navigationDelegate = self
        APP_SCENE_DELEGATE.navigationController.setBack()
        APP_SCENE_DELEGATE.navigationController.setRightButton(title: "Logout")
        APP_SCENE_DELEGATE.navigationController.setCustomTitleWithImage(UIImage.init(named: "image_Amazon(s)")!)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: BUTTON ACTIONS
    @IBAction func btnSafeyCheckAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    @IBAction func btnSafetyCheckNoAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func btnSafetyCheckYesAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    //MARK: CUSTOM METHODS
    
    func showSites() {
        let jdSelection = JDSelection.init(title: "Select Site", arrayItems: self.arrSites, arraySelected: [typeAliasDictionary](), VALUE_KEY: "name", ID_KEY: "id", IS_MULTI_SELECTION: false)
        jdSelection.onSelection = { arrSelected in
            self.txtSite.text = arrSelected.first!["name"] as! String
            self.siteID = arrSelected.first!["id"] as! String
        }
    }
    
}

extension WorkPermitFormOneVC : AppNavigationControllerDelegate {
    func appNavigationController_BackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func appNavigationController_RightMenuAction() {
        
    }
}

//MARK: APIS

extension WorkPermitFormOneVC  {
    
    func getSites() {
        if isConnectedToNetwork() {
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.getSitesList(param: typeAliasDictionary(), response: {(dictResponse,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if !dictResponse.isEmpty {
                    self.arrSites = dictResponse as! [typeAliasDictionary]
                }
                else {
                    showAlertWithTitleWithMessage(message: SOMETHING_WRONG)
                }
            })
        } else {
            showNoInternetAlert()
        }

    }
    
}

extension WorkPermitFormOneVC : UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtSite {
            self.showSites()
            return false
        }
        return true
    }
}
