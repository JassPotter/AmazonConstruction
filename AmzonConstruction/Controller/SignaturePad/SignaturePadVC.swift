//
//  SignaturePadVC.swift
//  AmzonConstruction
//
//  Created by Jashu Prajapati on 8/20/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit
import SignaturePad
protocol delegateSignPad  {
    func getImageFromSignPad(imgSign :UIImage,signPad:SignaturePad)
}
class SignaturePadVC: UIViewController {

    //MARK: PROPERTIES
    @IBOutlet weak var siganturePadBG: SignaturePad!
    
    //MARK: VARIABLES
    var delegate : delegateSignPad! = nil
    internal var intType : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
      override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.setNavigationBar()
        }
        
        //MARK: NAVIGATION BAR
        func setNavigationBar() {
            APP_SCENE_DELEGATE.navigationController.setBack()
            APP_SCENE_DELEGATE.navigationController.navigationDelegate = self
        }

    // MARK: - UIButton Action
    @IBAction func btnClearSaveAction(_ sender: UIButton) {
        if sender.tag == 1 {
            siganturePadBG.clear()
        }
        else {
            self.appNavigationController_BackAction()
        }
    }

}

extension SignaturePadVC : AppNavigationControllerDelegate {
    func appNavigationController_BackAction() {
        siganturePadBG.accessibilityValue = "\(intType)"
        self.delegate.getImageFromSignPad(imgSign: siganturePadBG.getSignature()!, signPad: siganturePadBG)
        self.navigationController?.popViewController(animated: true)
    }
}
