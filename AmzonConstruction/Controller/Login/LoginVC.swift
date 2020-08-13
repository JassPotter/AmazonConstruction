//
//  LoginViewController.swift
//  FitnessFood
//
//  Created by  YASH COMPUTERS on 05/05/20.
//  Copyright © 2020 MyOwnOrganization. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //MARK: PROPERTIES
    @IBOutlet weak var txtEmailOrMobile: UITextField!
    @IBOutlet weak var viewLogoBG: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgViewLogo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewLogoBG.cornerRadius = 24
        viewLogoBG.round(corners: [.topLeft,.topRight,.bottomRight], radius: 24)
        self.view.isHidden = false
        
    }
    
    //MARK: NAVIGATION BAR
    func setNavigationBar() {
        UIApplication.shared.isStatusBarHidden = false
        APP_SCENE_DELEGATE.navigationController.navigationDelegate = self
        APP_SCENE_DELEGATE.navigationController.setBack()
        APP_SCENE_DELEGATE.navigationController.setCustomTitle("Login to your account")
    }

    
    //MARK: BUTTON METHODS
    @IBAction func btnLoginClickAction() {
        let stEmail = txtEmailOrMobile.text!
        let stpassword = txtPassword.text!
        if stEmail.isEmpty {
            showAlertWithTitleWithMessage(message: MSG_TXT_EMAIL)
            return
        }
        if stpassword.isEmpty {
            showAlertWithTitleWithMessage(message: MSG_TXT_PASSCODE)
            return
        }
        txtEmailOrMobile.resignFirstResponder()
        txtPassword.resignFirstResponder()
        self.callLoginAPI(email: stEmail, password: stpassword)
    }
    
    @IBAction func btnSignUpClickAction() {
//        let signUpVC = SignUpVC.init(nibName: "SignUpVC", bundle: nil)
//        self.navigationController?.pushViewController(signUpVC, animated:   true)
    }
    
    @IBAction func btnForgotPasswordClickAction() {
//        let forgotPasswordVC = ForgotPasswordVC.init(nibName: "ForgotPasswordVC", bundle: nil)
//        forgotPasswordVC.stEmail = txtEmailOrMobile.text!
//        self.navigationController?.pushViewController(forgotPasswordVC, animated:   true)

    }
}

extension LoginVC : AppNavigationControllerDelegate {
    func appNavigationController_BackAction() {
//        APP_SCENE_DELEGATE.setHomeVC()
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: TEXTFIELD DELEGATE
extension LoginVC:UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmailOrMobile {
            txtPassword.becomeFirstResponder()
        }
        if textField == txtPassword {
            txtPassword.resignFirstResponder()
        }
        return true
    }
}

//MARK: API CALL

extension LoginVC {
    
    func callLoginAPI(email:String,password:String) {
        var params = typeAliasDictionary()
        params[REQ_email] = email as AnyObject
        params[REQ_password] = password as AnyObject
        params[REQ_reg_id] = "fBf6GCyV9kxqqFMt7QzI9I:APA91bHmRD3diM2F-d_WizXkBj59AJ0mWoraxGL1v2eSlLgrd72CY4AB2HLPWj9LUGuB6UxqfRurYhXJBsmueLiVOpArAl0tFo1Yyn7Vflte1f3EBbUmcE2_NSjDGeV3uMvOhYJgcR8I" as AnyObject
        if isConnectedToNetwork(){
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.getLogin(param: params, response: {(dictResponse,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()

                if !dictResponse.isEmpty {
                    if "\(dictResponse["status"]!)" == "1" {
                        showAlertWithTitleWithMessage(message: "Login Successful")
                        GetSetModel.setObjectToUserDefaults(objValue: (dictResponse["datas"] as! [typeAliasDictionary]).first!, ForKey: UD_KEY_APPUSER_INFO)
                        self.appNavigationController_BackAction()
                    }
                    else {
                        showAlertWithTitleWithMessage(message: "\(dictResponse[RES_message]!)")
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
}
