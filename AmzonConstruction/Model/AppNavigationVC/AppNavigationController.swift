//
//  AppNavigationControllerViewController.swift
//  VastuGhee
//
//  Created by pcmac on 21/03/18.
//  Copyright © 2018 BrainWaves. All rights reserved.
//

import UIKit

@objc protocol AppNavigationControllerDelegate {
    @objc optional func appNavigationController_RightMenuAction()
    @objc optional func appNavigationController_BackAction()
    @objc optional func appNavigationController_SideMenuAction()
    
}

class AppNavigationController: UINavigationController {
    
    //MARK: PROPERTIES
    var navigationDelegate: AppNavigationControllerDelegate! = nil
    var lblTitle: UILabel!
    var imageTitle: UIImageView!
    var lblTitleLandscape: UILabel!
    var lblSubTitle: UILabel!
    var btnListGrid: UIButton! = nil
    var btnMore: UIButton!
    var btnRightMenu: UIButton!
    var viewSubTitleViewPotrait: UIView!

    //MARK: VARIABLE
    var frameTitleView = CGRect.zero
    var btnWidth = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = COLOR_BLACK
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = COLOR_WHITE
        self.navigationBar.setValue(true, forKey: "hidesShadow")
        let dict = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22),
                    NSAttributedString.Key.foregroundColor :UIColor.black]
        self.navigationBar.titleTextAttributes = dict
        
        btnWidth = 30;
        frameTitleView = CGRect(x: btnWidth, y: 0, width: self.navigationBar.frame.width - (btnWidth * 3) - 10, height: self.navigationBar.frame.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var shouldAutorotate: Bool {
        return self.viewControllers.last!.shouldAutorotate
    }
    
    internal func setCustomTitle(_ title: String) {
        let viewController: UIViewController = self.viewControllers.last!
        self.lblTitle = UILabel(frame: frameTitleView)
        self.lblTitle.textColor = UIColor.white
        self.lblTitle.text = title
        self.lblTitle.font = UIFont(name: FONT_POPPINS_SEMIBOLD, size: 17)
        self.lblTitle.textAlignment = .center
        self.lblTitle.numberOfLines = 0
        viewController.navigationItem.titleView = self.lblTitle
    }
    
    internal func setSubTitlePotrait(_ mainTitle: String, subTitle: String) {
        let fontSize: CGFloat = 40
        let viewController = self.viewControllers.last!
        //self.viewSubTitleViewPotrait.removeFromSuperview()
        
        //Title View
        self.viewSubTitleViewPotrait = UIView(frame: frameTitleView)
        
        //Main
        self.lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: frameTitleView.width - 8 , height: 20))
        self.lblTitle.textColor = UIColor.white
        self.lblTitle.text = mainTitle
//        self.lblTitle.font = UIFont(name: FONT_RALEWAY_REGULER, size: fontSize)
        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 10.0)
        self.lblTitle.textAlignment = .center
        self.lblTitle.numberOfLines = 0
        self.viewSubTitleViewPotrait.addSubview(self.lblTitle)
        
        //Record Label
        self.lblSubTitle = UILabel(frame: CGRect(x: 0, y: self.lblTitle.frame.maxY, width: frameTitleView.width, height: 20))
        self.lblSubTitle.textColor = UIColor.white
        self.lblSubTitle.text = subTitle
        self.lblSubTitle.textAlignment = .center
        self.lblSubTitle.font = UIFont(name: "", size: fontSize - 10)
        self.lblSubTitle.backgroundColor = UIColor.clear
        self.viewSubTitleViewPotrait.addSubview(self.lblSubTitle)
        viewController.navigationItem.titleView = self.viewSubTitleViewPotrait
    }
    
    internal func setBack() {
        let viewController = self.viewControllers.last!
        let btnBack = self.createImageButton("icon_back")
        btnBack.showsTouchWhenHighlighted = false
        btnBack.imageEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        btnBack.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnBack)
    }
    
    internal func setSideMenu() {
        let viewController = self.viewControllers.last!
        let btnSideMenu = self.createImageButton("icon_Menu")
        btnSideMenu.tintColor = COLOUR_DARK_RED
        btnSideMenu.showsTouchWhenHighlighted = false
        btnSideMenu.addTarget(self, action: #selector(self.btnSideMenuAction), for: .touchUpInside)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnSideMenu)
    }
    
    internal func setRightButton(cartItem: Int) {
        let viewController: UIViewController = self.viewControllers.last!
        btnRightMenu = self.createImageButton("icon_add_to_cart")
        btnRightMenu.tintColor = COLOUR_DARK_RED
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let lbl = UILabel(frame: CGRect(x: view.frame.width - 10, y: -5, width: 20, height: 20))
        lbl.text = "\(cartItem)"
        lbl.cornerRadius = 10
        lbl.clipsToBounds = true
        lbl.textAlignment = .center
        lbl.textColor = COLOUR_RED
        lbl.font = UIFont(name: FONT_POPPINS_SEMIBOLD, size: 14)
        lbl.backgroundColor = .white
        view.addSubview(btnRightMenu)
        view.addSubview(lbl)
        btnRightMenu.addTarget(self, action: #selector(btnRightMenuAction), for: .touchUpInside)
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: view)
    }
    internal func setCustomTitleWithImage(_ img: UIImage) {
        let viewBar = UIView(frame: frameTitleView)
        let viewController: UIViewController = self.viewControllers.last!
        let imagePic = UIImageView(image:img)
        imagePic.frame = CGRect(x: btnWidth - 15, y: viewBar.frame.minY, width: viewBar.frame.width - btnWidth, height: viewBar.frame.height)
        imagePic.contentMode = UIView.ContentMode.left
        imagePic.clipsToBounds = true
        DesignModel.setViewBorder(imagePic, borderColor: .clear, borderWidth: 0, isShadow: false, cornerRadius: 0, backColor: .clear)
        viewBar.addSubview(imagePic)
        viewController.navigationItem.titleView = viewBar
    }
    internal func setSideMenuWithBack() {
        let viewController: UIViewController = self.viewControllers.last!
        let leftNavView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let btnBack: UIButton = DesignModel.createImageButton(CGRect(x: 0, y: 0, width: 30, height: 30), image: #imageLiteral(resourceName: "icon_Back"), tag: 0)
        btnBack.layer.borderWidth = 1
        btnBack.addTarget(self, action: #selector(btnBackAction), for: UIControl.Event.touchUpInside)
        leftNavView.addSubview(btnBack)
        
        let btnSideMenu: UIButton = DesignModel.createImageButton(CGRect(x: btnBack.frame.maxX + 5, y: 0, width: 30, height: 30), image: #imageLiteral(resourceName: "icon_check_box"), tag: 0)
        btnSideMenu.layer.borderWidth = 1
        btnSideMenu.addTarget(self, action: #selector(btnSideMenuAction), for: UIControl.Event.touchUpInside)
        leftNavView.addSubview(btnSideMenu)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftNavView)
    }
    
    internal func setRightView(view: UIView) {
        let viewController: UIViewController = self.viewControllers.last!
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: view)
    }
    
    internal func setLeftBack() {
        let viewController = self.viewControllers.last!
        let btnBack = self.createImageButton("icon_Back")
        btnBack.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnBack)
    }
    
    internal func createImageButton(_ imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(imageName == "icon_add_to_cart" ? UIImage.init(systemName: "cart") : UIImage(named: imageName)!, for: .normal)
        button.setTitleColor(COLOR_WHITE, for: .normal)
        return button
    }
    internal func createTitalButtonRight(_ imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 360, y: 52, width: 30, height: 30)
        button.setTitle(imageName, for: .normal)
        button.setTitleColor(COLOR_WHITE, for: .normal)
        button.showsTouchWhenHighlighted = false
        return button
    }
    @objc internal func btnBackAction() {
        self.navigationDelegate.appNavigationController_BackAction!()
    }
    
    @objc internal func btnSideMenuAction() {
        self.navigationDelegate.appNavigationController_SideMenuAction!()
    }
    
    @objc internal func btnRightMenuAction() {
        self.navigationDelegate.appNavigationController_RightMenuAction!()
    }
    
}
