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
    var isCameFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getSites()
        let df = DateFormatter.init()
        df.dateFormat = "MMM dd YYYY"
        self.lblDate.text = df.string(from: Date())
        
        df.dateFormat = "HH:mm"
        self.lblTime.text = df.string(from: Date())
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
    
    //MARK: CUSTOM METHODS
    
    func showSites() {
        let jdSelection = JDSelection.init(title: "Select Site", arrayItems: self.arrSites, arraySelected: [typeAliasDictionary](), VALUE_KEY: "name", ID_KEY: "id", IS_MULTI_SELECTION: false)
        jdSelection.onSelection = { arrSelected in
            self.txtSite.text = arrSelected.first!["name"] as! String
            self.siteID = arrSelected.first!["id"] as! String
        }
    }
    
    
    @IBAction func btnNextAction() {
        
        self.redirectToNextForm(work_Permit_id: "")
        
        return
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
        }   else if viewIsAsbestosRequired.isHidden == false {
                if (!chkAsbestosRequiredYes.isSelected && !chkAsbestosRequiredNo.isSelected) {
                    showFormValidationMessage();
                }
        }
        else if txtViewOtherSafetyChecks.text == "" {
            showFormValidationMessage();
        }
        else {
            // CALL API
            /*
             @Part("user_id") RequestBody user_id,
             @Part("category_id") RequestBody category_id,
             @Part("site_id") RequestBody site_id,
             @Part("site_date_of_work") RequestBody site_date_of_work,
             @Part("site_time") RequestBody site_time,
             @Part("site_location") RequestBody site_location,
             @Part("site_work_performed") RequestBody site_work_performed,
             @Part("site_regulations") RequestBody site_regulations,
             @Part("work_with_vehicles") RequestBody work_with_vehicles,
             @Part("hot_works_conducted") RequestBody hot_works_conducted,
             @Part("electricity_equipment_required") RequestBody electricity_equipment_required,
             @Part("coshh_produced") RequestBody coshh_produced,
             @Part("evacuation_required") RequestBody evacuation_required,
             @Part("overhead_obstructions") RequestBody overhead_obstructions,
             @Part("traffic_operating_area") RequestBody traffic_operating_area,
             @Part("fragile_roof_coverings") RequestBody fragile_roof_coverings,
             @Part("work_at_height") RequestBody work_at_height,
             @Part("isolation_segregation") RequestBody isolation_segregation,
             @Part("slip_trip_hazards") RequestBody slip_trip_hazards,
             @Part("site_other_safety_checks") RequestBody site_other_safety_checks

             */
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
            self.callCreateWorkPermitAPI(parmas: params)
        }

    }
    
    @IBAction func btnBackMenuAction() {
  
    }
    
    func showFormValidationMessage() {
        showAlertWithTitleWithMessage(message: "Please fill all details to proceed further")
    }
    
    func getYesNoCheckBoxValue(btnYes:UIButton , btnNo:UIButton) -> String {
        
        if btnYes.isSelected {
            return "1"
        }
        return "0"
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
            let vc = HotWorksFormVC.init(nibName: "HotWorksFormVC", bundle: nil)
            vc.permit_id = work_Permit_id
            self.navigationController?.pushViewController(vc, animated: true)
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

extension WorkPermitFormOneVC : UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtSite {
            self.showSites()
            return false
        }
        return true
    }
}
