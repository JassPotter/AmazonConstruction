//
//  AsbestosFormVC.swift
//  AmzonConstruction
//
//  Created by Dhaval Nagar on 20/08/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit

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
            df.dateFormat = "HH:mm"
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
            /*
             @Part("work_permit_id") RequestBody work_permit_id,
             @Part("asbestos_building") RequestBody asbestos_building,
             @Part("asbestos_location") RequestBody asbestos_location,
             @Part("asbestos_regsiter_ref") RequestBody asbestos_regsiter_ref,
             @Part("asbestos_company_department") RequestBody asbestos_company_department,
             @Part("asbestos_supervisor") RequestBody asbestos_supervisor,
             @Part("asbestos_work_carried") RequestBody asbestos_work_carried,
             @Part("asbestos_risk_assessment") RequestBody asbestos_risk_assessment,
             @Part("permit_valid_date") RequestBody permit_valid_date,
             @Part("permit_valid_time") RequestBody permit_valid_time,
             @Part("util_valid_date") RequestBody util_valid_date,
             @Part("util_valid_time") RequestBody util_valid_time

             */
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
}

extension AsbestosFormVC : AppNavigationControllerDelegate {
    func appNavigationController_BackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func appNavigationController_RightMenuAction() {
        
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

extension AsbestosFormVC : UITextFieldDelegate {
    
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
}
