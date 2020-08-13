//
//  JD_SideMenu.swift
//  CalcVault
//
//  Created by Setblue on 24/07/18.
//  Copyright © 2018 Setblue. All rights reserved.
//

import UIKit
import FCAlertView

class JD_SideMenu: UIView,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: CONSTANT
    internal let TAG_SUPPER: Int = 10000
    let SELECTION_SUPER_VIEW_TAG            = 10001
    let SELECTION_SUB_VIEW_TAG              = 110001
    
    let COLOUR_BG                           = COLOR_CUSTOM(255, 255, 255, 1)
    let COLOUR_WHITE_TRANSPARENT            = COLOR_CUSTOM(255, 255, 255, 0.4)
    let COLOUR_BLACK_TRANSPARENT            = COLOR_CUSTOM(0, 0, 0, 0.4)
    
    let TAG_TITLE                           = 1001
    let TAG_IMAGE                           = 1000
    let TAG_SUB_TITLE                       = 1003
    let TAG_SUB_IMAGE                       = 1004
    
    let TAG_ICON                             = 100
    let TEXT_SUB: CGFloat                    = 14
    let TEXT_MAIN: CGFloat                   = 14
    
    //MARK: PROPERTIES
    @IBOutlet var ViewBG: UIView!
    @IBOutlet weak var tableViewBG: UITableView!
    
    //MARK: VARIABLES
    var width:CGFloat = 0
    var arrList = [String]()
    var arrSections = NSIndexSet()
    var constrintLeading:NSLayoutConstraint!
    var selectedSection:Int = -1
    var selectedRow:Int = -1
    var isSubChild:Bool = false
    var SubCount:Int = 0
    var counter:Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadXIB(){
        let view = Bundle.main.loadNibNamed(String(describing: type (of: self)), owner: self, options: nil)?[0] as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        self.layoutIfNeeded()
    }
    
    override init(frame :CGRect){
        super.init(frame: frame)
        self.loadXIB()
        let frame:CGRect = UIScreen.main.bounds
        self.frame = frame
        self.backgroundColor = COLOUR_BLACK_TRANSPARENT
        self.loadData()
        let gestureTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideMenuAction))
        self.isUserInteractionEnabled = true
        self.isMultipleTouchEnabled = true
        self.tag = SELECTION_SUPER_VIEW_TAG
        gestureTap.delegate = self
        self.addGestureRecognizer(gestureTap)
        width = frame.width * 0.75
        
        let dict:typeAliasDictionary = DesignModel.setConstraint_Leading_Top_ConWidth_ConHeight(subView: ViewBG, superView: self, leading: -width, top: 0, width: width, height: self.frame.height)
        constrintLeading = (dict[CONSTRAINT_LEADING] as! NSLayoutConstraint)
        self.alpha = 1
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {() -> Void in
            self.alpha = 1
        }, completion: {(finished: Bool) -> Void in
            self.constrintLeading.constant = 0
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {() -> Void in
                self.layoutIfNeeded()
            }, completion: nil)
        })
    }
    internal func loadData()
    {
        arrList = ["Home","Reviews","Menu","FAQ","Contact Us","\(GetSetModel.iskeyAlreadyExist(key: UD_KEY_APPUSER_INFO) ? "My Account" : "Login")"]
//        arrList = ["Home","Reviews","Menu","My Orders","FAQ","Contact Us","\(GetSetModel.iskeyAlreadyExist(key: UD_KEY_APPUSER_INFO) ? "My Account" : "Login")"]
        tableViewBG.register(UINib.init(nibName: CELL_IDENTIFIER_SIDE_MENU, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER_SIDE_MENU)
        tableViewBG.tableFooterView = UIView(frame: CGRect.zero)
        tableViewBG.rowHeight = HEIGHT_SIDE_MENU
        tableViewBG.bounces = false
        tableViewBG.reloadData()
        tableViewBG.allowsSelection = true
    }
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
    @objc internal func hideMenuAction() {
        constrintLeading.constant = -width
        UIView.animate(withDuration: 0.3, delay: 0.0, options:UIView.AnimationOptions.beginFromCurrentState, animations: {() -> Void in
            self.layoutIfNeeded()
        }, completion: {(finished: Bool) -> Void in
            UIView.animate(withDuration: 0.3, delay: 0.0, options:UIView.AnimationOptions.beginFromCurrentState, animations: {() -> Void in
                self.alpha = 0
            }, completion: {(finished: Bool) -> Void in
                self.removeFromSuperview()
                self.layer.removeAllAnimations()
            })
        })
    }
    
    //MARK: UI GESTURE RRECOGNIZER
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let view: UIView = touch.view!
        let viewTag: Int = Int(view.tag)
        //        print("Touch View Tag : \(viewTag)")
        if viewTag != SELECTION_SUPER_VIEW_TAG { return false }
        return true
    }
    
    @IBAction func btnCloseAction() {
        self.hideMenuAction()
    }
    
    @IBAction func btnLogoutAction() {
         GetSetModel.removeAllKeyFromDefault()
//                   hideMenuAction()
                    let alert : FCAlertView = FCAlertView()
                    alert.delegate = self
                    alert.accessibilityValue = "LOGOUT"
        showAlertWithTitleWithMessageAndButtons(message: MSG_ID_LOGOUT, alert: alert, buttons: ["Cancel"], withDoneTitle:"Logout", alertTitle: APP_NAME)
    }
    
    //MARK: TABLE VIEW DATA SOURCE
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return arrList.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SideMenuCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER_SIDE_MENU) as! SideMenuCell
        let str : String = self.arrList[indexPath.row]
        cell.lblTittle.text = str
        drawDottedLine(start: CGPoint(x: cell.frame.minX, y: cell.frame.maxY - 2), end: CGPoint(x: cell.frame.maxX, y: cell.frame.maxY - 2), view: cell)
        if str == "Home" { cell.imageViewBG.image = #imageLiteral(resourceName: "icon_Home")}
        else if str == "Reviews" { cell.imageViewBG.image = #imageLiteral(resourceName: "icon_Ratings")}
        else if str == "Menu" { cell.imageViewBG.image = #imageLiteral(resourceName: "icon_MenuList")}
//        else if str == "My Orders" { cell.imageViewBG.image = #imageLiteral(resourceName: "icon_OrderList")}
        else if str == "FAQ" { cell.imageViewBG.image = #imageLiteral(resourceName: "icon_FAQ")}
        else if str == "Contact Us" { cell.imageViewBG.image = #imageLiteral(resourceName: "icon_User")}
        else if str == "Login" { cell.imageViewBG.image = #imageLiteral(resourceName: "icon_Login")}
        else if str == "My Account" { cell.imageViewBG.image = #imageLiteral(resourceName: "icon_MyAccount")}
        cell.selectionStyle = .none
        return cell
    }
    
    //MARK: TABLE VIEW DELEGATE
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str : String = self.arrList[indexPath.row]
        self.hideMenuAction()
//        if str == "Home" {}
//        else if str == "Reviews" { APP_SCENE_DELEGATE.setReview() }
//        else if str == "Menu" {}
////        else if str == "My Orders" {}
//        else if str == "FAQ" { APP_SCENE_DELEGATE.setFAQ() }
//        else if str == "Contact Us" { APP_SCENE_DELEGATE.setContactUs() }
//        else if str == "Login" { APP_SCENE_DELEGATE.setLoginVC() }
//        else if str == "My Account" { APP_SCENE_DELEGATE.setMyAccount() }
    }
    
}

extension JD_SideMenu : FCAlertViewDelegate{
    func fcAlertView(_ alertView: FCAlertView!, clickedButtonIndex index: Int, buttonTitle title: String!) {
    }
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        runOnMainThread {
            GetSetModel.removeAllKeyFromDefault()
//            APP_SCENE_DELEGATE.showLogInVC()
        }
        //        intLastDeleteIndex = -1
    }
}
