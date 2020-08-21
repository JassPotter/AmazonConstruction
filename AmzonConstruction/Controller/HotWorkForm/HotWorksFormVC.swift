//
//  WorkPermitFormOneVC.swift
//  AmzonConstruction
//
//  Created by Dhaval Nagar on 16/08/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit

class HotWorksFormVC: UIViewController {

    //MARK: PROPERTIES
    @IBOutlet weak var txtSite: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtWorkToBePerformed: UITextField!
    @IBOutlet weak var txtViewOtherSafetyChecks: UITextView!
    @IBOutlet weak var viewIsAsbestosRequired: UIView!
    
    //CHECKBOX
    @IBOutlet  var chkBoxYes: [UIButton]!
    @IBOutlet  var chkBoxNo: [UIButton]!
    @IBOutlet  var chkBoxParameters: [UIButton]!

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
    var permit_id = ""
    var isEditable = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        /*else if (!chkWorkWithVehiclesYes.isSelected && !chkWorkWithVehicleNO.isSelected) {
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
        }*/
        else {
            // CALL API
            /*
             @Part("work_permit_id") RequestBody work_permit_id,
             @Part("hotwork_date_of_work") RequestBody hotwork_date_of_work,
             @Part("hotwork_time_of_work") RequestBody hotwork_time_of_work,
             @Part("hotwork_location") RequestBody hotwork_location,
             @Part("hotworks_performed") RequestBody hotworks_performed,
             @Part("immediate_access") RequestBody immediate_access,
             @Part("work_area_free") RequestBody work_area_free,
             @Part("housekeeping_area") RequestBody housekeeping_area,
             @Part("remaining_combustibles") RequestBody remaining_combustibles,
             @Part("isolation_energy") RequestBody isolation_energy,
             @Part("necessary_fire") RequestBody necessary_fire,
             @Part("hotwork_fire_safety_checks") RequestBody hotwork_fire_safety_checks,
             @Part("hotwork_other_safety_checks") RequestBody hotwork_other_safety_checks

             */
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
        return "0"
    }
    
    func getRegulations() -> String {
        var arrRegulations = [Int]()
        for i in 0..<5 {
            arrRegulations.append(i+1)
        }
        return convertToJSONString(value: arrRegulations as AnyObject) ?? ""
    }
    
    func getYesNoParams(params:typeAliasStringDictionary) -> typeAliasStringDictionary {
        
        /*
         @Part("work_area_free") RequestBody work_area_free,
         @Part("housekeeping_area") RequestBody housekeeping_area,
         @Part("remaining_combustibles") RequestBody remaining_combustibles,
         @Part("isolation_energy") RequestBody isolation_energy,
         @Part("necessary_fire") RequestBody necessary_fire,
         @Part("hotwork_fire_safety_checks") RequestBody hotwork_fire_safety_checks,
         */
        var dictParams = params
        let arrParams = ["work_area_free","housekeeping_area","remaining_combustibles","isolation_energy","necessary_fire","hotwork_fire_safety_checks"]
        
        for i in 0..<7 {
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
        
    }
    
}

extension HotWorksFormVC : AppNavigationControllerDelegate {
    func appNavigationController_BackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func appNavigationController_RightMenuAction() {
        
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

extension HotWorksFormVC : UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtSite {
            self.showSites()
            return false
        }
        return true
    }
}