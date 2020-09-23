//
//  WorkPermitFormOneVC.swift
//  AmzonConstruction
//
//  Created by Dhaval Nagar on 16/08/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit
import FCAlertView

class HotWorksFormVC: UIViewController {

    //MARK: PROPERTIES
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtWorkToBePerformed: UITextField!
    @IBOutlet weak var txtViewOtherSafetyChecks: UITextView!
    @IBOutlet weak var viewIsAsbestosRequired: UIView!
    
    //CHECKBOX
    @IBOutlet  var chkBoxYes: [UIButton]!
    @IBOutlet  var chkBoxNo: [UIButton]!
    @IBOutlet  var chkBoxParameters: [UIButton]!

    @IBOutlet weak var chkAsbestosRequiredYes: UIButton!
    @IBOutlet weak var chkAsbestosRequiredNo: UIButton!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    //MARK:VARIABLES
    var arrSites = [typeAliasDictionary]()
    var siteID = ""
    var categoryID = ""
    var arrSubContractor = [typeAliasStringDictionary]()
    var permit_id = ""
    var isEditable = true
    var dictFormData = typeAliasDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let df = DateFormatter.init()
        df.dateFormat = "MMM dd YYYY"
        self.lblDate.text = df.string(from: Date())
        self.txtViewOtherSafetyChecks.delegate = self
        df.dateFormat = "hh:mm a"
        self.lblTime.text = df.string(from: Date())
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
//        APP_SCENE_DELEGATE.navigationController.setRightButton(title: "Logout")
        APP_SCENE_DELEGATE.navigationController.setCustomTitleWithImage(UIImage.init(named: "image_Amazon(s)")!)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: BUTTON ACTIONS
    @IBAction func btnSafeyCheckAction(_ sender: UIButton) {
        if !self.isEditable {
            return
        }
        sender.isSelected = !sender.isSelected
    }
    
    
    @IBAction func btnSafetyCheckNoAction(_ sender: UIButton) {
        if !self.isEditable {
            return
        }
        for btn in chkBoxYes {
            if btn.tag == sender.tag {
                btn.isSelected = false
            }
        }
        for btn in chkBoxNo {
            if btn.tag == sender.tag {
                btn.isSelected = true
            }
        }
        
    }
    
    @IBAction func btnSafetyCheckYesAction(_ sender: UIButton) {
        if !self.isEditable {
            return
        }
        for btn in chkBoxYes {
            if btn.tag == sender.tag {
                btn.isSelected = true
            }
        }
        for btn in chkBoxNo {
            if btn.tag == sender.tag {
                btn.isSelected = false
            }
        }
    }
    
    //MARK: CUSTOM METHODS
    
    
    @IBAction func btnNextAction() {
        
        if !self.isEditable {
            self.redirectToNextForm(work_Permit_id: self.permit_id)
            return
        }
        if self.txtLocation.text! == "" {
            showFormValidationMessage();
        }
        else if  self.txtWorkToBePerformed.text! == "" {
            showFormValidationMessage();
        }
        else if !isAllParamsSelected() {
            showFormValidationMessage();
        }
        else if !checkIsAllYesNoSelected() {
            showFormValidationMessage();
        }
        else {
            var params = typeAliasStringDictionary()
            params["work_permit_id"] = self.permit_id
            params["category_id"] = categoryID
            params["site_id"] = siteID
            params["hotwork_date_of_work"] = self.lblDate.text!
            params["hotwork_time_of_work"] = self.lblTime.text!
            params["hotwork_location"] = txtLocation.text!
            params["hotworks_performed"] = txtWorkToBePerformed.text!
            params["immediate_access"] = getRegulations()
            params["hotwork_other_safety_checks"] = txtViewOtherSafetyChecks.text!
            params = getYesNoParams(params: params)
            self.callCreateHotWorkAPI(parmas: params)
        }
    }
       
    @IBAction func btnBackMenuAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: CUSTOM METHODS
    
    func showSites() {
    }
    
    func fillFormData() {
        
        if let dictWorkPermit = self.dictFormData["hot_work"] as? typeAliasDictionary , !dictWorkPermit.isEmpty {
//            self.siteID = dictWorkPermit["site_id"] as! String
            self.lblDate.text = dictWorkPermit["hotwork_date_of_work"] as? String
            self.lblTime.text = dictWorkPermit["hotwork_time_of_work"] as? String
            self.txtLocation.text = dictWorkPermit["hotwork_location"] as? String
            self.txtWorkToBePerformed.text = dictWorkPermit["hotworks_performed"] as? String
            self.txtViewOtherSafetyChecks.text = dictWorkPermit["hotwork_other_safety_checks"] as? String
            
            //CHECK BOX REGUALTIONS
            if dictWorkPermit["immediate_access"] as! String != "" {
                for btn in chkBoxParameters {
                    btn.isSelected = true
                }
            }
            
            //CHECKBOX YES NO
            self.chkAsbestosRequiredYes.isSelected = false
            self.chkAsbestosRequiredNo.isSelected = false
            self.setYesNoCheckBoxes()
            if let asbestosData = self.dictFormData["asbestos_permit"] as? typeAliasDictionary {
                if let dateOfWork = asbestosData["permit_valid_date"] as? String , dateOfWork != "" {
                    self.chkAsbestosRequiredYes.isSelected = true
                    self.chkAsbestosRequiredNo.isSelected = false
                }
                else {
                    self.chkAsbestosRequiredYes.isSelected = false
                    self.chkAsbestosRequiredNo.isSelected = true
                }
            }
        }
    }
    
    func setYesNoCheckBoxes() {
        
        let dictWorkPermit = self.dictFormData["hot_work"] as! typeAliasDictionary
        
        let arrParams = ["work_area_free","housekeeping_area","remaining_combustibles","isolation_energy","necessary_fire","hotwork_fire_safety_checks"]
        
        for i in 0..<6 {
            let btnYes = chkBoxYes.filter { (btn) -> Bool in
                return btn.tag == i
            }.first!
            let btnNo = chkBoxNo.filter { (btn) -> Bool in
                return btn.tag == i
            }.first!
            btnYes.isSelected = false
            btnNo.isSelected = false

            if let value = dictWorkPermit[arrParams[i]] as? String {
                btnYes.isSelected = value == "1"
                btnNo.isSelected = value == "2"
            }
        }
        
    }
        
    func isAllParamsSelected() -> Bool {
        for btn in chkBoxParameters {
            if !btn.isSelected {
                return false
            }
        }
        
        return true
    }
    
    func checkIsAllYesNoSelected() -> Bool {
        
        for i in 0..<7 {
            let btnYes = chkBoxYes.filter { (btn) -> Bool in
                return btn.tag == i
            }.first!
            let btnNo = chkBoxNo.filter { (btn) -> Bool in
                return btn.tag == i
            }.first!
            
            if !btnNo.isSelected && !btnYes.isSelected {
                return false
            }
            
        }
        
        return true
    }
    
    func showFormValidationMessage() {
        showAlertWithTitleWithMessage(message: "Please fill all details to proceed further")
    }
    
    func getYesNoCheckBoxValue(btnYes:UIButton , btnNo:UIButton) -> String {
        
        if btnYes.isSelected {
            return "1"
        }
        return "2"
    }
    
    func getRegulations() -> String {
        var arrRegulations = [Int]()
        for i in 0..<5 {
            arrRegulations.append(i+1)
        }
        return convertToJSONString(value: arrRegulations as AnyObject) ?? ""
    }
    
    func getYesNoParams(params:typeAliasStringDictionary) -> typeAliasStringDictionary {
        
        var dictParams = params
        let arrParams = ["work_area_free","housekeeping_area","remaining_combustibles","isolation_energy","necessary_fire","hotwork_fire_safety_checks"]
        
        for i in 0..<6 {
            let btnYes = chkBoxYes.filter { (btn) -> Bool in
                return btn.tag == i
            }.first!
            let btnNo = chkBoxNo.filter { (btn) -> Bool in
                return btn.tag == i
            }.first!
            dictParams[arrParams[i]] = getYesNoCheckBoxValue(btnYes: btnYes, btnNo: btnNo)
        }
        
        return dictParams
    }
    
    func redirectToNextForm(work_Permit_id:String) {
        if self.chkAsbestosRequiredYes.isSelected {
            let vc = AsbestosFormVC.init(nibName: "AsbestosFormVC", bundle: nil)
            vc.permit_id = work_Permit_id
            vc.dictFormData = self.dictFormData
            vc.isEditable = self.isEditable
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = InductionFormVC.init(nibName: "InductionFormVC", bundle: nil)
            vc.strWorkPermitId = self.permit_id
            vc.dictPageInfo = self.dictFormData
//            if self.dictFormData.isEmpty {
//            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension HotWorksFormVC : AppNavigationControllerDelegate {
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

extension HotWorksFormVC : FCAlertViewDelegate {
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

extension HotWorksFormVC  {
    
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
    
    func callCreateHotWorkAPI(parmas:typeAliasStringDictionary) {
        if isConnectedToNetwork() {
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.createHotWork(param: parmas as! typeAliasDictionary, response: {(dictResponse,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if "\(dictResponse["status"]!)" == "1" {
                    self.redirectToNextForm(work_Permit_id: self.permit_id)
                    
                }
                else {
                    showAlertWithTitleWithMessage(message: SOMETHING_WRONG)
                }
            })
        } else {
            showNoInternetAlert()
        }
    }
    
    func callUpdateWorkPermitAPI(parmas:typeAliasStringDictionary) {
        if isConnectedToNetwork() {
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.updateWorkPermit(param: parmas as! typeAliasDictionary, response: {(dictResponse,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if "\(dictResponse["status"]!)" == "1" {
                    let workPermitId = "\(dictResponse["work_permit_id"]!)"
                    if !self.arrSubContractor.isEmpty {
                        self.callAddSubcontractorList(workPermitID: workPermitId)
                    }
                    else {
                        //NEXT STEPS
                        self.redirectToNextForm(work_Permit_id: workPermitId)
                    }
                }
                else {
                    showAlertWithTitleWithMessage(message: SOMETHING_WRONG)
                }
            })
        } else {
            showNoInternetAlert()
        }
    }
    
    func callAddSubcontractorList(workPermitID:String) {
        if isConnectedToNetwork() {
            var params = typeAliasStringDictionary()
            params["work_permit_id"] = workPermitID
            params["sub_contractors"] = convertToJSONString(value: self.arrSubContractor as AnyObject) ?? ""
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.CreateSubcontractors(param: params as! typeAliasDictionary, response: {(dictResponse,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if "\(dictResponse["status"]!)" == "1" {
                    
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

extension HotWorksFormVC : UITextFieldDelegate , UITextViewDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if !isEditable {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     
        if textField == txtLocation{
            txtWorkToBePerformed.becomeFirstResponder()
        }
        else if textField == txtWorkToBePerformed{
            txtWorkToBePerformed.resignFirstResponder()
        }
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if !self.isEditable {
            return false
        }
        return true
    }
}
