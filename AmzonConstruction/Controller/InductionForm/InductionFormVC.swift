//
//  InductionFormVC.swift
//  AmzonConstruction
//
//  Created by Jashu Prajapati on 8/16/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit
import FCAlertView
import SignaturePad

class InductionFormVC: UIViewController {
    
    //MARK: PROPERTIES
    //stage 1
    @IBOutlet weak var viewStage1BG: UIView!
    @IBOutlet weak var constraintViewStage1BGHeight: NSLayoutConstraint!//515
    @IBOutlet weak var txtStage1Name: UITextField!
    @IBOutlet weak var txtStage1Company: UITextField!
    @IBOutlet weak var imageViewStage1Sign: UIImageView!
    //stage 2
    @IBOutlet weak var viewStage2BG: UIView!
    @IBOutlet weak var constraintViewStage2BGHeight: NSLayoutConstraint!//635
    @IBOutlet weak var txtStage2Name: UITextField!
    @IBOutlet weak var txtStage2Postion: UITextField!
    @IBOutlet weak var imageViewStage2Sign: UIImageView!
    @IBOutlet weak var viewStatge2NoteBG: UIView!
    @IBOutlet weak var txtViewStage2Note: UITextView!
    @IBOutlet weak var lblStage2NotePH: UILabel!
    @IBOutlet weak var btnStatge2Approve: UIButton!
    @IBOutlet weak var btnStatge2Reject: UIButton!
    
    
    //stage asbestos
    @IBOutlet weak var viewStageAsbestosBG: UIView!
    @IBOutlet weak var constraintViewStageAsbestosBGHeight: NSLayoutConstraint!//1545
    @IBOutlet var btnViewAsbestosTopCollection: [UIButton]!
    @IBOutlet weak var txtViewAsbestosComment: UITextView!
    @IBOutlet weak var lblAsbestosCommentPH: UILabel!
    @IBOutlet var btnViewAsbestosQ1Collection: [UIButton]!
    @IBOutlet var btnViewAsbestosQ2Collection: [UIButton]!
    @IBOutlet var btnViewAsbestosQ3Collection: [UIButton]!
    @IBOutlet var btnViewAsbestosQ4Collection: [UIButton]!
    //Stage 4
    @IBOutlet weak var viewStage4BG: UIView!
    @IBOutlet weak var constraintViewStage4BGHeight: NSLayoutConstraint!//565
    @IBOutlet weak var txtStage4Name: UITextField!
    @IBOutlet weak var txtStage4Company: UITextField!
    @IBOutlet weak var imageViewStage4Sign: UIImageView!
    //stage 5
    @IBOutlet weak var viewStage5BG: UIView!
    @IBOutlet weak var constraintViewStage5BGHeight: NSLayoutConstraint!//480
    @IBOutlet weak var txtStage5Name: UITextField!
    @IBOutlet weak var txtStage5Position: UITextField!
    @IBOutlet weak var imageViewStage5Sign: UIImageView!
    
    @IBOutlet weak var btnSubmitFormBG: UIButton!
    
    
    
    //MARK: VARIABLES
    internal var dictPageInfo : typeAliasDictionary = typeAliasDictionary()
    var signUrls : URL!
    var strWorkPermitId : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSubmitFormBG.setTitle("Submit", for: .normal)
        switch Int(APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String)! {
        case 2:
            //site manager
            self.viewStage1BG.isUserInteractionEnabled = false
            self.viewStage2BG.isUserInteractionEnabled = false
            self.viewStageAsbestosBG.isUserInteractionEnabled = false
            self.viewStage4BG.isUserInteractionEnabled = false
            self.viewStage5BG.isUserInteractionEnabled = false
            //s1
            let dict : typeAliasDictionary = (dictPageInfo["work_permit"] as! typeAliasDictionary)
            self.txtStage1Name.text = "\(dict["contractor_name"]!)"
            self.txtStage1Company.text = "\(dict["contractor_company"]!)"
            self.imageViewStage1Sign.sd_setImage(with: URL.init(string: (dictPageInfo["induction_permit"] as! typeAliasDictionary)["prework_signature"]as! String), completed: nil)
            
            switch (dictPageInfo["work_permit"] as! typeAliasDictionary)["status"]as! String {
            case "1":
                self.txtStage2Name.text = "\(APP_SCENE_DELEGATE.dictUserInfo["user_name"]!)"
                self.txtStage2Postion.text = "Site Manager"
                self.viewStatge2NoteBG.isHidden = true
                self.viewStage2BG.isUserInteractionEnabled = true
                self.viewStage1BG.isHidden = false
                self.viewStage2BG.isHidden = false
                self.viewStageAsbestosBG.isHidden = true
                self.viewStage4BG.isHidden = true
                self.viewStage5BG.isHidden = true
                self.constraintViewStage1BGHeight.constant = 515
                self.constraintViewStage2BGHeight.constant = 545
                self.constraintViewStageAsbestosBGHeight.constant = 0
                self.constraintViewStage4BGHeight.constant = 0
                self.constraintViewStage5BGHeight.constant = 0
                
                break
            case "2":
                //reject
                let dict : typeAliasDictionary = (dictPageInfo["induction_permit"] as! typeAliasDictionary)
                self.txtStage2Name.text = "\(dict["prework_amazon_nameprint"]!)"
                self.txtStage2Postion.text = "\(dict["prework_amazon_position"]!)"
                self.imageViewStage2Sign.sd_setImage(with: URL.init(string: dict["prework_amazon_signature"]as! String), completed: nil)
                self.txtViewStage2Note.text = "\((dictPageInfo["work_permit"] as! typeAliasDictionary)["reject_notes"]!)"
                self.lblStage2NotePH.text = ""
                self.btnStatge2Approve.isSelected = false
                self.btnStatge2Reject.isSelected = true
                
                self.viewStage1BG.isHidden = false
                self.viewStage2BG.isHidden = false
                self.viewStageAsbestosBG.isHidden = true
                self.viewStage4BG.isHidden = true
                self.viewStage5BG.isHidden = true
                self.viewStatge2NoteBG.isHidden = false
                self.constraintViewStage1BGHeight.constant = 515
                self.constraintViewStage2BGHeight.constant = 635
                self.constraintViewStageAsbestosBGHeight.constant = 0
                self.constraintViewStage4BGHeight.constant = 0
                self.constraintViewStage5BGHeight.constant = 0
                break
            case "3":
                //approve
                let dict : typeAliasDictionary = (dictPageInfo["induction_permit"] as! typeAliasDictionary)
                self.txtStage2Name.text = "\(dict["prework_amazon_nameprint"]!)"
                self.txtStage2Postion.text = "\(dict["prework_amazon_position"]!)"
                self.imageViewStage2Sign.sd_setImage(with: URL.init(string: dict["prework_amazon_signature"]as! String), completed: nil)
                
                self.txtViewStage2Note.text = ""
                self.btnStatge2Approve.isSelected = true
                self.btnStatge2Reject.isSelected = false
                
                self.viewStage1BG.isHidden = false
                self.viewStage2BG.isHidden = false
                self.viewStageAsbestosBG.isHidden = true
                self.viewStage4BG.isHidden = true
                self.viewStage5BG.isHidden = true
                self.viewStatge2NoteBG.isHidden = true
                self.constraintViewStage1BGHeight.constant = 515
                self.constraintViewStage2BGHeight.constant = 545
                self.constraintViewStageAsbestosBGHeight.constant = 0
                self.constraintViewStage4BGHeight.constant = 0
                self.constraintViewStage5BGHeight.constant = 0
                break
            case "4":
                //edit
                let dict : typeAliasDictionary = (dictPageInfo["induction_permit"] as! typeAliasDictionary)
                self.txtStage2Name.text = "\(dict["prework_amazon_nameprint"]!)"
                self.txtStage2Postion.text = "\(dict["prework_amazon_position"]!)"
                self.imageViewStage2Sign.sd_setImage(with: URL.init(string: dict["prework_amazon_signature"]as! String), completed: nil)
                
                self.txtViewStage2Note.text = "\((dictPageInfo["work_permit"] as! typeAliasDictionary)["reject_notes"]!)"
                self.lblStage2NotePH.text = ""
                self.btnStatge2Approve.isSelected = true
                self.btnStatge2Reject.isSelected = false
                
                if ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "") {
                    for btn in self.btnViewAsbestosTopCollection {
                        if btn.tag == 1{ btn.isSelected = "\(dict["asbestos_risks"]!)".isContainString("1") }
                        else if btn.tag == 2 { btn.isSelected = "\(dict["asbestos_risks"]!)".isContainString("2") }
                        else { btn.isSelected = "\(dict["asbestos_risks"]!)".isContainString("3") }
                    }
                    for btn in self.btnViewAsbestosQ1Collection {
                        btn.isSelected = "\(dict["prework_work_area"]!)".isContainString("\(btn.tag)")
                    }
                    for btn in self.btnViewAsbestosQ2Collection {
                        btn.isSelected = "\(dict["prework_waste_produced"]!)".isContainString("\(btn.tag)")
                    }
                    for btn in self.btnViewAsbestosQ3Collection {
                        btn.isSelected = "\(dict["prework_equipment_repaired"]!)".isContainString("\(btn.tag)")
                    }
                    for btn in self.btnViewAsbestosQ4Collection {
                        btn.isSelected = "\(dict["prework_document_report"]!)".isContainString("\(btn.tag)")
                    }
                    self.txtViewAsbestosComment.text = "\(dict["prework_further_comments"]!)"
                    self.lblAsbestosCommentPH.text = ""
                }
                
                self.txtStage4Name.text = "\(dict["afterwork_nameprint"]!)"
                self.txtStage4Company.text = "\(dict["afterwork_company"]!)"
                self.imageViewStage4Sign.sd_setImage(with: URL.init(string: dict["afterwork_signature"]as! String), completed: nil)
                
                self.txtStage5Name.text = "\(APP_SCENE_DELEGATE.dictUserInfo["user_name"]!)"
                self.txtStage5Position.text = "Site Manager"
                
                self.viewStage5BG.isUserInteractionEnabled = true
                self.viewStage1BG.isHidden = false
                self.viewStage2BG.isHidden = false
                self.viewStageAsbestosBG.isHidden = ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "" ? false : true)
                self.viewStage4BG.isHidden = false
                self.viewStage5BG.isHidden = false
                self.viewStatge2NoteBG.isHidden = true
                self.constraintViewStage1BGHeight.constant = 515
                self.constraintViewStage2BGHeight.constant = 545
                self.constraintViewStageAsbestosBGHeight.constant = ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "" ? 1545 : 0)
                self.constraintViewStage4BGHeight.constant = 565
                self.constraintViewStage5BGHeight.constant = 480
                break
            case "5":
                //show
                let dict : typeAliasDictionary = (dictPageInfo["induction_permit"] as! typeAliasDictionary)
                self.txtStage2Name.text = "\(dict["prework_amazon_nameprint"]!)"
                self.txtStage2Postion.text = "\(dict["prework_amazon_position"]!)"
                self.imageViewStage2Sign.sd_setImage(with: URL.init(string: dict["prework_amazon_signature"]as! String), completed: nil)
                
                self.txtViewStage2Note.text = "\((dictPageInfo["work_permit"] as! typeAliasDictionary)["reject_notes"]!)"
                self.lblStage2NotePH.text = ""
                self.btnStatge2Approve.isSelected = true
                self.btnStatge2Reject.isSelected = false
                
                if ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "") {
                    for btn in self.btnViewAsbestosTopCollection {
                        if btn.tag == 1{ btn.isSelected = "\(dict["asbestos_risks"]!)".isContainString("1") }
                        else if btn.tag == 2 { btn.isSelected = "\(dict["asbestos_risks"]!)".isContainString("2") }
                        else { btn.isSelected = "\(dict["asbestos_risks"]!)".isContainString("3") }
                    }
                    for btn in self.btnViewAsbestosQ1Collection {
                        btn.isSelected = "\(dict["prework_work_area"]!)".isContainString("\(btn.tag)")
                    }
                    for btn in self.btnViewAsbestosQ2Collection {
                        btn.isSelected = "\(dict["prework_waste_produced"]!)".isContainString("\(btn.tag)")
                    }
                    for btn in self.btnViewAsbestosQ3Collection {
                        btn.isSelected = "\(dict["prework_equipment_repaired"]!)".isContainString("\(btn.tag)")
                    }
                    for btn in self.btnViewAsbestosQ4Collection {
                        btn.isSelected = "\(dict["prework_document_report"]!)".isContainString("\(btn.tag)")
                    }
                    self.txtViewAsbestosComment.text = "\(dict["prework_further_comments"]!)"
                    self.lblAsbestosCommentPH.text = ""
                }
                
                self.txtStage4Name.text = "\(dict["afterwork_nameprint"]!)"
                self.txtStage4Company.text = "\(dict["afterwork_company"]!)"
                self.imageViewStage4Sign.sd_setImage(with: URL.init(string: dict["afterwork_signature"]as! String), completed: nil)
                
                self.txtStage5Name.text = "\(dict["afterwork_amazon_nameprint"]!)"
                self.txtStage5Position.text = "\(dict["afterwork_amazon_position"]!)"
                self.imageViewStage5Sign.sd_setImage(with: URL.init(string: dict["afterwork_amazon_signature"]as! String), completed: nil)
                
                self.viewStage1BG.isHidden = false
                self.viewStage2BG.isHidden = false
                self.viewStageAsbestosBG.isHidden = ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "" ? false : true)
                self.viewStage4BG.isHidden = false
                self.viewStage5BG.isHidden = false
                self.viewStatge2NoteBG.isHidden = true
                self.constraintViewStage1BGHeight.constant = 515
                self.constraintViewStage2BGHeight.constant = 545
                self.constraintViewStageAsbestosBGHeight.constant = ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "" ? 1545 : 0)
                self.constraintViewStage4BGHeight.constant = 565
                self.constraintViewStage5BGHeight.constant = 480
                break
            default:
                break
            }
            break
        case 3:
            //contractor
            if dictPageInfo.isEmpty {
                //from back form
                self.viewStage1BG.isUserInteractionEnabled = true
                self.txtStage1Name.text = "\(APP_SCENE_DELEGATE.dictUserInfo["user_name"]!)"
                self.txtStage1Company.text = "\(APP_SCENE_DELEGATE.dictUserInfo["contractor_company"]!)"
                self.viewStage1BG.isHidden = false
                self.viewStage2BG.isHidden = true
                self.viewStageAsbestosBG.isHidden = true
                self.viewStage4BG.isHidden = true
                self.viewStage5BG.isHidden = true
                self.viewStatge2NoteBG.isHidden = true
                self.constraintViewStage1BGHeight.constant = 515
                self.constraintViewStage2BGHeight.constant = 0
                self.constraintViewStageAsbestosBGHeight.constant = 0
                self.constraintViewStage4BGHeight.constant = 0
                self.constraintViewStage5BGHeight.constant = 0
            }
            else {
            self.viewStage1BG.isUserInteractionEnabled = false
            self.viewStage2BG.isUserInteractionEnabled = false
            self.viewStageAsbestosBG.isUserInteractionEnabled = false
            self.viewStage4BG.isUserInteractionEnabled = false
            self.viewStage5BG.isUserInteractionEnabled = false
            //s1
            let dict : typeAliasDictionary = (dictPageInfo["work_permit"] as! typeAliasDictionary)
            self.txtStage1Name.text = "\(dict["contractor_name"]!)"
            self.txtStage1Company.text = "\(dict["contractor_company"]!)"
            self.imageViewStage1Sign.sd_setImage(with: URL.init(string: (dictPageInfo["induction_permit"] as! typeAliasDictionary)["prework_signature"]as! String), completed: nil)
            switch (dictPageInfo["work_permit"] as! typeAliasDictionary)["status"]as! String
            {
            case "1":
                self.viewStage1BG.isHidden = false
                self.viewStage2BG.isHidden = true
                self.viewStageAsbestosBG.isHidden = true
                self.viewStage4BG.isHidden = true
                self.viewStage5BG.isHidden = true
                self.viewStatge2NoteBG.isHidden = true
                self.constraintViewStage1BGHeight.constant = 515
                self.constraintViewStage2BGHeight.constant = 0
                self.constraintViewStageAsbestosBGHeight.constant = 0
                self.constraintViewStage4BGHeight.constant = 0
                self.constraintViewStage5BGHeight.constant = 0
                break
            case "2":
                //reject
                let dict : typeAliasDictionary = (dictPageInfo["induction_permit"] as! typeAliasDictionary)
                self.txtStage2Name.text = "\(dict["prework_amazon_nameprint"]!)"
                self.txtStage2Postion.text = "\(dict["prework_amazon_position"]!)"
                self.imageViewStage2Sign.sd_setImage(with: URL.init(string: dict["prework_amazon_signature"]as! String), completed: nil)
                self.txtViewStage2Note.text = "\((dictPageInfo["work_permit"] as! typeAliasDictionary)["reject_notes"]!)"
                self.lblStage2NotePH.text = ""
                self.btnStatge2Approve.isSelected = false
                self.btnStatge2Reject.isSelected = true
                
                self.btnSubmitFormBG.setTitle("ReSubmit", for: .normal)
                self.viewStage1BG.isHidden = false
                self.viewStage2BG.isHidden = false
                self.viewStageAsbestosBG.isHidden = true
                self.viewStage4BG.isHidden = true
                self.viewStage5BG.isHidden = true
                self.viewStatge2NoteBG.isHidden = false
                self.constraintViewStage1BGHeight.constant = 515
                self.constraintViewStage2BGHeight.constant = 635
                self.constraintViewStageAsbestosBGHeight.constant = 0
                self.constraintViewStage4BGHeight.constant = 0
                self.constraintViewStage5BGHeight.constant = 0
                break
            case "3":
                //approve
                let dict : typeAliasDictionary = (dictPageInfo["induction_permit"] as! typeAliasDictionary)
                self.txtStage2Name.text = "\(dict["prework_amazon_nameprint"]!)"
                self.txtStage2Postion.text = "\(dict["prework_amazon_position"]!)"
                self.imageViewStage2Sign.sd_setImage(with: URL.init(string: dict["prework_amazon_signature"]as! String), completed: nil)
                self.txtViewStage2Note.text = ""
                self.btnStatge2Approve.isSelected = true
                self.btnStatge2Reject.isSelected = false
                
                self.txtStage4Name.text = "\(APP_SCENE_DELEGATE.dictUserInfo["user_name"]!)"
                self.txtStage4Company.text = "\(APP_SCENE_DELEGATE.dictUserInfo["contractor_company"]!)"
                
                self.viewStageAsbestosBG.isUserInteractionEnabled = ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "")
                self.viewStage4BG.isUserInteractionEnabled = true
                self.viewStage1BG.isHidden = false
                self.viewStage2BG.isHidden = false
                self.viewStageAsbestosBG.isHidden = ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String == "")
                self.viewStage4BG.isHidden = false
                self.viewStage5BG.isHidden = true
                self.viewStatge2NoteBG.isHidden = true
                self.constraintViewStage1BGHeight.constant = 515
                self.constraintViewStage2BGHeight.constant = 545
                self.constraintViewStageAsbestosBGHeight.constant = ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "" ? 1545 : 0)
                self.constraintViewStage4BGHeight.constant = 565
                self.constraintViewStage5BGHeight.constant = 0
                break
            case "4":
                //show
                let dict : typeAliasDictionary = (dictPageInfo["induction_permit"] as! typeAliasDictionary)
                self.txtStage2Name.text = "\(dict["prework_amazon_nameprint"]!)"
                self.txtStage2Postion.text = "\(dict["prework_amazon_position"]!)"
                self.imageViewStage2Sign.sd_setImage(with: URL.init(string: dict["prework_amazon_signature"]as! String), completed: nil)
                
                self.txtViewStage2Note.text = "\((dictPageInfo["work_permit"] as! typeAliasDictionary)["reject_notes"]!)"
                self.lblStage2NotePH.text = ""
                self.btnStatge2Approve.isSelected = true
                self.btnStatge2Reject.isSelected = false
                
                if ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "") {
                    for btn in self.btnViewAsbestosTopCollection {
                        if btn.tag == 1{ btn.isSelected = "\(dict["asbestos_risks"]!)".isContainString("1") }
                        else if btn.tag == 2 { btn.isSelected = "\(dict["asbestos_risks"]!)".isContainString("2") }
                        else { btn.isSelected = "\(dict["asbestos_risks"]!)".isContainString("3") }
                    }
                    for btn in self.btnViewAsbestosQ1Collection {
                        btn.isSelected = "\(dict["prework_work_area"]!)".isContainString("\(btn.tag)")
                    }
                    for btn in self.btnViewAsbestosQ2Collection {
                        btn.isSelected = "\(dict["prework_waste_produced"]!)".isContainString("\(btn.tag)")
                    }
                    for btn in self.btnViewAsbestosQ3Collection {
                        btn.isSelected = "\(dict["prework_equipment_repaired"]!)".isContainString("\(btn.tag)")
                    }
                    for btn in self.btnViewAsbestosQ4Collection {
                        btn.isSelected = "\(dict["prework_document_report"]!)".isContainString("\(btn.tag)")
                    }
                    self.txtViewAsbestosComment.text = "\(dict["prework_further_comments"]!)"
                    self.lblAsbestosCommentPH.text = ""
                }
                
                self.txtStage4Name.text = "\(dict["afterwork_nameprint"]!)"
                self.txtStage4Company.text = "\(dict["afterwork_company"]!)"
                self.imageViewStage4Sign.sd_setImage(with: URL.init(string: dict["afterwork_signature"]as! String), completed: nil)
                
                self.viewStage1BG.isHidden = false
                self.viewStage2BG.isHidden = false
                self.viewStageAsbestosBG.isHidden = ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "" ? false : true)
                self.viewStage4BG.isHidden = false
                self.viewStage5BG.isHidden = true
                self.viewStatge2NoteBG.isHidden = true
                self.constraintViewStage1BGHeight.constant = 515
                self.constraintViewStage2BGHeight.constant = 545
                self.constraintViewStageAsbestosBGHeight.constant = ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "" ? 1545 : 0)
                self.constraintViewStage4BGHeight.constant = 565
                self.constraintViewStage5BGHeight.constant = 0
                break
            case "5":
                let dict : typeAliasDictionary = (dictPageInfo["induction_permit"] as! typeAliasDictionary)
                self.txtStage2Name.text = "\(dict["prework_amazon_nameprint"]!)"
                self.txtStage2Postion.text = "\(dict["prework_amazon_position"]!)"
                self.imageViewStage2Sign.sd_setImage(with: URL.init(string: dict["prework_amazon_signature"]as! String), completed: nil)
                
                self.txtViewStage2Note.text = "\((dictPageInfo["work_permit"] as! typeAliasDictionary)["reject_notes"]!)"
                self.lblStage2NotePH.text = ""
                self.btnStatge2Approve.isSelected = true
                self.btnStatge2Reject.isSelected = false
                
                if ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "") {
                    for btn in self.btnViewAsbestosTopCollection {
                        if btn.tag == 1{ btn.isSelected = "\(dict["asbestos_risks"]!)".isContainString("1") }
                        else if btn.tag == 2 { btn.isSelected = "\(dict["asbestos_risks"]!)".isContainString("2") }
                        else { btn.isSelected = "\(dict["asbestos_risks"]!)".isContainString("3") }
                    }
                    for btn in self.btnViewAsbestosQ1Collection {
                        btn.isSelected = "\(dict["prework_work_area"]!)".isContainString("\(btn.tag)")
                    }
                    for btn in self.btnViewAsbestosQ2Collection {
                        btn.isSelected = "\(dict["prework_waste_produced"]!)".isContainString("\(btn.tag)")
                    }
                    for btn in self.btnViewAsbestosQ3Collection {
                        btn.isSelected = "\(dict["prework_equipment_repaired"]!)".isContainString("\(btn.tag)")
                    }
                    for btn in self.btnViewAsbestosQ4Collection {
                        btn.isSelected = "\(dict["prework_document_report"]!)".isContainString("\(btn.tag)")
                    }
                    self.txtViewAsbestosComment.text = "\(dict["prework_further_comments"]!)"
                    self.lblAsbestosCommentPH.text = ""
                }
                
                self.txtStage4Name.text = "\(dict["afterwork_nameprint"]!)"
                self.txtStage4Company.text = "\(dict["afterwork_company"]!)"
                self.imageViewStage4Sign.sd_setImage(with: URL.init(string: dict["afterwork_signature"]as! String), completed: nil)
                
                self.txtStage5Name.text = "\(dict["afterwork_amazon_nameprint"]!)"
                self.txtStage5Position.text = "\(dict["afterwork_amazon_position"]!)"
                self.imageViewStage5Sign.sd_setImage(with: URL.init(string: dict["afterwork_amazon_signature"]as! String), completed: nil)
                
                self.viewStage1BG.isHidden = false
                self.viewStage2BG.isHidden = false
                self.viewStageAsbestosBG.isHidden = ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "" ? false : true)
                self.viewStage4BG.isHidden = false
                self.viewStage5BG.isHidden = false
                self.viewStatge2NoteBG.isHidden = false
                self.constraintViewStage1BGHeight.constant = 515
                self.constraintViewStage2BGHeight.constant = 545
                self.constraintViewStageAsbestosBGHeight.constant = ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "" ? 1545 : 0)
                self.constraintViewStage4BGHeight.constant = 565
                self.constraintViewStage5BGHeight.constant = 480
                break
            default:
                break
            }
            }
            break
        case 4:
            //Region manager
            break
        case 5:
            //Admin
            break
        default:break
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle { return UIStatusBarStyle.lightContent }
    
    //MARK: CUSTOM METHOD
    fileprivate func setNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        APP_SCENE_DELEGATE.navigationController.setCustomTitleWithImage(#imageLiteral(resourceName: "image_Amazon"))
        APP_SCENE_DELEGATE.navigationController.navigationDelegate = self
        APP_SCENE_DELEGATE.navigationController.setRightTitleMenu("Logout")
        APP_SCENE_DELEGATE.navigationController.setBack()
        
    }
    
    //MARK: UIBUTTON ACTION
    @IBAction func btnStage1SignAction() {
        let vc = SignaturePadVC.init(nibName: "SignaturePadVC", bundle: nil)
        vc.delegate = self
        vc.intType = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func brnStage2SignAction() {
        let vc = SignaturePadVC.init(nibName: "SignaturePadVC", bundle: nil)
        vc.delegate = self
        vc.intType = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnStage2AproveRejectAction(_ sender: UIButton) {
        if sender.tag == 1 {
            //approve
            self.btnStatge2Approve.isSelected = true
            self.btnStatge2Reject.isSelected = false
            self.viewStatge2NoteBG.isHidden = true
            self.constraintViewStage2BGHeight.constant = 535
        }
        else {
            //reject
            self.btnStatge2Approve.isSelected = false
            self.btnStatge2Reject.isSelected = true
            self.viewStatge2NoteBG.isHidden = false
            self.constraintViewStage2BGHeight.constant = 635
        }
        UIView.animate(withDuration: 0.3) { self.view.layoutIfNeeded() }
    }
    @IBAction func btnStageAsbestosTopAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func btnViewAsbestosQ1Action(_ sender: UIButton) {
        for btn in self.btnViewAsbestosQ1Collection {
            btn.isSelected = btn.tag == sender.tag
        }
    }
    @IBAction func btnViewAsbestosQ2Action(_ sender: UIButton) {
        for btn in self.btnViewAsbestosQ2Collection {
            btn.isSelected = btn.tag == sender.tag
        }
    }
    @IBAction func btnViewAsbestosQ3Action(_ sender: UIButton) {
        for btn in self.btnViewAsbestosQ3Collection {
            btn.isSelected = btn.tag == sender.tag
        }
    }
    @IBAction func btnViewAsbestosQ4Action(_ sender: UIButton) {
        for btn in self.btnViewAsbestosQ4Collection {
            btn.isSelected = btn.tag == sender.tag
        }
    }
    @IBAction func btnStage4SignAction() {
        let vc = SignaturePadVC.init(nibName: "SignaturePadVC", bundle: nil)
        vc.delegate = self
        vc.intType = 4
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnStage5SignAction() {
        let vc = SignaturePadVC.init(nibName: "SignaturePadVC", bundle: nil)
        vc.delegate = self
        vc.intType = 5
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnBackToMainAction() {
        self.appNavigationController_BackAction()
    }
    @IBAction func btnSubmitFormAction(_ sender: UIButton) {
        if (dictPageInfo["work_permit"] as! typeAliasDictionary)["status"]as! String == "2" {
            //resubmit
        }
        else {
            if APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String == "2" {
                //site manager
                if (dictPageInfo["work_permit"] as!
                    typeAliasDictionary)["status"]as! String == "1"{
                    //s1
                    self.callUpdateFormDetail(isContractor: false, forStage: 23)
                }
                else if (dictPageInfo["work_permit"] as!
                    typeAliasDictionary)["status"]as! String == "4"{
                    //s5
                    self.callUpdateFormDetail(isContractor: false, forStage: 5)
                }
            }
            else if APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String == "3" {
                //contractor
                if self.dictPageInfo.isEmpty {
                    //first
                    
                }
                else {
                    if (dictPageInfo["work_permit"] as!
                        typeAliasDictionary)["status"]as! String == "3"{
                        //approve
                        self.callUpdateFormDetail(isContractor: true, forStage: 4)
                    }
                }
            }
        }
        
    }
}
extension InductionFormVC : AppNavigationControllerDelegate {
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

extension InductionFormVC : FCAlertViewDelegate {
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        if alertView.accessibilityValue == "LOGOUT" {
            GetSetModel.removeObjectForKey(objectKey: UD_KEY_APPUSER_INFO)
            APP_SCENE_DELEGATE.setLoginVC()
        }
    }
    func fcAlertView(_ alertView: FCAlertView!, clickedButtonIndex index: Int, buttonTitle title: String!) {
        
    }
}
extension InductionFormVC {
    func callFirstTimeAPIForContractor() {
        if isConnectedToNetwork() {
            if self.imageViewStage1Sign.image == UIImage() || self.imageViewStage1Sign.image == nil {
                showAlertWithTitleWithMessage(message: MSG_TXT_FILL_ALL)
                return
            }
            var param : typeAliasDictionary = typeAliasDictionary()
            param["work_permit_id"] = strWorkPermitId as AnyObject
            param["prework_nameprint"] = "\(APP_SCENE_DELEGATE.dictUserInfo["user_name"]!)" as AnyObject
            param["prework_company"] = "\(APP_SCENE_DELEGATE.dictUserInfo["contractor_company"]!)" as AnyObject
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.createInductionForm(param: param, imageTagName: "prework_signature_img", fileSign: self.imageViewStage1Sign.image!, response: {(dictResponse,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if rstatus == 1 {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                else {
                    showAlertWithTitleWithMessage(message: SOMETHING_WRONG)
                }
            })
        } else {
            showNoInternetAlert()
        }
    }
    
    func callUpdateFormDetail(isContractor : Bool,forStage : Int) {
        if isConnectedToNetwork() {
            var param : typeAliasDictionary = typeAliasDictionary()
            var imgTagName : String = ""
            var imgSIgnBG : UIImage = UIImage()
            if isContractor {
                if ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "") {
                    var isFilled : Bool = true
                    for btn in self.btnViewAsbestosTopCollection {
                        if !btn.isSelected { isFilled = false ; break }
                    }
                    if !isFilled {
                        showAlertWithTitleWithMessage(message: MSG_TXT_FILL_ALL)
                        return
                    }
                    isFilled = false
                    for btn in self.btnViewAsbestosQ1Collection {
                        if btn.isSelected { isFilled = true ; break }
                    }
                    if !isFilled {
                        showAlertWithTitleWithMessage(message: MSG_TXT_FILL_ALL)
                        return
                    }
                    isFilled = false
                    for btn in self.btnViewAsbestosQ2Collection {
                        if btn.isSelected { isFilled = true ; break }
                    }
                    if !isFilled {
                        showAlertWithTitleWithMessage(message: MSG_TXT_FILL_ALL)
                        return
                    }
                    isFilled = false
                    for btn in self.btnViewAsbestosQ3Collection {
                        if btn.isSelected { isFilled = true ; break }
                    }
                    if !isFilled {
                        showAlertWithTitleWithMessage(message: MSG_TXT_FILL_ALL)
                        return
                    }
                    isFilled = false
                    for btn in self.btnViewAsbestosQ4Collection {
                        if btn.isSelected { isFilled = true ; break }
                    }
                    if !isFilled {
                        showAlertWithTitleWithMessage(message: MSG_TXT_FILL_ALL)
                        return
                    }
                    if self.txtViewAsbestosComment.text.trim() == "" {
                        showAlertWithTitleWithMessage(message: MSG_TXT_FILL_ALL)
                        return
                    }
                }
                if self.imageViewStage4Sign.image == UIImage() || self.imageViewStage4Sign.image == nil {
                    showAlertWithTitleWithMessage(message: MSG_TXT_FILL_ALL)
                    return
                }
                param["work_permit_id"] = "\((dictPageInfo["work_permit"] as! typeAliasDictionary)["work_permit_id"]!)" as AnyObject
                param["status"] = "4" as AnyObject
                param["user_id"] = APP_SCENE_DELEGATE.dictUserInfo["user_id"] as AnyObject
                if ((dictPageInfo["asbestos_permit"] as! typeAliasDictionary)["permit_valid_date"]as! String != "") {
                    
                    param["asbestos_risks"] = "1,2,3" as AnyObject
//                    param["asbestos_comments"] = "" as AnyObject
                    param["prework_further_comments"] = self.txtViewAsbestosComment.text.trim() as AnyObject
                    for btn in self.btnViewAsbestosQ1Collection {
                        if btn.tag == 1 {
                            param["prework_work_area"] = (btn.isSelected ? "1" : "2") as AnyObject
                        }
                    }
                    for btn in self.btnViewAsbestosQ2Collection {
                        if btn.tag == 1 {
                            param["prework_waste_produced"] = (btn.isSelected ? "1" : "2") as AnyObject
                        }
                    }
                    for btn in self.btnViewAsbestosQ3Collection {
                        if btn.tag == 1 {
                            param["prework_equipment_repaired"] = (btn.isSelected ? "1" : "2") as AnyObject
                        }
                    }
                    for btn in self.btnViewAsbestosQ4Collection {
                        if btn.tag == 1 {
                            param["prework_document_report"] = (btn.isSelected ? "1" : "2") as AnyObject
                        }
                    }
                }
                else {
                    param["asbestos_risks"] = "" as AnyObject
//                    param["asbestos_comments"] = "" as AnyObject
                    param["prework_further_comments"] = "" as AnyObject
                    param["prework_work_area"] = "" as AnyObject
                    param["prework_waste_produced"] = "" as AnyObject
                    param["prework_equipment_repaired"] = "" as AnyObject
                    param["prework_document_report"] = "" as AnyObject
                }
                
                param["afterwork_nameprint"] = "\(APP_SCENE_DELEGATE.dictUserInfo["user_name"]!)" as AnyObject
                param["afterwork_company"] = "\(APP_SCENE_DELEGATE.dictUserInfo["contractor_company"]!)" as AnyObject
                imgTagName = "afterwork_signature"
                imgSIgnBG = self.imageViewStage4Sign.image!
            }
            else {
                if forStage == 23 {
                    if self.imageViewStage2Sign.image == UIImage() || self.imageViewStage2Sign.image == nil {
                        showAlertWithTitleWithMessage(message: MSG_TXT_FILL_ALL)
                        return
                    }
                    if !self.btnStatge2Approve.isSelected {
                        if self.txtViewStage2Note.text.trim() == "" {
                            showAlertWithTitleWithMessage(message: MSG_TXT_FILL_ALL)
                            return
                        }
                    }
                    
                    param["prework_amazon_nameprint"] = "\(APP_SCENE_DELEGATE.dictUserInfo["user_name"]!)" as AnyObject
                    param["prework_amazon_position"] = "Site Manager" as AnyObject
                    param["work_permit_id"] = "\((dictPageInfo["work_permit"] as! typeAliasDictionary)["work_permit_id"]!)" as AnyObject
                    param["status"] = "\(self.btnStatge2Approve.isSelected ? "3" : "2")" as AnyObject
                    param["user_id"] = APP_SCENE_DELEGATE.dictUserInfo["user_id"] as AnyObject
                    param["reject_notes"] = "\(self.btnStatge2Approve.isSelected ? "" : "\(self.txtViewStage2Note.text.trim())")" as AnyObject
                    imgTagName = "prework_amazon_signature"
                    imgSIgnBG = self.imageViewStage2Sign.image!
                }
                else if forStage == 5 {
                    if self.imageViewStage5Sign.image == UIImage() || self.imageViewStage5Sign.image == nil {
                        showAlertWithTitleWithMessage(message: MSG_TXT_FILL_ALL)
                        return
                    }
                    param["afterwork_amazon_nameprint"] = "\(APP_SCENE_DELEGATE.dictUserInfo["user_name"]!)" as AnyObject
                    param["afterwork_amazon_position"] = "Site Manager" as AnyObject
                    param["work_permit_id"] = "\((dictPageInfo["work_permit"] as! typeAliasDictionary)["work_permit_id"]!)" as AnyObject
                    param["status"] = "5" as AnyObject
                    param["user_id"] = APP_SCENE_DELEGATE.dictUserInfo["user_id"] as AnyObject
                    imgTagName = "afterwork_amazon_signature"
                    imgSIgnBG = self.imageViewStage5Sign.image!
                }
            }
            
            APP_SCENE_DELEGATE.showAppLoader()
            ServiceCollection.sharedInstance.updateFormDetail(param: param, imageTagName: imgTagName, fileSign: imgSIgnBG, response: {(dictResponse,rstatus,message) in
                APP_SCENE_DELEGATE.removeAppLoader()
                if rstatus == 1 {
                    self.appNavigationController_BackAction()
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
extension InductionFormVC : delegateSignPad {
    func getImageFromSignPad(imgSign: UIImage, signPad: SignaturePad) {
        if signPad.isSigned {
            if signPad.accessibilityValue == "1" {
                self.imageViewStage1Sign.image = imgSign
            }
            else if signPad.accessibilityValue == "2" {
                self.imageViewStage2Sign.image = imgSign
            }
            else if signPad.accessibilityValue == "4" {
                self.imageViewStage4Sign.image = imgSign
            }
            else if signPad.accessibilityValue == "5" {
                self.imageViewStage5Sign.image = imgSign
            }
        }
    }
    
}

extension InductionFormVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == self.txtViewAsbestosComment {
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            lblAsbestosCommentPH.isHidden = newText.count == 0 ? false : true
        }
        if textView == self.txtViewStage2Note {
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            lblStage2NotePH.isHidden = newText.count == 0 ? false : true
        }
        return true
    }
    
}
