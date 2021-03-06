//
//  ContractorFormVC.swift
//  AmzonConstruction
//
//  Created by Dhaval Nagar on 14/08/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit
import FCAlertView

let KEY_FIRST_NAME = "first_name"
let KEY_SURNAME = "sur_name"

class ContractorFormVC: UIViewController {

    //MARK: PROPERTIES
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var tblViewContractors: UITableView!
    @IBOutlet weak var constraintTblViewContractorHeight: NSLayoutConstraint!
    
    //MARK: VARIABLES
    
    var isEditable = true
    var arrCategory = [typeAliasDictionary]()
    var arrContractors = [typeAliasStringDictionary]()
    var selectedCategoryID = ""
    var dictFormData = typeAliasDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constraintTblViewContractorHeight.constant = 0
        let nib = UINib.init(nibName: "AdditionalContractorCell", bundle: nil)
        self.tblViewContractors.register(nib, forCellReuseIdentifier: "AdditionalContractorCell")
        self.getCategories()
        self.fillFormData()
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
    @IBAction func btnBackToMenuAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
   
    @IBAction func btnNextAction() {
        if self.selectedCategoryID == "" {
            showAlertWithTitleWithMessage(message: "Please select category.")
            return
        }
        
        let vc  = WorkPermitFormOneVC.init(nibName: "WorkPermitFormOneVC", bundle: nil)
        vc.categoryID = self.selectedCategoryID
        vc.arrSubContractor = self.arrContractors
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnAddContractorAction() {
        
        if !self.isEditable {
            return
        }
        let stFName = txtFirstName.text!
        let stSurname = txtLastName.text!
        
        if stFName.isEmpty {
            showAlertWithTitleWithMessage(message: MSG_TXT_FIRST_NAME)
            return
        }
        if stSurname.isEmpty {
            showAlertWithTitleWithMessage(message: MSG_TXT_LAST_NAME)
            return
        }
        txtFirstName.resignFirstResponder()
        txtLastName.resignFirstResponder()
        var dictContractor = typeAliasStringDictionary()
        dictContractor[KEY_FIRST_NAME] = stFName
        dictContractor[KEY_SURNAME] = stSurname
        self.arrContractors.append(dictContractor)
        txtFirstName.text = ""
        txtLastName.text = ""
        constraintTblViewContractorHeight.constant = CGFloat(self.arrContractors.count) * 50
        self.tblViewContractors.reloadData()
    }
    
    @IBAction func btnSelectCategoryAction() {
        if !self.isEditable {
           return
        }
        self.showCategories()
    }
    
    
    //MARK: CUSTOM METHODS
    
    func showCategories() {
        let jdSelection = JDSelection.init(title: "Select Category", arrayItems: self.arrCategory, arraySelected: [typeAliasDictionary](), VALUE_KEY: "name", ID_KEY: "id", IS_MULTI_SELECTION: false)
        jdSelection.onSelection = { arrSelected in
            self.lblCategoryName.text = arrSelected.first!["name"] as! String
            self.selectedCategoryID = arrSelected.first!["id"] as! String
        }
    }
    
    func fillFormData() {
        if let dictWorkPermit = self.dictFormData["work_permit"] as? typeAliasDictionary {
            self.selectedCategoryID = "\(dictWorkPermit["category_id"]!)"
            let _ = self.arrCategory.map { if "\($0["id"]!)" == self.selectedCategoryID {
                    self.lblCategoryName.text = "\($0["name"]!)"
                }
            }
        }
        if let dictSubContractors = self.dictFormData["sub_contractors"] as? [typeAliasStringDictionary]{
            self.arrContractors = dictSubContractors
        }
        self.tblViewContractors.reloadData()
    }
    
}


extension ContractorFormVC : AppNavigationControllerDelegate {
    func appNavigationController_BackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func appNavigationController_RightMenuAction() {
            let alert : FCAlertView = FCAlertView()
            alert.delegate = self
            alert.accessibilityValue = "LOGOUT"
            showAlertWithTitleWithMessageAndButtons(message: MSG_ID_LOGOUT, alert: alert, buttons: ["Cancel"], withDoneTitle:"Logout", alertTitle: APP_NAME)

        }
}

extension ContractorFormVC : FCAlertViewDelegate {
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        if alertView.accessibilityValue == "LOGOUT" {
            GetSetModel.removeAllKeyFromDefault()
            APP_SCENE_DELEGATE.setLoginVC()
        }
    }
    func fcAlertView(_ alertView: FCAlertView!, clickedButtonIndex index: Int, buttonTitle title: String!) {
        
    }
}

//MARK: APIS

extension ContractorFormVC  {
    
    func getCategories() {
        if isConnectedToNetwork() {
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.getCategoryList(param: typeAliasDictionary(), response: {(dictResponse,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if !dictResponse.isEmpty {
                    self.arrCategory = dictResponse as! [typeAliasDictionary]
                    self.fillFormData()
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

extension ContractorFormVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrContractors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AdditionalContractorCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalContractorCell") as! AdditionalContractorCell
        let contractorData = self.arrContractors[indexPath.row]
        cell.lblName.text = contractorData[KEY_FIRST_NAME]! + " " +  contractorData[KEY_SURNAME]!
        cell.btnDelete.tag = indexPath.row
        cell.selectionStyle = .none
        cell.btnDelete.addTarget(self, action: #selector(btnRemoveContractorAction(btn:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @objc func btnRemoveContractorAction(btn:UIButton) {
        self.arrContractors.remove(at: btn.tag)
        constraintTblViewContractorHeight.constant = CGFloat(self.arrContractors.count) * 50
        self.tblViewContractors.reloadData()
        self.tblViewContractors.reloadData()
    }
}
