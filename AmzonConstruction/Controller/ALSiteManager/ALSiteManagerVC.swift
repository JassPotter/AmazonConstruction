//
//  ALSiteManagerVC.swift
//  AmzonConstruction
//
//  Created by Jashu Prajapati on 8/14/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit
import FCAlertView

class ALSiteManagerVC: UIViewController {
    
    //MARK: PROPERTIES
    @IBOutlet weak var constraintViewTopHeight: NSLayoutConstraint!
    @IBOutlet weak var viewTopTitleBG: UIView!
    //    @IBOutlet var lblTopTitleCollection: [UILabel]!
    @IBOutlet weak var lblAllValue: UILabel!
    @IBOutlet weak var lblPendingValue: UILabel!
    @IBOutlet weak var lblApprovedValue: UILabel!
    @IBOutlet weak var lblSignedOffValue: UILabel!
    @IBOutlet weak var tableViewBG: UITableView!
    
    
    //MARK: VARIABLES
    internal var intLoginType : Int = 2
    internal var strSiteId : String = ""

    fileprivate var arrList : [typeAliasDictionary] = [typeAliasDictionary]()
    fileprivate var arrListSelected : [typeAliasDictionary] = [typeAliasDictionary]()
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewBG.register(UINib.init(nibName: CELL_IDENTIFIER_AL_SITE_MANAGER, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER_AL_SITE_MANAGER)
        tableViewBG.tableFooterView = UIView(frame: CGRect.zero)
        tableViewBG.rowHeight = UITableView.automaticDimension
        tableViewBG.estimatedRowHeight = 150
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(sender:)), for: .valueChanged)
        self.tableViewBG.addSubview(refreshControl)
    }
    @objc func refresh(sender:AnyObject)
    {
        self.viewWillAppear(false)
        self.refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar()
        self.viewTopTitleBG.isHidden = false
        self.constraintViewTopHeight.constant = 95
        switch intLoginType {
        case 2:
            //site manager
            self.getList(isRegion: false)
            break
        case 3:
            //contractor
            self.viewTopTitleBG.isHidden = true
            self.constraintViewTopHeight.constant = 0
            self.getList(isRegion: false)
            break
        case 4:
            //Region manager
            self.getList(isRegion: true)
            break
        case 5:
            //Admin
            self.getList(isRegion: true)
            break
        default:break
        }
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle { return UIStatusBarStyle.lightContent }
    
    //MARK: CUSTOM METHOD
    fileprivate func setNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        APP_SCENE_DELEGATE.navigationController.setCustomTitleWithImage(#imageLiteral(resourceName: "image_Amazon"))
        APP_SCENE_DELEGATE.navigationController.navigationDelegate = self
//        APP_SCENE_DELEGATE.navigationController.setRightTitleMenu("Logout")
        if intLoginType != 2 { APP_SCENE_DELEGATE.navigationController.setBack() }
        else { APP_SCENE_DELEGATE.navigationController.setLeftBack() }

    }
    
    func getList(isRegion : Bool) {
        self.arrList = [typeAliasDictionary]()
        var param : typeAliasDictionary = typeAliasDictionary()
        if isRegion {
            param["site_id"] = strSiteId as AnyObject
        }
        else {
            param["user_type"] = APP_SCENE_DELEGATE.dictUserInfo["user_type"] as AnyObject
            param["user_id"] = APP_SCENE_DELEGATE.dictUserInfo["user_id"] as AnyObject
        }
        if isConnectedToNetwork(){
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.callDashboard(param: param, isRegion: isRegion, response: {(respDic,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if rstatus == 1{
                    self.arrList = respDic[RES_data] as! [typeAliasDictionary]
                    self.arrListSelected = self.arrList
                    self.tableViewBG.reloadData()
                    self.lblAllValue.text = "\(self.arrList.count)"
                    var newArrUsingMap = self.arrList.filter { (dict1) -> Bool in
                        (dict1["work_permit"]as! typeAliasDictionary)["status"] as! String == "1" }
                    self.lblPendingValue.text = "\(newArrUsingMap.count)"
                    
                    newArrUsingMap = self.arrList.filter { (dict1) -> Bool in
                    (dict1["work_permit"]as! typeAliasDictionary)["status"] as! String == "3" }
                    self.lblApprovedValue.text = "\(newArrUsingMap.count)"
                    
                    newArrUsingMap = self.arrList.filter { (dict1) -> Bool in
                    (dict1["work_permit"]as! typeAliasDictionary)["status"] as! String == "5" }
                    self.lblSignedOffValue.text = "\(newArrUsingMap.count)"
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
    
    func sortDataByDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy h:mm a"
        self.arrListSelected = self.arrListSelected.sorted(by: { (dict1, dict2) -> Bool in
            let date1 : Date = dateFormatter.date(from: dict1["date_completed"]as! String)!
            let date2 : Date = dateFormatter.date(from: dict2["date_completed"]as! String)!
            return date1 > date2
        })
    }
    
    //MARK: UIBUTTON ACTION
    @IBAction func btnTopAction(_ sender: UIButton) {
           switch sender.tag {
           case 1:
               self.arrListSelected = self.arrList
               break
           case 2:
               self.arrListSelected = self.arrList.filter { (dict1) -> Bool in
               (dict1["work_permit"]as! typeAliasDictionary)["status"] as! String == "1" }
           break
           case 3:
               self.arrListSelected = self.arrList.filter { (dict1) -> Bool in
               (dict1["work_permit"]as! typeAliasDictionary)["status"] as! String == "3" }
           break
           case 4:
               self.arrListSelected = self.arrList.filter { (dict1) -> Bool in
               (dict1["work_permit"]as! typeAliasDictionary)["status"] as! String == "5" }
           break
           default:
               break
           }
           self.tableViewBG.reloadData()
       }
}
extension ALSiteManagerVC : AppNavigationControllerDelegate {
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
extension ALSiteManagerVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.arrListSelected.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ALSiteManagerCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER_AL_SITE_MANAGER, for: indexPath) as! ALSiteManagerCell
        let dict : typeAliasDictionary = self.arrListSelected[indexPath.row]
        let dictInner : typeAliasDictionary = dict["work_permit"]as! typeAliasDictionary
        var strInnerV : String = ""
        let arrIL : [typeAliasDictionary] = dict["sub_contractors"] as! [typeAliasDictionary]
        for dict1 in arrIL {
            strInnerV.append("\n+ \(dict1["first_name"]!) \(dict1["sur_name"]!)")
        }
        cell.lblRefNo.text = "AMZ \(dictInner["work_permit_id"]!)\n\(dictInner["contractor_name"]!)\n\(dictInner["contractor_company"]!)\n\(dictInner["contractor_contact_no"]!)\("\n\(strInnerV)")"
        cell.lblSite.text = "\(dictInner["site_name"]!)\nDate\n\(dictInner["date_created"]!)"
        var strV : String = ""
        switch Int(dictInner["status"]as! String)! {
        case 1: strV = "Form completed Awaiting Approval" ; break
        case 2: strV = "Rejected" ; break
        case 3: strV = "Approved" ; break
        case 4: strV = "Contractor Signed off" ; break
        case 5: strV = "Signed Off & Complete" ; break
        default: break
        }
        cell.lblStatus.text = strV
        cell.viewBG.backgroundColor = strV == "Approved" ? Color_Theme_PendingYellow : (strV == "Signed Off & Complete" ? Color_Them_ApproveGreen : .white)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict : typeAliasDictionary = self.arrListSelected[indexPath.row]
        let dictInner : typeAliasDictionary = dict["work_permit"]as! typeAliasDictionary
        if Int(APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String)! == 2 {
            //site manager
            if dictInner["status"]as! String == "1" || dictInner["status"]as! String == "2" {
                //redirect to olf form with fill without editable
                if let dictWorkPermit = dict["work_permit"] as? typeAliasDictionary {
                    let selectedCategoryID = "\(dictWorkPermit["category_id"]!)"
                    let vc  = WorkPermitFormOneVC.init(nibName: "WorkPermitFormOneVC", bundle: nil)
                    vc.categoryID = selectedCategoryID
                    if let dictSubContractors = dict["sub_contractors"] as? [typeAliasStringDictionary]{
                        vc.arrSubContractor = dictSubContractors
                    }
                    vc.dictFormData = dict
                    vc.isEditable = false
                    vc.permitID = "\(dictWorkPermit["work_permit_id"]!)"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else {
                //status approve and above
                let vc = InductionFormVC.init(nibName: "InductionFormVC", bundle: nil)
                vc.dictPageInfo = dict
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
        }
        else {
            //contractor
           /* if dictInner["status"]as! String == "2" {
                //status reject //redirect to olf form with fill with editable
                if let dictWorkPermit = dict["work_permit"] as? typeAliasDictionary {
                    let selectedCategoryID = "\(dictWorkPermit["category_id"]!)"
                    let vc  = WorkPermitFormOneVC.init(nibName: "WorkPermitFormOneVC", bundle: nil)
                    vc.categoryID = selectedCategoryID
                    if let dictSubContractors = dict["sub_contractors"] as? [typeAliasStringDictionary]{
                        vc.arrSubContractor = dictSubContractors
                    }
                    vc.dictFormData = dict
                    vc.isEditable = true
                    vc.permitID = "\(dictWorkPermit["work_permit_id"]!)"
                    self.navigationController?.pushViewController(vc, animated: true)
                }

                
            }
            else {
                let vc = InductionFormVC.init(nibName: "InductionFormVC", bundle: nil)
                vc.dictPageInfo = dict
                self.navigationController?.pushViewController(vc, animated: true)
            } */
            
            let vc = InductionFormVC.init(nibName: "InductionFormVC", bundle: nil)
            vc.dictPageInfo = dict
            vc.isCameFromDashboard = true
            self.navigationController?.pushViewController(vc, animated: true)

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return UITableView.automaticDimension }
    
}

extension ALSiteManagerVC : FCAlertViewDelegate {
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        if alertView.accessibilityValue == "LOGOUT" {
            GetSetModel.removeAllKeyFromDefault()
            APP_SCENE_DELEGATE.setLoginVC()
        }
    }
    func fcAlertView(_ alertView: FCAlertView!, clickedButtonIndex index: Int, buttonTitle title: String!) {
        
    }
}
