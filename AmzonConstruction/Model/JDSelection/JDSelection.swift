//
//  JDSelection.swift
//  FitnessFood
//
//  Created by  YASH COMPUTERS on 08/05/20.
//  Copyright © 2020 MyOwnOrganization. All rights reserved.
//

import UIKit

class JDSelection: UIView {
    
    //MARK: PROPERTIES

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewDesciptionBG: UIView!
    @IBOutlet weak var tblViewList: UITableView!
    @IBOutlet weak var constraintTblViewListHeight: NSLayoutConstraint!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var btnInfoBG: UIButton!
    
    //MARK: VARIABLES
    var VALUE_KEY = "";
    var ID_KEY = "";
    var IS_MULTI_SELECTION = false
    var TITLE = ""
    var arrItems = [typeAliasDictionary]()
    var arrSelectedItems = [typeAliasDictionary]()
    let MAX_HEIGHT  = UIScreen.main.bounds.height * 0.85
    
    //MARK: CLOSURES
    
    var onSelection:(([typeAliasDictionary]) -> Void)?
    
    //MARK: METHODS
    
    init(title:String,arrayItems:[typeAliasDictionary],arraySelected:[typeAliasDictionary],VALUE_KEY:String,ID_KEY:String,IS_MULTI_SELECTION:Bool) {
        super.init(frame: UIScreen.main.bounds)
        self.VALUE_KEY = VALUE_KEY
        self.TITLE = title
        self.ID_KEY = ID_KEY
        self.IS_MULTI_SELECTION = IS_MULTI_SELECTION
        self.arrItems = arrayItems
        self.arrSelectedItems = arraySelected
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib() {
        
        if let view = Bundle.main.loadNibNamed("JDSelection", owner: self, options: nil)![0] as? UIView {
            view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
            view.frame  = self.bounds
            view.layoutIfNeeded()
            self.addSubview(view)
        }
        self.tblViewList.register(UINib.init(nibName: "JDSelectionCell", bundle: nil), forCellReuseIdentifier: "JDSelectionCell")
        self.tblViewList.tableFooterView = UIView.init(frame: .zero)
        self.tblViewList.separatorStyle = .none
        self.tblViewList.delegate = self
        self.tblViewList.dataSource = self
        self.tblViewList.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.tblViewList.reloadData()
        self.lblTitle.text = self.TITLE
        APP_SCENE_DELEGATE.window?.addSubview(self)
    }
    
    func isSelectedItemExist(dictItem:typeAliasDictionary) -> Int {
        
        for i in 0..<self.arrSelectedItems.count {
            let item = self.arrSelectedItems[i]
            if "\(dictItem[ID_KEY]!)" == "\(item[ID_KEY]!)" {
                return i
            }
        }
        return -1
    }
    
    func closeSelection() {
        self.tblViewList.removeObserver(self, forKeyPath: "contentSize")
        self.removeFromSuperview()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if object != nil && object! is UITableView {
                let height = self.tblViewList.contentSize.height + 135  // 135 IS HEIGHT OF OTHER ELEMETNS IN VIEW
                if height > MAX_HEIGHT {
                    self.constraintTblViewListHeight.constant = MAX_HEIGHT - 135
                }
                else {
                    self.constraintTblViewListHeight.constant = self.tblViewList.contentSize.height
                }
                self.tblViewList.layoutIfNeeded()
            }
        }
    }
    
    //MARK: BUTTON METHODS
    
    @IBAction func btnCancelAction() {
        closeSelection()
    }
    
    @IBAction func btnSelectAction() {
        closeSelection()
        if onSelection != nil {
            self.onSelection!(self.arrSelectedItems)
        }
    }
    @IBAction func btnInfoBGAction() {
        showAlertWithTitleWithMessage(message: "\(self.txtViewDescription.text!)")
    }
}


extension JDSelection:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:JDSelectionCell = tableView.dequeueReusableCell(withIdentifier: "JDSelectionCell") as! JDSelectionCell
        let item = self.arrItems[indexPath.row]
        cell.lbltitle.text = "\(item[VALUE_KEY]!)"
        let index = isSelectedItemExist(dictItem: item)
        cell.btnSelection.isSelected = false
        if index > -1 {  cell.btnSelection.isSelected = true }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.IS_MULTI_SELECTION {
            let index = self.isSelectedItemExist(dictItem: self.arrItems[indexPath.row])
            if index > -1 {
                self.arrSelectedItems.remove(at: index)
            }
            else {
                self.arrSelectedItems.append(self.arrItems[indexPath.row])
            }
        }
        else {
            self.arrSelectedItems.removeAll()
            self.arrSelectedItems.append(self.arrItems[indexPath.row])
        }
        
        self.tblViewList.reloadData()
    }
}
