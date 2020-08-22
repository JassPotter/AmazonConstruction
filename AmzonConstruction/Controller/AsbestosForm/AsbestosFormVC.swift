//
//  AsbestosFormVC.swift
//  AmzonConstruction
//
//  Created by Dhaval Nagar on 20/08/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit
import FCAlertView

class AsbestosFormVC: UIViewController {

    //MARK: PROPERTIES
    @IBOutlet weak var txtBuilding: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtAsbestosRegister: UITextField!
    @IBOutlet weak var txtConpanyDepartment: UITextField!
    @IBOutlet weak var txtSupervisor: UITextField!
    @IBOutlet weak var txtWorkToBeCarriedOut: UITextField!
    @IBOutlet weak var txtRiskAssesment: UITextField!
    @IBOutlet weak var txtValidFrom: UITextField!
    @IBOutlet weak var txtValidFromTime: UITextField!
    @IBOutlet weak var txtValidTillDate: UITextField!
    @IBOutlet weak var txtValidTilTIme: UITextField!
    @IBOutlet weak var lblDate: UILabel!
    
    //MARK: VARIABLES
    
    var permit_id = ""
    var isEditable = true
    var datePicker = UIDatePicker.init()
    var currentTextfield = UITextField()
    var dictFormData = typeAliasDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let df = DateFormatter.init()
        df.dateFormat = "MMM dd YYYY"
        self.lblDate.text = df.string(from: Date())
        datePicker.addTarget(self, action: #selector(selectDate), for: .valueChanged)
        datePicker.datePickerMode = .date
        self.txtValidFrom.inputView = datePicker
        self.txtValidTillDate.inputView = datePicker
        self.txtValidTilTIme.inputView = datePicker
        self.txtValidFromTime.inputView = datePicker
        self.datePicker.minimumDate = Date()
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

    @objc func selectDate() {
        
        let df = DateFormatter()
        if datePicker.datePickerMode == .time {
            df.dateFormat = "hh:mm a"
            self.currentTextfield.text = df.string(from: datePicker.date)
        }
        else {
           df.dateFormat = "MMM dd YYYY"
           self.currentTextfield.text = df.string(from: datePicker.date)
        }
    }
    
    @IBAction func btnNextAction() {
        let stBuilding = txtBuilding.text!.trim()
        let stLocation = txtLocation.text!.trim()
        let stAsbestosRegister = txtAsbestosRegister.text!.trim()
        let stRiskAssesment = txtRiskAssesment.text!.trim()
        let stSupevisor = txtSupervisor.text!.trim()
        let stCompany = txtConpanyDepartment.text!.trim()
        let stWorkToBeDone = txtWorkToBeCarriedOut.text!.trim()
        let stFromTime = txtValidFromTime.text!.trim()
        let stFromDate = txtValidFrom.text!.trim()
        let stToDate = txtValidTillDate.text!.trim()
        let stToTime = txtValidTilTIme.text!.trim()
        
        if stBuilding == "" || stLocation == "" || stAsbestosRegister == "" || stRiskAssesment == "" || stSupevisor == "" || stCompany == "" || stWorkToBeDone == "" || stFromTime == "" || stFromDate == "" || stToDate == "" || stBuilding == "" || stToTime == "" {
               showAlertWithTitleWithMessage(message: "Please fill all details to proceed further")
            return
        }
        else {

            var params = typeAliasStringDictionary()
            params["work_permit_id"] = permit_id
            params["asbestos_building"] = stBuilding
            params["asbestos_location"] = stLocation
            params["asbestos_regsiter_ref"] = stAsbestosRegister
            params["asbestos_company_department"] = stCompany
            params["asbestos_supervisor"] = stSupevisor
            params["asbestos_work_carried"] = stWorkToBeDone
            params["asbestos_risk_assessment"] = stRiskAssesment
            params["permit_valid_date"] = stFromDate
            params["permit_valid_time"] = stFromTime
            params["util_valid_date"] = stToDate
            params["util_valid_time"] = stToTime
            self.callCreateAsbestosWorkAPI(parmas: params)
        }
        
    }
    
    @IBAction func btnBackToMainMenuAction() {
   
    }
    
    func redirectToNextForm(work_Permit_id:String) {
        
    }
    
    func fillFormData() {
                
        if let dictWorkPermit = self.dictFormData["asbestos_permit"] as? typeAliasDictionary , !dictWorkPermit.isEmpty {
//            self.lblDate.text = dictWorkPermit["hotwork_date_of_work"] as? String
            self.txtLocation.text = dictWorkPermit["asbestos_location"] as? String
            self.txtBuilding.text = dictWorkPermit["asbestos_building"] as? String
            self.txtConpanyDepartment.text = dictWorkPermit["asbestos_company_department"] as? String
            self.txtAsbestosRegister.text = dictWorkPermit["asbestos_regsiter_ref"] as? String
            self.txtRiskAssesment.text = dictWorkPermit["asbestos_risk_assessment"] as? String
            self.txtSupervisor.text = dictWorkPermit["asbestos_supervisor"] as? String
            self.txtWorkToBeCarriedOut.text = dictWorkPermit["asbestos_work_carried"] as? String
            self.txtValidFrom.text = dictWorkPermit["permit_valid_date"] as? String
            self.txtValidFromTime.text = dictWorkPermit["permit_valid_time"] as? String
            self.txtValidTillDate.text = dictWorkPermit["util_valid_date"] as? String
            self.txtValidTilTIme.text = dictWorkPermit["util_valid_time"] as? String
        }
    }
}

extension AsbestosFormVC : AppNavigationControllerDelegate {
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

extension AsbestosFormVC : FCAlertViewDelegate {
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        if alertView.accessibilityValue == "LOGOUT" {
            GetSetModel.removeObjectForKey(objectKey: UD_KEY_APPUSER_INFO)
            APP_SCENE_DELEGATE.setLoginVC()
        }
    }
    func fcAlertView(_ alertView: FCAlertView!, clickedButtonIndex index: Int, buttonTitle title: String!) {
        
    }
}

//MARK: APIS

extension AsbestosFormVC  {
        
    func callCreateAsbestosWorkAPI(parmas:typeAliasStringDictionary) {
        if isConnectedToNetwork() {
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.createAsbestosWork(param: parmas as! typeAliasDictionary, response: {(dictResponse,rstatus,message) in
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
    
}

extension AsbestosFormVC : UITextFieldDelegate , UITextViewDelegate  {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtValidFrom {
            currentTextfield = textField
        }
        else if textField == txtValidTillDate {
            self.datePicker.minimumDate = Date()
            self.datePicker.datePickerMode = .date
            currentTextfield = textField
        }
        else if textField == txtValidFromTime {
            self.datePicker.minimumDate = nil
            self.datePicker.datePickerMode = .time
            currentTextfield = textField
        }
        else if textField == txtValidTilTIme {
            self.datePicker.minimumDate = nil
            self.datePicker.datePickerMode = .time
            currentTextfield = textField
        }
        if textField.text! == "" {
           self.selectDate()
        }
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if !isEditable {
            return false
        }
        
        if textField == txtValidFrom {
            self.datePicker.minimumDate = Date()
            self.datePicker.datePickerMode = .date
            currentTextfield = textField
        }
        else if textField == txtValidTillDate {
            self.datePicker.minimumDate = Date()
            self.datePicker.datePickerMode = .date
            currentTextfield = textField
        }
        else if textField == txtValidFromTime {
            self.datePicker.minimumDate = nil
            self.datePicker.datePickerMode = .time
            currentTextfield = textField
        }
        else if textField == txtValidTilTIme {
            self.datePicker.minimumDate = nil
            self.datePicker.datePickerMode = .time
            currentTextfield = textField
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtBuilding {
            txtLocation.becomeFirstResponder()
        }
        else if textField == txtLocation {
            txtAsbestosRegister.becomeFirstResponder()
        }
        else if textField == txtLocation {
            txtAsbestosRegister.becomeFirstResponder()
        }
        else if textField == txtAsbestosRegister {
            txtConpanyDepartment.becomeFirstResponder()
        }
        else if textField == txtConpanyDepartment {
            txtSupervisor.becomeFirstResponder()
        }
        else if textField == txtSupervisor {
            txtWorkToBeCarriedOut.becomeFirstResponder()
        }
        else if textField == txtWorkToBeCarriedOut {
            txtRiskAssesment.becomeFirstResponder()
        }
        else if textField == txtRiskAssesment {
            txtRiskAssesment.resignFirstResponder()
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
