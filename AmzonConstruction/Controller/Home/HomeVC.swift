//
//  HomeVC.swift
//  FitnessFood
//
//  Created by Jashu Prajapati on 5/5/20.
//  Copyright © 2020 MyOwnOrganization. All rights reserved.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController {
    
    //MARK: PROPERTIES
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var tableViewBG: UITableView!
    @IBOutlet var viewRightNavigationBG: UIView!
    @IBOutlet weak var lblCartCount: UILabel!
    //MARK: VARIABLES
    fileprivate var arrList : [typeAliasDictionary] = [typeAliasDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewBG.register(UINib.init(nibName: CELL_IDENTIFIER_HOME, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER_HOME)
        tableViewBG.tableFooterView = UIView(frame: CGRect.zero)
        tableViewBG.rowHeight = HEIGHT_HOME_CATEGORY
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar()
        self.getCategoryList()
    }
    
    //MARK: NAVIGATION BAR
    func setNavigationBar() {
        UIApplication.shared.isStatusBarHidden = false
        APP_SCENE_DELEGATE.navigationController.setSideMenu()
        APP_SCENE_DELEGATE.navigationController.navigationDelegate = self
        APP_SCENE_DELEGATE.navigationController.setCustomTitleWithImage(#imageLiteral(resourceName: "icon_AppLogo"))
        self.lblCartCount.text = "0 items"
        let count = GetSetModel.getStringValueFromUserDefaults(UD_KEY_CART_COUNT)
        if count != "" {
            self.lblCartCount.text = "\(count) Items"
        }
        
        APP_SCENE_DELEGATE.navigationController.setRightView(view: self.viewRightNavigationBG)
        //        APP_SCENE_DELEGATE.navigationController.setRightButton(cartItem: 0)
    }
    
    
    
    //MARK: Custom Method
    func getCategoryList() {
        if isConnectedToNetwork(){
            let param : typeAliasDictionary = typeAliasDictionary()
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.getHomeCategoryList(param: param, response: {(arrL,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if rstatus == 1{
                    //                    self.getLogin()
                    self.arrList = [typeAliasDictionary]()
                    self.arrList.append(contentsOf: arrL)
                    self.tableViewBG.reloadData()
                }else{
                    showAlertWithTitleWithMessage(message: message)
                }
            })
        }else{
            showNoInternetAlert()
        }
    }
    func getLogin() {
        if isConnectedToNetwork(){
            var param : typeAliasDictionary = typeAliasDictionary()
            param["email"] = "ramupal2613@gmail.com" as AnyObject
            param["password"] = "123456" as AnyObject
            param["reg_id"] = "" as AnyObject
            
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.getLogin(param: param, response: {(arrL,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if rstatus == 1{
                    print(arrL)
                }else{
                    showAlertWithTitleWithMessage(message: message)
                }
            })
        }else{
            showNoInternetAlert()
        }
    }
}

extension HomeVC : UITableViewDataSource,UITableViewDelegate {
    //MARK: TABLE VIEW DATA SOURCE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return arrList.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER_HOME) as! HomeCell
        let dict : typeAliasDictionary = self.arrList[indexPath.row]
        cell.lblPrice.text = "£\(dict[RES_price]!)"
        cell.lblCategoryName.text = "\(dict[RES_name]!)"
        cell.lblTotalMeal.text = "order 5 meals"
        cell.btnOrderNow.accessibilityValue = "\(indexPath.row)"
        cell.imageViewBG.sd_setImage(with: URL.init(string: "\(dict[RES_image_url]!)")) { (img, error, type, urlM) in
            if img == nil { cell.imageViewBG.image = #imageLiteral(resourceName: "image_Food_ItemBG") }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let paymentVc = PaymentVC.init(nibName: "PaymentVC", bundle: nil)
//        paymentVc.dictFinal = typeAliasDictionary()
//        paymentVc.totalPayment = 0.0
//        self.navigationController?.pushViewController(paymentVc, animated: true)
    }
    
}
extension HomeVC : AppNavigationControllerDelegate {
    func appNavigationController_SideMenuAction() {
        let jdSideMenu : JD_SideMenu = JD_SideMenu()
        self.navigationController?.view.addSubview(jdSideMenu)
    }
    func appNavigationController_RightMenuAction() {
    }
}
