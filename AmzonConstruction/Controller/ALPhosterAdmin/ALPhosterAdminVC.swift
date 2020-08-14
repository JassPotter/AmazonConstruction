//
//  ALPhosterAdminVC.swift
//  AmzonConstruction
//
//  Created by Jashu Prajapati on 8/14/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit

class ALPhosterAdminVC: UIViewController {

    //MARK: PROPERTIES
    @IBOutlet weak var lblChoosenTitle: UILabel!
    
    
    //MARK: VARIABLES
    fileprivate var arrList : [typeAliasDictionary] = [typeAliasDictionary]()
    fileprivate var arrListSelected : [typeAliasDictionary] = [typeAliasDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar()
        self.getList()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle { return UIStatusBarStyle.lightContent }
    
    //MARK: CUSTOM METHOD
    fileprivate func setNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func getList() {
        self.arrList = [typeAliasDictionary]()
        self.arrListSelected = [typeAliasDictionary]()
        if isConnectedToNetwork(){
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.getClusterList(param: typeAliasDictionary(), response: {(respDic,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if rstatus == 1{
                    self.arrList = respDic as! [typeAliasDictionary]
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
    
    @IBAction func btnSelectOptionAction(_ sender: UIButton) {
        if sender.tag == 1 {
            //select cluster
            let jdSelection:JDSelection = JDSelection.init(title: APP_NAME, arrayItems: self.arrList, arraySelected: self.arrListSelected, VALUE_KEY: "name", ID_KEY: "id", IS_MULTI_SELECTION:false)
            jdSelection.onSelection = { arr1Selected in
                //MARK: Select Item
                self.arrListSelected = arr1Selected
                self.lblChoosenTitle.text = (arr1Selected.first!["name"] as! String)
            }
        }
        else {
            //go to next
            if self.arrListSelected.isEmpty {
                showAlertWithTitleWithMessage(message: "Select cluster")
                return
            }
            let vc = ALReligionManagerVC.init(nibName: "ALReligionManagerVC", bundle: nil)
            vc.isDirect = false
            vc.strClusterId = self.arrListSelected.first!["id"] as! String
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
