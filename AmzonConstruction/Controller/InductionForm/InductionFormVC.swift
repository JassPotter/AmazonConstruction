//
//  InductionFormVC.swift
//  AmzonConstruction
//
//  Created by Jashu Prajapati on 8/16/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit
import FCAlertView

class InductionFormVC: UIViewController {
    
    //MARK: PROPERTIES
    //stage 1
    @IBOutlet weak var viewStage1BG: UIView!
    @IBOutlet weak var constraintViewStage1BGHeight: NSLayoutConstraint!
    @IBOutlet weak var txtStage1Name: UITextField!
    @IBOutlet weak var txtStage1Company: UITextField!
    @IBOutlet weak var imageViewStage1Sign: UIImageView!
    //stage 2
    @IBOutlet weak var viewStage2BG: UIView!
    @IBOutlet weak var constraintViewStage2BGHeight: NSLayoutConstraint!
    @IBOutlet weak var txtStage2Name: UITextField!
    @IBOutlet weak var txtStage2Postion: UITextField!
    @IBOutlet weak var imageViewStage2Sign: UIImageView!
    @IBOutlet weak var viewStatge2NoteBG: UIView!
    @IBOutlet weak var txtViewStage2Note: UITextView!
    @IBOutlet weak var lblStage2NotePH: UILabel!
    //stage asbestos
    @IBOutlet weak var viewStageAsbestosBG: UIView!
    @IBOutlet weak var constraintViewStageAsbestosBGHeight: NSLayoutConstraint!
    @IBOutlet var btnViewAsbestosTopCollection: [UIButton]!
    @IBOutlet weak var txtViewAsbestosComment: UITextView!
    @IBOutlet weak var lblAsbestosCommentPH: UILabel!
    @IBOutlet var btnViewAsbestosQ1Collection: [UIButton]!
    @IBOutlet var btnViewAsbestosQ2Collection: [UIButton]!
    @IBOutlet var btnViewAsbestosQ3Collection: [UIButton]!
    @IBOutlet var btnViewAsbestosQ4Collection: [UIButton]!
    //Stage 4
    @IBOutlet weak var viewStage4BG: UIView!
    @IBOutlet weak var constraintViewStage4BGHeight: NSLayoutConstraint!
    @IBOutlet weak var txtStage4Name: UITextField!
    @IBOutlet weak var txtStage4Company: UITextField!
    @IBOutlet weak var imageViewStage4Sign: UIImageView!
    //stage 5
    @IBOutlet weak var viewStage5BG: UIView!
    @IBOutlet weak var constraintViewStage5BGHeight: NSLayoutConstraint!
    @IBOutlet weak var txtStage5Name: UITextField!
    @IBOutlet weak var txtStage5Position: UITextField!
    @IBOutlet weak var imageViewStage5Sign: UIImageView!
    
    @IBOutlet weak var btnSubmitFormBG: UIButton!
    
    
    
    //MARK: VARIABLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar()
//        switch intLoginType {
//        case 2:
//            //site manager
//            break
//        case 3:
//            //contractor
//            break
//        case 4:
//            //Region manager
//            break
//        case 5:
//            //Admin
//            break
//        default:break
//        }
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle { return UIStatusBarStyle.lightContent }
    
    //MARK: CUSTOM METHOD
    fileprivate func setNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        APP_SCENE_DELEGATE.navigationController.setCustomTitleWithImage(#imageLiteral(resourceName: "image_Amazon"))
        APP_SCENE_DELEGATE.navigationController.navigationDelegate = self
        APP_SCENE_DELEGATE.navigationController.setRightTitleMenu("Logout")
        APP_SCENE_DELEGATE.navigationController.setBack()
        
    }
    
    //MARK: UIBUTTON ACTION
    @IBAction func btnStage1SignAction() {
    }
    @IBAction func brnStage2SignAction() {
    }
    @IBAction func btnStage2AproveRejectAction(_ sender: UIButton) {
        if sender.tag == 1 {
            //approve
        }
        else {
            //reject
        }
    }
    @IBAction func btnStageAsbestosTopAction(_ sender: UIButton) {
    }
    @IBAction func btnViewAsbestosQ1Action(_ sender: UIButton) {
        
    }
    @IBAction func btnViewAsbestosQ2Action(_ sender: UIButton) {
    }
    @IBAction func btnViewAsbestosQ3Action(_ sender: UIButton) {
    }
    @IBAction func btnViewAsbestosQ4Action(_ sender: UIButton) {
    }
    @IBAction func btnStage4SignAction() {
    }
    @IBAction func btnStage5SignAction() {
    }
    @IBAction func btnBackToMainAction() {
    }
    @IBAction func btnSubmitFormAction(_ sender: UIButton) {
    }
    
    
}
extension InductionFormVC : AppNavigationControllerDelegate {
    func appNavigationController_RightMenuAction() {
        let alert : FCAlertView = FCAlertView()
        alert.delegate = self
        alert.accessibilityValue = "LOGOUT"
        showAlertWithTitleWithMessageAndButtons(message: MSG_ID_LOGOUT, alert: alert, buttons: ["Cancel"], withDoneTitle:"Logout", alertTitle: APP_NAME)
    }
    func appNavigationController_BackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension InductionFormVC : FCAlertViewDelegate {
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        if alertView.accessibilityValue == "LOGOUT" {
            GetSetModel.removeObjectForKey(objectKey: UD_KEY_APPUSER_INFO)
            APP_SCENE_DELEGATE.setLoginVC()
        }
    }
    func fcAlertView(_ alertView: FCAlertView!, clickedButtonIndex index: Int, buttonTitle title: String!) {
        
    }
}
