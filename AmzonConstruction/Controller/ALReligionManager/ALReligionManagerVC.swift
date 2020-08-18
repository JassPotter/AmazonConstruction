//
//  ALReligionManagerVC.swift
//  AmzonConstruction
//
//  Created by Jashu Prajapati on 8/14/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit
import FCAlertView

class ALReligionManagerVC: UIViewController {
    
    //MARK: PROPERTIES
    @IBOutlet weak var tableViewBG: UITableView!
    
    //MARK: VARIABLES
    internal var isDirect : Bool = false
    internal var strClusterId : String = ""
    internal var arrList : [typeAliasDictionary] = [typeAliasDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewBG.register(UINib.init(nibName: CELL_IDENTIFIER_AL_RELIGION_MANAGER, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER_AL_RELIGION_MANAGER)
        tableViewBG.tableFooterView = UIView(frame: CGRect.zero)
        tableViewBG.rowHeight = UITableView.automaticDimension
        tableViewBG.estimatedRowHeight = 80
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar()
        if strClusterId != "" {
            self.getList()
        }
        else {
            self.tableViewBG.reloadData()
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle { return UIStatusBarStyle.lightContent }
    
    //MARK: CUSTOM METHOD
    fileprivate func setNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        APP_SCENE_DELEGATE.navigationController.setCustomTitleWithImage(#imageLiteral(resourceName: "image_Amazon(s)"))
        APP_SCENE_DELEGATE.navigationController.navigationDelegate = self
        APP_SCENE_DELEGATE.navigationController.setRightTitleMenu("Logout")
        if !isDirect { APP_SCENE_DELEGATE.navigationController.setBack() }
        else { APP_SCENE_DELEGATE.navigationController.setLeftBack() }
    }
    
    func getList() {
           self.arrList = [typeAliasDictionary]()
           let param : typeAliasDictionary = ["cluster_id" : strClusterId as AnyObject]
           if isConnectedToNetwork(){
               APP_SCENE_DELEGATE.showAppLoader()
               ServiceCollection.sharedInstance.getClusterSiteList(param: param, response: {(respDic,rstatus,message) in
                   APP_SCENE_DELEGATE.removeAppLoader()
                   if rstatus == 1{
                    self.arrList = respDic
                    self.tableViewBG.reloadData()
                   }
                   else{
                       showAlertWithTitleWithMessage(message: message)
                   }
               })
           }
           else{
               showNoInternetAlert()
           }
       }
    
    //MARK: UIBUTTON ACTION
    
}
extension ALReligionManagerVC : AppNavigationControllerDelegate {
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
extension ALReligionManagerVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.arrList.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ALReligionManagerCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER_AL_RELIGION_MANAGER, for: indexPath) as! ALReligionManagerCell
        let dict : typeAliasDictionary = self.arrList[indexPath.row]
        cell.lblContractorList.text = "\(dict[APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String == "5" ? "no_of_contractors" : "contractor_details"]!) Approved constractors currently working on site"
        cell.lblSite.text = (dict[APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String == "5" ? "name" : "site_name"]as! String)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ALSiteManagerVC.init(nibName: "ALSiteManagerVC", bundle: nil)
        vc.intLoginType = Int(APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String)!
        vc.strSiteId = (self.arrList[indexPath.row])[((self.arrList[indexPath.row]).isKeyNull("id") ? "site_id" : "id")]as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return UITableView.automaticDimension }
    
}

extension ALReligionManagerVC : FCAlertViewDelegate {
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        if alertView.accessibilityValue == "LOGOUT" {
            GetSetModel.removeObjectForKey(objectKey: UD_KEY_APPUSER_INFO)
            APP_SCENE_DELEGATE.setLoginVC()
        }
    }
    func fcAlertView(_ alertView: FCAlertView!, clickedButtonIndex index: Int, buttonTitle title: String!) {
        
    }
}

