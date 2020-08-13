//
//  DesignModel.swift
//  CalcVault
//
//  Created by Setblue on 20/07/18.
//  Copyright © 2018 Setblue. All rights reserved.
//

import UIKit

let FRAME_SCREEN                            = UIScreen.main.bounds

typealias typeAliasDictionary               = [String: AnyObject]
typealias typeAliasStringDictionary         = [String: String]

//MARK: - APP GENERALS
public let APP_THEME_COLOR = COLOR_CUSTOM(248, 150, 34, 1.0)

//MARK: - Color functions
public func COLOR_CUSTOM(_ Red: Float, _ Green: Float , _ Blue: Float, _ Alpha: Float) -> UIColor {
    return  UIColor (red:  CGFloat(Red)/255.0, green: CGFloat(Green)/255.0, blue: CGFloat(Blue)/255.0, alpha: CGFloat(Alpha))
}

public func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

public func randomColorWithOpacity(opacity: CGFloat) -> UIColor {
    let r: UInt32 = arc4random_uniform(255)
    let g: UInt32 = arc4random_uniform(255)
    let b: UInt32 = arc4random_uniform(255)
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: opacity)
}

public func APPBLUECOLORWITHRANDOMOPECITY() -> UIColor {
    return UIColor(red: 0 / 255.0, green: 180 / 255.0, blue: 180 / 255.0, alpha: CGFloat(drand48()) )
}
//MARK: COLOUR
let COLOUR_DARK_RED                           = COLOR_CUSTOM(224,37,10,1)
let COLOUR_LIGHT_RED                          = COLOR_CUSTOM(253,53,1,1)
let COLOUR_DARKER_RED                         = COLOR_CUSTOM(160,35,40,1)
let COLOUR_RED                                = COLOR_CUSTOM(190,10,3,1)
let COLOUR_GREEN                              = COLOR_CUSTOM(61,210,183,1)
let COLOUR_ORENGE                             = COLOR_CUSTOM(255,141,42,1)
let COLOR_CLEAR                               = UIColor.clear
let COLOR_WHITE                               = UIColor.white
let COLOR_BLACK                               = UIColor.black
let COLOR_RED                                 = UIColor.red
let COLOR_GREEN                               = UIColor.green
let COLOR_BLUE                                = UIColor.blue
let COLOR_YELLOW                              = UIColor.yellow
let COLOR_CYAN                                = UIColor.cyan
let COLOR_BROWN                               = UIColor.brown
let COLOR_PURPLE                              = UIColor.purple
let COLOR_GRAY                                = UIColor.gray

//let COLOR_GOLDERN_YELLOW                    = COLOR_CUSTOM(195, 135, 73, 1)
//let COLOR_ORANGE                            = RGBCOLOR(255, g:103, b:2)
//let COLOUR_NEW_GREEN                        = RGBCOLOR(95,g:206,b: 121)
//let COLOUR_TEXTFIELD_BORDER                 = RGBCOLOR(183, g: 183, b: 183)
//let COLOUR_TEXTFIELD_BORDER_DARK            = RGBCOLOR(173, g: 173, b: 173)

//MARK: CELL IDENTIFIER
//**************************CELL IDENTIFIER***********************************
let CELL_IDENTIFIER_SIDE_MENU          = "SideMenuCell"
let CELL_IDENTIFIER_HOME               = "HomeCell"
let CELL_IDENTIFIER_MEAL_LIST          = "MealListCell"
let CELL_IDENTIFIER_MEAL_SELECTED      = "MealSelectedCell"
let CELL_IDENTIFIER_MEAL_SELECTED_SUB  = "MealSelectedSubCell"
let CELL_IDENTIFIER_RECEIVER_NORMAL    = "idChatReceiverNormalCell"
let CELL_IDENTIFIER_SENDER_QUOTE       = "idChatSenderQuoteCell"
let CELL_IDENTIFIER_RECEIVER_QUOTE     = "idChatReceiverQuoteCell"
let CELL_INDETIFIER_SENDER_FILE        = "idChatSenderFileCell"
let CELL_INDETIFIER_RECEIVER_FILE      = "idChatReceiverFileCell"
let CELL_IDENTIFIER_FILE_VIEW          = "idFileViewCell"
let CELL_IDENTIFIER_TODO_VIEW          = "idTodoViewCell"

//**************************FONT********************************************
//#define FONT_ROBOTO_LIGHT                   @"Roboto-Light"
//#define FONT_ROBOTO_REGULAR                 @"Roboto-Regular"

let FONT_POPPINS_REGULAR       = "Poppins-Regular"
let FONT_POPPINS_BOLD          = "Poppins-Bold"
let FONT_POPPINS_MEDIUM        = "Poppins-Medium"
let FONT_POPPINS_LIGHT         = "Poppins-Light"
let FONT_POPPINS_SEMIBOLD      = "Poppins-SemiBold"
let FONT_VARELAAROUND_REGULAR      = "VarelaRound"


//*************************CELL HEIGHT***************************************

let HEIGHT_SIDE_MENU : CGFloat                     = 75
let HEIGHT_HOME_CATEGORY : CGFloat                 = 160
let HEIGHT_MEAL_LIST_CELL:CGFloat                  = 65
let HEIGHT_SELECTD_MEAL_CELL:CGFloat               = 225
let HEIGHT_SINGLE_TITLE : CGFloat                  = 40
let HEIGHT_FONT_STYLE_KEYBOARD_CELL:CGFloat        = 60.0
let HEIGHT_KEYBOARD_STYLE_KEYBOARD_CELL:CGFloat    = 140
let HEIGHT_NOTE_CREDENTIAL_LIST:CGFloat            = 70

//***************************************************************************

let WIDTH_COLOR_CELL:CGFloat                = 70
let WIDTH_RESULT_DASHBOARD_CELL:CGFloat     = 165


//When text height/Width is not fixed add following extra height/Width into new height.
let SIZE_EXTRA_TEXT: CGFloat                = 10

//MARK: CONSTRINT CONSTANT
//******************CONSTRINT CONSTANT******************************************
let CONSTRAINT_TOP                          = "CONSTRAINT_TOP"
let CONSTRAINT_BOTTOM                       = "CONSTRAINT_BOTTOM"
let CONSTRAINT_LEADING                      = "CONSTRAINT_LEADING"
let CONSTRAINT_TRAILING                     = "CONSTRAINT_TRAILING"
let CONSTRAINT_WIDTH                        = "CONSTRAINT_WIDTH"
let CONSTRAINT_HEIGHT                       = "CONSTRAINT_HEIGHT"
let CONSTRAINT_HORIZONTAL                   = "CONSTRAINT_HORIZONTAL"
let CONSTRAINT_VERTICAL                     = "CONSTRAINT_VERTICAL"

//MARK JDPOPOVER CONSTANT
//*******************************************************************************
let JD_POPOVER_ANIMATION                    = "POPOVER_ANIMATION_BOTTOM_TO_TOP"
let JD_SELECTION_ANIMATION                  = "SELECTION_ANIMATION_BOTTOM_TO_TOP"
let JD_IMAGE_ZOOMER_ANIMATION               = "IMAGE_ZOOMER_CROSS_DISSOLVE"
let JD_FILTER_ANIMATION                     = "FILTER_ANIMATION_FADE_IN_OUT"
let JD_POPOVER_DURATION:Double              = 0.3        //0.5
let JD_POPOVER_BG_TRANSPARENT:Bool          = true
let JD_POPOVER_BORDER_COLOR                 = COLOR_RED
let JD_POPOVER_BORDER_WIDTH:CGFloat         = 0
let JD_POPOVER_CORNER_RADIUS:CGFloat        = 0
let JD_POPOVER_OUT_SIDE_CLICK_HIDDEN:Bool   = true
//*******************************************************************************

let TAG_LAYER_TOP                           = "700"
let TAG_LAYER_BOTTOM                        = "800"


//MARK: CLASS
class DesignModel: NSObject {
    
    //MARK: VARIABLE        
        class func sideMenuButton() -> UIButton {
            let btnSideMenu = UIButton(type: .custom)
            btnSideMenu.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
            btnSideMenu.setImage(UIImage(named: "icon_side_menu")!, for: UIControl.State())
            return btnSideMenu
        }
        
        class func setViewBorder(_ view: UIView, borderColor: UIColor, borderWidth: CGFloat, isShadow: Bool, cornerRadius: CGFloat, backColor: UIColor) {
            view.backgroundColor = backColor
            view.layer.borderWidth = borderWidth
            view.layer.borderColor = borderColor.cgColor
            view.layer.cornerRadius = cornerRadius
            if isShadow {
                setShadowDrop(view)
            }
        }
        
        class func setViewBorderWithoutBackColor(_ view: UIView, borderColor: UIColor, borderWidth: CGFloat, isShadow: Bool, cornerRadius: CGFloat) {
            view.layer.borderWidth = borderWidth
            view.layer.borderColor = borderColor.cgColor
            view.layer.cornerRadius = cornerRadius
            if isShadow {
                setShadowDrop(view)
            }
        }
        
        class func setTopBorder(_ view: UIView, borderColor: UIColor, borderWidth: CGFloat) {
            if view.layer.sublayers!.last!.accessibilityLabel != TAG_LAYER_TOP {
                let border = CALayer()
                border.backgroundColor = borderColor.cgColor
                border.accessibilityLabel = String(TAG_LAYER_TOP)
                border.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: borderWidth)
                view.layer.addSublayer(border)
            }
        }
        
        class func setBottomBorderView(_ view: UIView, borderColor: UIColor, borderWidth: CGFloat) {
            if  view.layer.sublayers!.last!.accessibilityLabel != TAG_LAYER_BOTTOM {
                let border = CALayer()
                border.backgroundColor = borderColor.cgColor
                border.accessibilityLabel = String(TAG_LAYER_BOTTOM)
                border.frame = CGRect(x: 0, y: view.frame.height - borderWidth, width: view.frame.width, height: borderWidth)
                view.layer.addSublayer(border)
            }
        }
        class func setShadowDrop(_ view: UIView) {
            let layer = view.layer
            layer.shadowOffset = CGSize(width: 5, height: 0)
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowRadius = 8.5
            layer.shadowOpacity = 1
            layer.shadowPath = UIBezierPath(rect: layer.bounds).cgPath
        }
    class func setViewWithShadowDrop(view: UIView,isShadow: Bool,conerRedias: CGFloat) -> UIView {
        let View = UIView()
        View.clipsToBounds = true
        View.layer.cornerRadius = conerRedias
        if isShadow {setShadowDrop(View)}
        return View
    }
    class func createImageView(_ frame: CGRect, image: UIImage, contentMode: UIView.ContentMode) -> UIImageView
        {
            let imageView: UIImageView = UIImageView.init(frame: frame);
            imageView.image = image;
            imageView.contentMode = contentMode;
            return imageView;
        }
        
    class func createImageView(_ frame: CGRect, imageName: String, contentMode: UIView.ContentMode) -> UIImageView
        {
            let imageView: UIImageView = self.createImageView(frame, image:UIImage(named: imageName)!, contentMode:contentMode);
            return imageView;
        }
        
    class func createImageView(_ frame: CGRect, imageName: String, tag: Int, contentMode: UIView.ContentMode) -> UIImageView
        {
            let imageView: UIImageView = self.createImageView(frame, image:UIImage(named: imageName)!, tag:tag , contentMode:contentMode);
            return imageView;
        }
        
    class func createImageView(_ frame: CGRect, image: UIImage, tag: Int, contentMode: UIView.ContentMode) -> UIImageView
        {
            let imageView: UIImageView = self.createImageView(frame, tag:tag, contentMode:contentMode);
            imageView.image = image;
            return imageView;
        }
        
    class func createImageView(_ frame: CGRect, tag: Int, contentMode: UIView.ContentMode) -> UIImageView
        {
            let imageView: UIImageView = UIImageView.init(frame: frame);
            imageView.tag = tag;
            imageView.contentMode = contentMode;
            return imageView;
        }
        
        class func createTableView(_ frame: CGRect, rowHeight: CGFloat, separatorColor: UIColor, isBounce: Bool) -> UITableView {
            let tableView = UITableView(frame: frame, style: .plain)
            tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            tableView.rowHeight = rowHeight
            tableView.bounces = isBounce
            //tableView.tableFooterView! = UIView(frame: CGRect.zero)
            tableView.separatorColor = separatorColor
            tableView.backgroundColor = UIColor.clear
            tableView.showsHorizontalScrollIndicator = false
            tableView.showsVerticalScrollIndicator = false
            return tableView
        }
    
        //MARK: IMAGE METHODS
        class func resizeImageByWidth(_ image: UIImage, width: CGFloat) -> UIImage {
            let imageWidth: CGFloat = image.size.width;
            let imageHeight: CGFloat = image.size.height;
            let newHeight: CGFloat = (imageHeight / imageWidth) * width;
            return self.imageByScalingToSize(image, targetSize: CGSize(width: width, height: newHeight))
        }
        
        class func resizeImageByHeight(_ image: UIImage, height: CGFloat) -> UIImage {
            let imageWidth: CGFloat = image.size.width;
            let imageHeight: CGFloat = image.size.height;
            let newWidth: CGFloat = (imageWidth / imageHeight) * height;
            return self.imageByScalingToSize(image, targetSize: CGSize(width: newWidth, height: height))
        }
        
        class func imageByScalingToSize(_ sourceImage: UIImage, targetSize: CGSize) -> UIImage {
            UIGraphicsBeginImageContextWithOptions(targetSize, false, 2.0);
            sourceImage.draw(in: CGRect(x: 0, y: 0,width: targetSize.width,height: targetSize.height))
            let generatedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
            UIGraphicsEndImageContext();
            return generatedImage;
        }
        
        class func createImageButton(_ frame: CGRect, imageName: String, tag: Int) -> UIButton {
            return self.createImageButton(frame, image: UIImage(named: imageName)!, tag: tag)
        }
        
        class func createImageButton(_ frame: CGRect, image: UIImage, tag: Int) -> UIButton {
            let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
            button.frame = frame
            button.tag = tag
            button.setImage(image, for: UIControl.State())
            button.showsTouchWhenHighlighted = true
            button.backgroundColor = UIColor.clear
            button.showsTouchWhenHighlighted = true
            button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
            return button
        }
        
        class func createImageButton(_ frame: CGRect, unSelectedImage: UIImage, selectedImage: UIImage, tag: Int) -> UIButton {
            let button: UIButton = self.createImageButton(frame, image: unSelectedImage, tag: tag)
            button.setImage(selectedImage, for: UIControl.State.selected)
            return button
        }
        
        class func createImageButton(_ frame: CGRect, unSelectedImageName: String, selectedImageName: String, tag: Int) -> UIButton {
            return self.createImageButton(frame, unSelectedImage: UIImage.init(named: unSelectedImageName)!, selectedImage: UIImage(named: selectedImageName)!, tag: tag)
        }
        
        class func createButton(_ frame: CGRect, title: String, bgColor: UIColor, titleFont: UIFont, titleColor: UIColor, cornerRadius: CGFloat) -> UIButton {
            let btn = UIButton(type: .custom)
            btn.frame = frame
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(titleColor, for: .normal)
            btn.titleLabel!.font = titleFont
            btn.backgroundColor = bgColor
            btn.layer.cornerRadius = cornerRadius
            btn.showsTouchWhenHighlighted = true
            return btn
        }
        
    class func createButton(_ frame: CGRect, title: String, tag: Int, titleColor: UIColor, titleFont: UIFont, textAlignment: UIControl.ContentHorizontalAlignment, bgColor: UIColor, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat) -> UIButton {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
            button.frame = frame
            button.tag = tag
            button.setTitle("", for: .normal)
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.titleLabel?.font = titleFont
            button.contentHorizontalAlignment = textAlignment
            button.backgroundColor = bgColor
            button.layer.cornerRadius = cornerRadius
            button.showsTouchWhenHighlighted = true
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
            
            if borderWidth != 0 { button.layer.borderWidth = borderWidth }
            if borderColor != nil { button.layer.borderColor = borderColor!.cgColor }
            
            return button
        }
        
        class func createImageButton(_ frame: CGRect, bgColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat, tag: Int) -> UIButton {
            let btn = UIButton(type: .custom)
            btn.frame = frame
            btn.backgroundColor = bgColor
            btn.layer.cornerRadius = cornerRadius
            btn.showsTouchWhenHighlighted = true
            btn.titleLabel!.numberOfLines = 0
            btn.tag = tag
            if borderWidth != 0 {
                btn.layer.borderColor = borderColor.cgColor
                btn.layer.borderWidth = borderWidth
            }
            return btn
        }
        
        class func createLabel(_ frame:CGRect,text:String,textColor:UIColor,textAlignment:NSTextAlignment,textFont:UIFont,backColor:UIColor,tag:Int) -> UILabel
        {
            let label:UILabel = UILabel.init(frame: frame)
            label.textColor = textColor
            label.text = text
            label.font = textFont
            label.textAlignment = textAlignment
            label.tag = tag
            label.backgroundColor = backColor
            label.numberOfLines = 0
            label.lineBreakMode = .byCharWrapping
            
            return label
        }
        class func createPaddingLabel(frame: CGRect, labelTag: Int, textColor: UIColor, textAlignment: NSTextAlignment, textFont: UIFont, padding: UIEdgeInsets) -> UILabel {
            
            let label:UILabel = UILabel.init(frame: frame)
            
            label.tag = labelTag
            label.textColor = textColor
            label.font = textFont
            label.textAlignment = textAlignment
            label.textColor = textColor
            label.numberOfLines = 0
            label.backgroundColor = UIColor.clear
            
            return label
        }
        class func createRegularLabel(_ frame: CGRect, labelTag: Int, textColor: UIColor, textAlignment: NSTextAlignment, textFont: UIFont) -> UILabel {
            let label = UILabel(frame: frame)
            label.tag = labelTag
            label.textColor = textColor
            label.font = textFont
            label.textAlignment = textAlignment
            label.textColor = textColor
            label.backgroundColor = UIColor.clear
            label.numberOfLines = 0
            return label
        }
        
        class func createScrollView(_ frame:CGRect ,tag: Int, Bounces:Bool)
            -> UIScrollView {
                let scrollView: UIScrollView = UIScrollView(frame: frame)
                scrollView.tag = tag
                scrollView.bounces = Bounces
                scrollView.isUserInteractionEnabled = true
                scrollView.isMultipleTouchEnabled = true
                return scrollView
        }
        
        //MARK: ACTIVITYINDICATOR METHODS
    class func createActivityIndicator(_ frame:CGRect , indicatorStyle :UIActivityIndicatorView.Style) -> UIActivityIndicatorView
        {
            let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView.init(frame: frame)
            activityIndicator.style = indicatorStyle
            activityIndicator.hidesWhenStopped = true
            return activityIndicator
        }
    
    //MARK: NSLAYOUTCONSTRAINT METHODS
    class func setConstraint_ConWidth_ConHeight_Horizontal_Vertical(_ subView: UIView, superView: UIView, width: CGFloat, height: CGFloat) -> typeAliasDictionary {
        subView.translatesAutoresizingMaskIntoConstraints  = false;
        
        //WIDTH -  CONSTATNT
        let constraintWidth: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: width)
        superView.addConstraint(constraintWidth)
        
        //HEIGHT -  CONSTATNT
        let constraintHeight: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        superView.addConstraint(constraintHeight)
        
        //HORZONTAL
        let constraintHorizontal: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        superView.addConstraint(constraintHorizontal)
        
        //VERTICAL
        let constraintVertical: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        superView.addConstraint(constraintVertical)
        
        superView.layoutIfNeeded()
        
        return [CONSTRAINT_WIDTH:constraintWidth,
                CONSTRAINT_HEIGHT:constraintHeight,
                CONSTRAINT_HORIZONTAL:constraintHorizontal,
                CONSTRAINT_VERTICAL:constraintVertical]
    }
    
    
    class func setConstraint_ConWidth_ConHeight_Leading_Top(_ subView: UIView, superView: UIView, width: CGFloat, height: CGFloat , top:CGFloat , leading:CGFloat) -> typeAliasDictionary {
        subView.translatesAutoresizingMaskIntoConstraints  = false;
        
        //WIDTH -  CONSTATNT
        let constraintWidth: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: width)
        superView.addConstraint(constraintWidth)
        
        //HEIGHT -  CONSTATNT
        let constraintHeight: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        superView.addConstraint(constraintHeight)
        
        //HORZONTAL
        let constraintHorizontal: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: leading)
        superView.addConstraint(constraintHorizontal)
        
        //VERTICAL
        let constraintVertical: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: top)
        superView.addConstraint(constraintVertical)
        
        superView.layoutIfNeeded()
        
        return [CONSTRAINT_WIDTH:constraintWidth,
                CONSTRAINT_HEIGHT:constraintHeight,
                CONSTRAINT_HORIZONTAL:constraintHorizontal,
                CONSTRAINT_VERTICAL:constraintVertical]
    }
    
    class func setConstraint_Leading_Top_ConWidth_ConHeight(subView: UIView, superView: UIView, leading: CGFloat, top: CGFloat, width: CGFloat, height: CGFloat) -> typeAliasDictionary {
        subView.translatesAutoresizingMaskIntoConstraints  = false;
        
        //LEADING - TO SUPERVIEW
        let constraintLeading: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: leading)
        superView.addConstraint(constraintLeading)
        
        //TOP - TO SUPERVIEW
        let constraintTop: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: top)
        superView.addConstraint(constraintTop)
        
        //WIDTH -  CONSTATNT
        let constraintWidth: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: width)
        superView.addConstraint(constraintWidth)
        
        //HEIGHT -  CONSTATNT
        let constraintHeight: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        superView.addConstraint(constraintHeight)
        
        superView.layoutIfNeeded()
        
        return [CONSTRAINT_LEADING:constraintLeading,
                CONSTRAINT_TOP:constraintTop,
                CONSTRAINT_WIDTH:constraintWidth,
                CONSTRAINT_HEIGHT:constraintHeight]
        
    }
    
    class func setConstraint_Trailing_Top_ConWidth_ConHeight(subView: UIView, superView: UIView, trailing: CGFloat, top: CGFloat, width: CGFloat, height: CGFloat) -> typeAliasDictionary {
        subView.translatesAutoresizingMaskIntoConstraints  = false;
        
        //TRAILING - TO SUPERVIEW
        let constraintTrailing: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: trailing)
        superView.addConstraint(constraintTrailing)
        
        //TOP - TO SUPERVIEW
        let constraintTop: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: top)
        superView.addConstraint(constraintTop)
        
        //WIDTH -  CONSTATNT
        let constraintWidth: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: width)
        superView.addConstraint(constraintWidth)
        
        //HEIGHT -  CONSTATNT
        let constraintHeight: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        superView.addConstraint(constraintHeight)
        
        superView.layoutIfNeeded()
        
        return [CONSTRAINT_TRAILING:constraintTrailing,
                CONSTRAINT_TOP:constraintTop,
                CONSTRAINT_WIDTH:constraintWidth,
                CONSTRAINT_HEIGHT:constraintHeight]
    }
    
    
    class func setScrollSubViewConstraint(_ subView: UIView, superView :UIView, toView: UIView, leading: CGFloat, trailing: CGFloat, top: CGFloat, bottom: CGFloat, width: CGFloat, height: CGFloat) -> typeAliasDictionary {
        
        subView.translatesAutoresizingMaskIntoConstraints  = false;
        
        //LEADING - TO SUPERVIEW
        let constraintLeading: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: leading)
        superView.addConstraint(constraintLeading)
        
        //TRAILING - TO SUPERVIEW
        let constraintTrailing: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: trailing)
        superView.addConstraint(constraintTrailing);
        
        //TOP - TO SUPERVIEW
        let constraintTop: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: top)
        superView.addConstraint(constraintTop);
        
        //BOTTOM - TO SUPERVIEW
        let constraintBottom: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: bottom)
        superView.addConstraint(constraintBottom);
        
        //WIDTH -  CONSTATNT
        let constraintWidth: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toView, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: width)
        superView.addConstraint(constraintWidth);
        
        //HEIGHT - CONSTANT
        let constraintHeight: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: height)
        superView.addConstraint(constraintHeight);
        
        superView.layoutIfNeeded()
        
        return [CONSTRAINT_LEADING:constraintLeading,
                CONSTRAINT_TRAILING:constraintTrailing,
                CONSTRAINT_TOP:constraintTop,
                CONSTRAINT_BOTTOM:constraintBottom,
                CONSTRAINT_WIDTH:constraintWidth,
                CONSTRAINT_HEIGHT:constraintHeight]
    }
    
    
        //MARK: ROTATION
        class func rotateView(_ view: UIView, angle: CGFloat, isAnimation: Bool) {
            if isAnimation {
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: {() -> Void in
                    view.transform = CGAffineTransform(rotationAngle: angle)
                }, completion: { _ in })
            }
            else {
                view.transform = CGAffineTransform(rotationAngle: angle)
            }
        }
        
        class func rotateView_90(_ view: UIView, isAnimation: Bool) {
            self.rotateView(view, angle: (-(.pi / 2)), isAnimation: isAnimation)
        }
        
        class func rotateView_MINUS_90(_ view: UIView, isAnimation: Bool) {
            self.rotateView(view, angle: (.pi / 2), isAnimation: isAnimation)
        }
        
        class func rotateView_180(_ view: UIView, isAnimation: Bool) {
            self.rotateView(view, angle: .pi, isAnimation: isAnimation)
        }
        
        class func rotateView_360(_ view: UIView, isAnimation: Bool) {
            self.rotateView(view, angle: (.pi * 2), isAnimation: isAnimation)
        }
        
        class func getOrientation(_ view: UIView) -> Int {
            //0 - Potrait , 1 - Landscape
            let frame = view.frame
            return frame.width > frame.height ? 1 : 0
        }

}

