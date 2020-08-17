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
    
    
    @IBAction func btnNextAction() {
        
        
        if !chkBoxSiteRegulations.isSelected {
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
        } else if (!chkAsbestosRequiredYes.isSelected && !chkAsbestosRequiredNo.isSelected) {
            showFormValidationMessage();
        }  else {
            
        }

    }
    
    @IBAction func btnBackMenuAction() {
  
    }
    
    func showFormValidationMessage() {
        showAlertWithTitleWithMessage(message: "Please fill all details to proceed further")
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
