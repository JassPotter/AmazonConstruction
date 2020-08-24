//
//  WorkPermitFormOneVC.swift
//  AmzonConstruction
//
//  Created by Dhaval Nagar on 16/08/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit
import FCAlertView

class WorkPermitFormOneVC: UIViewController {

    //MARK: PROPERTIES
    @IBOutlet weak var txtSite: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtWorkToBePerformed: UITextField!
    @IBOutlet weak var txtViewOtherSafetyChecks: UITextView!
    @IBOutlet weak var viewIsAsbestosRequired: UIView!
    
    //CHECKBOX
    @IBOutlet  var chkBoxYes: [UIButton]!
    @IBOutlet  var chkBoxNo: [UIButton]!

    @IBOutlet weak var chkBoxSiteRegulations: UIButton!
    @IBOutlet weak var chikVechicleEquipUsed: UIButton!
    @IBOutlet weak var chkContractorCondusctTask: UIButton!
    @IBOutlet weak var chkAccidentIncidentSafety: UIButton!
    @IBOutlet weak var chkWorkAreaNecessary: UIButton!
    @IBOutlet weak var chkSiteMandatoryPpe: UIButton!
    @IBOutlet weak var chkHazardsTask: UIButton!
    @IBOutlet weak var chkWorkAreaResponsibility: UIButton!
    
    
    @IBOutlet weak var chkWorkWithVehiclesYes: UIButton!
    @IBOutlet weak var chkWorkWithVehicleNO: UIButton!
    
    @IBOutlet weak var chkHotWorkRequiredYes: UIButton!
    @IBOutlet weak var chkHotWorkRequiredNO: UIButton!
    
    @IBOutlet weak var chkElectricityEquipmentRequiredYes: UIButton!
    @IBOutlet weak var chkElectricityEquipmentRequiredNO: UIButton!
    
    @IBOutlet weak var chkCoshhProducedYes: UIButton!
    @IBOutlet weak var chkCoshhProducedNO: UIButton!
    
    @IBOutlet weak var chkEvacuationRequiredYes: UIButton!
    @IBOutlet weak var chkEvacuationRequiredNo: UIButton!
    
    @IBOutlet weak var chkOverheadObstructionsYes: UIButton!
    @IBOutlet weak var chkOverheadObstructionsNO: UIButton!
    
    @IBOutlet weak var chkTrafficOperatingAreaYes: UIButton!
    @IBOutlet weak var chkTrafficOperatingAreaNo: UIButton!
    
    @IBOutlet weak var chkFragileRoofCoveringsYes: UIButton!
    @IBOutlet weak var chkFragileRoofCoveringsNo: UIButton!
    
    @IBOutlet weak var chkWorkAtHeightYes: UIButton!
    @IBOutlet weak var chkWorkAtHeightNo: UIButton!
    
    @IBOutlet weak var chkIsolationSegregationYes: UIButton!
    @IBOutlet weak var chkIsolationSegregationNo: UIButton!
    
    @IBOutlet weak var chkSlipTripHazardsYes: UIButton!
    @IBOutlet weak var chkSlipTripHazardsNo: UIButton!
    
    @IBOutlet weak var chkAsbestosRequiredYes: UIButton!
    @IBOutlet weak var chkAsbestosRequiredNo: UIButton!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    //MARK:VARIABLES
    var arrSites = [typeAliasDictionary]()
    var siteID = ""
    var categoryID = ""
    var arrSubContractor = [typeAliasStringDictionary]()
    var isEditable = true
    var permitID = ""
    var dictFormData = typeAliasDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getSites()
        let df = DateFormatter.init()
        df.dateFormat = "MMM dd YYYY"
        self.lblDate.text = df.string(from: Date())
        self.txtViewOtherSafetyChecks.delegate = self
        df.dateFormat = "hh:mm a"
        self.lblTime.text = df.string(from: Date())
        self.viewIsAsbestosRequired.isHidden = true
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
        if sender == chkHotWorkRequiredNO {
            viewIsAsbestosRequired.isHidden = false
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
        if sender == chkHotWorkRequiredYes {
            viewIsAsbestosRequired.isHidden = true
        }
    }
    
    @IBAction func btnNextAction() {
        
        if !self.isEditable {
            self.redirectToNextForm(work_Permit_id:self.permitID)
            return
        }
        
        if self.siteID == "" {
            showFormValidationMessage();
        }
        else if self.txtLocation.text! == "" {
            showFormValidationMessage();
        }
        else if  self.txtWorkToBePerformed.text! == "" {
            showFormValidationMessage();
        }
        else if !chkBoxSiteRegulations.isSelected {
            showFormValidationMessage();
        } else if !chikVechicleEquipUsed.isSelected {
            showFormValidationMessage();
        } else if !chkContractorCondusctTask.isSelected {
            showFormValidationMessage();
        } else if !chkAccidentIncidentSafety.isSelected {
            showFormValidationMessage();
        } else if !chkWorkAreaNecessary.isSelected {
            showFormValidationMessage();
        } else if !chkSiteMandatoryPpe.isSelected {
            showFormValidationMessage();
        } else if !chkHazardsTask.isSelected {
            showFormValidationMessage();
        } else if !chkWorkAreaResponsibility.isSelected {
            showFormValidationMessage();
        } else if (!chkWorkWithVehiclesYes.isSelected && !chkWorkWithVehicleNO.isSelected) {
            showFormValidationMessage();
        } else if (!chkHotWorkRequiredYes.isSelected && !chkHotWorkRequiredNO.isSelected) {
            showFormValidationMessage();
        } else if (!chkElectricityEquipmentRequiredYes.isSelected && !chkElectricityEquipmentRequiredNO.isSelected) {
            showFormValidationMessage();
        } else if (!chkCoshhProducedYes.isSelected && !chkCoshhProducedNO.isSelected) {
            showFormValidationMessage();
        } else if (!chkEvacuationRequiredYes.isSelected && !chkEvacuationRequiredNo.isSelected) {
            showFormValidationMessage();
        } else if (!chkOverheadObstructionsYes.isSelected && !chkOverheadObstructionsNO.isSelected) {
            showFormValidationMessage();
        } else if (!chkTrafficOperatingAreaYes.isSelected && !chkTrafficOperatingAreaNo.isSelected) {
            showFormValidationMessage();
        } else if (!chkFragileRoofCoveringsYes.isSelected && !chkFragileRoofCoveringsNo.isSelected) {
            showFormValidationMessage();
        } else if (!chkWorkAtHeightYes.isSelected && !chkWorkAtHeightNo.isSelected) {
            showFormValidationMessage();
        } else if (!chkIsolationSegregationYes.isSelected && !chkIsolationSegregationNo.isSelected) {
            showFormValidationMessage();
        } else if (!chkSlipTripHazardsYes.isSelected && !chkSlipTripHazardsNo.isSelected) {
            showFormValidationMessage();
        }   else if viewIsAsbestosRequired.isHidden == false &&  (!chkAsbestosRequiredYes.isSelected && !chkAsbestosRequiredNo.isSelected) {
            showFormValidationMessage();
        }
        else if txtViewOtherSafetyChecks.text == "" {
            showFormValidationMessage();
        }
        else {
            // CALL API
            var params = typeAliasStringDictionary()
            let userData = GetSetModel.getObjectFromUserDefaults(UD_KEY_APPUSER_INFO)
            params["user_id"] = "\(userData["user_id"]!)"
            params["category_id"] = categoryID
            params["site_id"] = siteID
            params["site_date_of_work"] = self.lblDate.text!
            params["site_time"] = self.lblTime.text!
            params["site_location"] = txtLocation.text!
            params["site_work_performed"] = txtWorkToBePerformed.text!
            params["site_regulations"] = getRegulations()
            params["work_with_vehicles"] = getYesNoCheckBoxValue(btnYes: chkWorkWithVehiclesYes, btnNo: chkWorkWithVehicleNO)
            params["hot_works_conducted"] = getYesNoCheckBoxValue(btnYes: chkHotWorkRequiredYes, btnNo: chkHotWorkRequiredNO)
            params["electricity_equipment_required"] = getYesNoCheckBoxValue(btnYes: chkElectricityEquipmentRequiredYes, btnNo: chkElectricityEquipmentRequiredNO)
            params["coshh_produced"] = getYesNoCheckBoxValue(btnYes: chkCoshhProducedYes, btnNo: chkCoshhProducedNO)
            params["evacuation_required"] = getYesNoCheckBoxValue(btnYes: chkEvacuationRequiredYes, btnNo: chkEvacuationRequiredNo)
            params["traffic_operating_area"] = getYesNoCheckBoxValue(btnYes: chkTrafficOperatingAreaYes, btnNo: chkTrafficOperatingAreaNo)
            params["fragile_roof_coverings"] = getYesNoCheckBoxValue(btnYes: chkFragileRoofCoveringsYes, btnNo: chkFragileRoofCoveringsNo)
            params["work_at_height"] = getYesNoCheckBoxValue(btnYes: chkWorkAtHeightYes, btnNo: chkWorkAtHeightNo)
            params["isolation_segregation"] = getYesNoCheckBoxValue(btnYes: chkIsolationSegregationYes, btnNo: chkIsolationSegregationNo)
            params["slip_trip_hazards"] = getYesNoCheckBoxValue(btnYes: chkSlipTripHazardsYes, btnNo: chkSlipTripHazardsNo)
            params["site_other_safety_checks"] = txtViewOtherSafetyChecks.text!
            
            if self.permitID != "" {
                params["work_permit_id"] = self.permitID
                self.callUpdateWorkPermitAPI(parmas: params)
            }
            else { self.callCreateWorkPermitAPI(parmas: params) }
        }
        
    }
       
    @IBAction func btnBackMenuAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: CUSTOM METHODS
    
    func showSites() {
        let jdSelection = JDSelection.init(title: "Select Site", arrayItems: self.arrSites, arraySelected: [typeAliasDictionary](), VALUE_KEY: "name", ID_KEY: "id", IS_MULTI_SELECTION: false)
        jdSelection.onSelection = { arrSelected in
            self.txtSite.text = arrSelected.first!["name"] as! String
            self.siteID = arrSelected.first!["id"] as! String
        }
    }
    
    func fillFormData() {
        if let dictWorkPermit = self.dictFormData["work_permit"] as? typeAliasDictionary , !dictWorkPermit.isEmpty{
            self.siteID = dictWorkPermit["site_id"] as! String
            self.lblDate.text = dictWorkPermit["site_date_of_work"] as? String
            self.lblTime.text = dictWorkPermit["site_time"] as? String
            self.txtLocation.text = dictWorkPermit["site_location"] as? String
            self.txtSite.text = dictWorkPermit["site_name"] as? String
            self.txtWorkToBePerformed.text = dictWorkPermit["site_work_performed"] as? String
            self.txtViewOtherSafetyChecks.text = dictWorkPermit["site_other_safety_checks"] as? String
            
            //CHECK BOX REGUALTIONS
            if dictWorkPermit["site_regulations"] as! String != "" {
                chkBoxSiteRegulations.isSelected = true
                chikVechicleEquipUsed.isSelected = true
                chkContractorCondusctTask.isSelected = true
                chkAccidentIncidentSafety.isSelected = true
                chkWorkAreaNecessary.isSelected = true
                chkSiteMandatoryPpe.isSelected = true
                chkHazardsTask.isSelected = true
                chkWorkAreaResponsibility.isSelected = true
            }
            
            //CHECKBOX YES NO
            self.setYesNoCheckBox(yesButton: chkSlipTripHazardsYes, noButton: chkSlipTripHazardsNo, key: "slip_trip_hazards")
            self.setYesNoCheckBox(yesButton: chkCoshhProducedYes, noButton: chkCoshhProducedNO, key: "coshh_produced")
            self.setYesNoCheckBox(yesButton: chkWorkWithVehiclesYes, noButton: chkWorkWithVehicleNO, key: "work_with_vehicles")
            self.setYesNoCheckBox(yesButton: chkHotWorkRequiredYes, noButton: chkHotWorkRequiredNO, key: "hot_works_conducted")
            self.setYesNoCheckBox(yesButton: chkElectricityEquipmentRequiredYes, noButton: chkElectricityEquipmentRequiredNO, key: "electricity_equipment_required")
            self.setYesNoCheckBox(yesButton: chkEvacuationRequiredYes, noButton: chkEvacuationRequiredNo, key: "evacuation_required")
            self.setYesNoCheckBox(yesButton: chkTrafficOperatingAreaYes, noButton: chkTrafficOperatingAreaNo, key: "traffic_operating_area")
            self.setYesNoCheckBox(yesButton: chkFragileRoofCoveringsYes, noButton: chkFragileRoofCoveringsNo, key: "fragile_roof_coverings")
            self.setYesNoCheckBox(yesButton: chkWorkAtHeightYes, noButton: chkWorkAtHeightNo, key: "work_at_height")
            self.setYesNoCheckBox(yesButton: chkIsolationSegregationYes, noButton: chkIsolationSegregationNo, key: "isolation_segregation")
            self.setYesNoCheckBox(yesButton: chkOverheadObstructionsYes, noButton: chkOverheadObstructionsNO, key: "overhead_obstructions")
            
            self.viewIsAsbestosRequired.isHidden = true
            if self.chkHotWorkRequiredNO.isSelected {
                self.viewIsAsbestosRequired.isHidden = false
            }
            self.chkAsbestosRequiredYes.isSelected = false
            self.chkAsbestosRequiredNo.isSelected = false

            if let asbestosData = self.dictFormData["asbestos_permit"] as? typeAliasDictionary {
                if let dateOfWork = asbestosData["permit_valid_date"] as? String , dateOfWork != "" {
                    self.chkAsbestosRequiredYes.isSelected = true
                    self.chkAsbestosRequiredNo.isSelected = false
                }
                else{
                    self.chkAsbestosRequiredYes.isSelected = false
                    self.chkAsbestosRequiredNo.isSelected = true

                }
            }
        }
    }
    
    func setYesNoCheckBox(yesButton:UIButton , noButton:UIButton , key:String) {
        let dictWorkPermit = self.dictFormData["work_permit"] as! typeAliasDictionary
        yesButton.isSelected = false
        noButton.isSelected = false
        if "\(dictWorkPermit[key]!)" == "1" {
            yesButton.isSelected = true
        }
        else {
            noButton.isSelected = true
        }
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
        for i in 0..<8 {
            arrRegulations.append(i+1)
        }
        return convertToJSONString(value: arrRegulations as AnyObject) ?? ""
    }
    
    func redirectToNextForm(work_Permit_id:String) {

        if self.chkHotWorkRequiredYes.isSelected {
            //
            let vc = HotWorksFormVC.init(nibName: "HotWorksFormVC", bundle: nil)
            vc.permit_id = work_Permit_id
            vc.dictFormData = self.dictFormData
            vc.isEditable = self.isEditable
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if self.chkAsbestosRequiredYes.isSelected {
            let vc = AsbestosFormVC.init(nibName: "AsbestosFormVC", bundle: nil)
            vc.permit_id = work_Permit_id
            vc.dictFormData = self.dictFormData
            vc.isEditable = self.isEditable
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = InductionFormVC.init(nibName: "InductionFormVC", bundle: nil)
            vc.strWorkPermitId = work_Permit_id
            vc.dictPageInfo = self.dictFormData
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

extension WorkPermitFormOneVC : AppNavigationControllerDelegate {
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

extension WorkPermitFormOneVC : FCAlertViewDelegate {
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

extension WorkPermitFormOneVC  {
    
    func getSites() {
        if isConnectedToNetwork() {
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.getSitesList(param: typeAliasDictionary(), response: {(dictResponse,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if !dictResponse.isEmpty {
                    self.arrSites = dictResponse as! [typeAliasDictionary]
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
    
    func callCreateWorkPermitAPI(parmas:typeAliasStringDictionary) {
        if isConnectedToNetwork() {
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.createWorkPermit(param: parmas as! typeAliasDictionary, response: {(dictResponse,rstatus,message) in
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
    
    func callUpdateWorkPermitAPI(parmas:typeAliasStringDictionary) {
        if isConnectedToNetwork() {
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.updateWorkPermit(param: parmas as! typeAliasDictionary, response: {(dictResponse,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if "\(dictResponse["status"]!)" == "1" {
                    if !self.arrSubContractor.isEmpty {
                        self.callAddSubcontractorList(workPermitID: self.permitID)
                    }
                    else {
                        //NEXT STEPS
                        self.redirectToNextForm(work_Permit_id: self.permitID)
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
            params["sub_contractors"] = ["subcontractors_list":self.arrSubContractor].convertToJSonString() //convertToJSONString(value:  self.arrSubContractor as AnyObject) ?? ""
            
            print(params)
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.CreateSubcontractors(param: params as typeAliasDictionary, response: {(dictResponse,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if "\(dictResponse["status"]!)" == "1" {
                    self.redirectToNextForm(work_Permit_id: workPermitID)
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

extension WorkPermitFormOneVC : UITextFieldDelegate , UITextViewDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if !isEditable {
            return false
        }
        if textField == txtSite {
            self.showSites()
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
        if !isEditable {
            return false
        }
        return true
    }
}
