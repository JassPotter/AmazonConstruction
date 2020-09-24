//
//  LoginViewController.swift
//  FitnessFood
//
//  Created by  YASH COMPUTERS on 05/05/20.
//  Copyright © 2020 MyOwnOrganization. All rights reserved.
//

import UIKit
import AVFoundation

class LoginVC: UIViewController {

    //MARK: PROPERTIES
    @IBOutlet weak var txtEmailOrMobile: UITextField!
    @IBOutlet weak var viewLogoBG: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgViewLogo: UIImageView!
    @IBOutlet weak var viewScannerBG: UIView!
    
    //MARK: VARIABLES
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.callLoginAPI(email: "2@2", password: "")
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
        setQRView()
    }

    //MARK: NAVIGATION BAR
    func setNavigationBar() {
        UIApplication.shared.isStatusBarHidden = false
        APP_SCENE_DELEGATE.navigationController.navigationDelegate = self
        APP_SCENE_DELEGATE.navigationController.setBack()
        APP_SCENE_DELEGATE.navigationController.setCustomTitle("Login to your account")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
        params["user_id"] = email as AnyObject
//        params["password"] = password as AnyObject
        params["user_type"] = "2" as AnyObject
//        params["token"] = "fBf6GCyV9kxqqFMt7QzI9I:APA91bHmRD3diM2F-d_WizXkBj59AJ0mWoraxGL1v2eSlLgrd72CY4AB2HLPWj9LUGuB6UxqfRurYhXJBsmueLiVOpArAl0tFo1Yyn7Vflte1f3EBbUmcE2_NSjDGeV3uMvOhYJgcR8I" as AnyObject
        params["token"] = getAccessToken() as AnyObject
        if isConnectedToNetwork() {
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.getLogin(param: params, response: {(dictResponse,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()

                if !dictResponse.isEmpty {
                    if "\(dictResponse["status"]!)" == "true" {
//                        showAlertWithTitleWithMessage(message: "Login Successful")
                        GetSetModel.setObjectToUserDefaults(objValue: (dictResponse["data"] as! [typeAliasDictionary]).first!, ForKey: UD_KEY_APPUSER_INFO)
                        APP_SCENE_DELEGATE.dictUserInfo = (dictResponse["data"] as! [typeAliasDictionary]).first!
//                        self.appNavigationController_BackAction()
                        APP_SCENE_DELEGATE.setRootVC()
                        return
                       switch APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String {
                        case "2":
                            //site manager
                            let vc = ALSiteManagerVC.init(nibName: "ALSiteManagerVC", bundle: nil)
                            vc.intLoginType = Int(APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String)!
                            self.navigationController?.pushViewController(vc, animated: true)
                            break
                        case "3":
                            //contractor
                            let vc = ALContractorVC.init(nibName: "ALContractorVC", bundle: nil)
                            self.navigationController?.pushViewController(vc, animated: true)
                            break
                        case "4":
                            //Region manager
                            let vc = ALReligionManagerVC.init(nibName: "ALReligionManagerVC", bundle: nil)
                            vc.isDirect = true
                            vc.arrList = APP_SCENE_DELEGATE.dictUserInfo["site_details"] as! [typeAliasDictionary]
                            self.navigationController?.pushViewController(vc, animated: true)
                            break
                        case "5":
                            let vc = ALPhosterAdminVC.init(nibName: "ALPhosterAdminVC", bundle: nil)
                            self.navigationController?.pushViewController(vc, animated: true)
                            //Admin
                            break
                        default:break
                    }
                    }
                    else {
                        showAlertWithTitleWithMessage(message: "Invalid Email Or Password.")
                        self.captureSession?.startRunning()
                    }
                }
                else {
                    showAlertWithTitleWithMessage(message: SOMETHING_WRONG)
                    self.captureSession?.startRunning()
                }
            })
        } else {
            showNoInternetAlert()
        }

    }
}
extension LoginVC : AVCaptureMetadataOutputObjectsDelegate {
    func setQRView () {
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {return}
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = viewScannerBG.layer.bounds
            viewScannerBG.layer.addSublayer(videoPreviewLayer!)
            
            captureSession?.startRunning()
            
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                self.viewScannerBG.addSubview(qrCodeFrameView)
                self.view.bringSubviewToFront(viewScannerBG)
            }
            
            //                    captureSession?.startRunning()
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            //messageLabel.text = "No QR/barcode is detected"
            print("No QR/barcode is detected")
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if [AVMetadataObject.ObjectType.qr].contains(metadataObj.type) {
            
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                
                captureSession?.stopRunning()
                print(metadataObj.stringValue as Any)
                self.callLoginAPI(email: "\(metadataObj.stringValue!)", password: "")
            }
        }
    }
}
