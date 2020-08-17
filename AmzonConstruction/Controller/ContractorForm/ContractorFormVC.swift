//
//  ContractorFormVC.swift
//  AmzonConstruction
//
//  Created by Dhaval Nagar on 14/08/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit

let KEY_FIRST_NAME = "KEY_FIRST_NAME"
let KEY_SURNAME = "KEY_SURNAME"

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constraintTblViewContractorHeight.constant = 0
        let nib = UINib.init(nibName: "AdditionalContractorCell", bundle: nil)
        self.tblViewContractors.register(nib, forCellReuseIdentifier: "AdditionalContractorCell")
        self.getCategories()
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
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func btnNextAction() {
        if self.selectedCategoryID == "" {
            showAlertWithTitleWithMessage(message: "Please select category.")
            return
        }
        
        let vc  = WorkPermitFormOneVC.init(nibName: "WorkPermitFormOneVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnAddContractorAction() {
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
    
}


extension ContractorFormVC : AppNavigationControllerDelegate {
    func appNavigationController_BackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func appNavigationController_RightMenuAction() {
        
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
