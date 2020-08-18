//
//  App_Popover.swift
//  WhatsappChatSticker
//
//  Created by Setblue on 27/11/18.
//  Copyright © 2018 WhatsApp. All rights reserved.
//

import UIKit
protocol AppPopoverDelegate { func appPopoverClose() }

class App_Popover: UIView, UIGestureRecognizerDelegate {
    //MARK: PROPERTIES
    var delegate: AppPopoverDelegate!
    
    //MARK: CONSTANTS
    internal let TAG_SUPER:Int = 101
    internal let TAG_SUB:Int = 1101
    
    //MARK: VARIABLES
    var _POPOVER_ANIMATION = POPOVER_ANIMATION(rawValue: 0)
    var _animationDuration:TimeInterval = 0.3
    static let sharedInstance = App_Popover()
    var _subView:UIView!
    var viewBG = UIView.init()
    
    //MARK: VIEW METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(_ view: UIView , animation:POPOVER_ANIMATION , animationDuration:TimeInterval , isBGTransparent:Bool , borderColor:UIColor , borderWidth:CGFloat , borderCorner:CGFloat , isOutSideClickedHidden:Bool) {
        
        let frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        super.init(frame: frame)
        self.frame = frame
        self.alpha = 0
        self.tag = TAG_SUPER
        self.backgroundColor = COLOR_CUSTOM(0, 0, 0, 0.4)
        _animationDuration = animationDuration
        _POPOVER_ANIMATION = animation
        
        if isOutSideClickedHidden{
            let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action:#selector(self.closeJDPopoverAction))
            tapGesture.delegate = self
            self.tag = TAG_SUPER
            self.addGestureRecognizer(tapGesture)
            self.isMultipleTouchEnabled = true
            self.isUserInteractionEnabled = true
        }
        _subView = UIView.init()
        _subView = view
        _subView.tag = TAG_SUB
        _subView.clipsToBounds = true
        self.addSubview(_subView)
        
        //SET AUTO LAYOUT
        let padding:CGFloat = (self.frame.width - _subView.frame.width) / 2
        let viewHeight:CGFloat = _subView.frame.height
       // let viewWidth:CGFloat = (self.frame.width - (padding*2))
        let viewWidth:CGFloat = _subView.frame.width
        let viewTopSpace:CGFloat = (self.frame.height - viewHeight) / 3
        
        let  _ = DesignModel.setConstraint_ConWidth_ConHeight_Leading_Top(_subView, superView: self, width: viewWidth, height: viewHeight, top: viewTopSpace, leading: padding)

        _subView.layer.borderWidth = borderWidth
        _subView.layer.borderColor = borderColor.cgColor
        _subView.layer.cornerRadius = borderCorner
        if _POPOVER_ANIMATION == POPOVER_ANIMATION.popover_ANIMATION_CROSS_DISSOLVE{
            self.alpha = 0
            UIView.animate(withDuration: _animationDuration, delay: 0.0, options:UIView.AnimationOptions.beginFromCurrentState, animations: {
                self.alpha = 1
            }, completion: nil)
        }
            
        else if _POPOVER_ANIMATION == POPOVER_ANIMATION.popover_ANIMATION_RIGHT_TO_LEFT{
            
            var sframe:CGRect = _subView.frame
            sframe.origin.x = self.frame.width
            _subView.frame = sframe
            
            UIView.animate(withDuration: _animationDuration, delay: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                let xOrigin = (self.frame.width / 2) - (self._subView.frame.width / 2)
                let frame:CGRect = CGRect(x: xOrigin, y: self._subView.frame.origin.y, width: self._subView.frame.width, height: self._subView.frame.height)
                self._subView.frame = frame
            }, completion: { (finshed) in
                self.layer.removeAllAnimations()
            })
        }
            
        else if _POPOVER_ANIMATION == POPOVER_ANIMATION.popover_ANIMATION_BOTTOM_TO_TOP{
            
            var sFrame:CGRect = _subView.frame
            sFrame.origin.y = self.frame.height + 10
            _subView.frame = sFrame
            
            UIView.animate(withDuration: _animationDuration, delay: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                
                let yOrigin =   (self.frame.height / 2) - (self._subView.frame.height / 2)
                let frame:CGRect = CGRect(x: self._subView.frame.origin.x, y: yOrigin, width: self._subView.frame.width, height: self._subView.frame.height)
                self._subView.frame = frame
                
            }, completion: { (finished) in
                self.layer.removeAllAnimations()
            })
        }
            
        else if _POPOVER_ANIMATION == POPOVER_ANIMATION.popover_ANIMATION_FADE_IN_OUT{
            self.transform = CGAffineTransform(scaleX: 3, y: 3)
            self.alpha = 0
            UIView.animate(withDuration: _animationDuration, delay: 0.0, options:UIView.AnimationOptions.beginFromCurrentState, animations: {
                self.alpha = 1
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion:{(finished) in
                self.layer.removeAllAnimations()
            })
        }
    }
    
    @objc func closeJDPopoverAction(){
        
        if _POPOVER_ANIMATION == POPOVER_ANIMATION.popover_ANIMATION_CROSS_DISSOLVE{
            self.alpha = 1
            UIView.animate(withDuration: _animationDuration, delay: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                self.alpha = 0
                self.removeFromSuperview()
            },  completion:{ (finished) in
                self.layer.removeAllAnimations()
                self.delegate.appPopoverClose()
            })
        }
        else if _POPOVER_ANIMATION == POPOVER_ANIMATION.popover_ANIMATION_FADE_IN_OUT{
            UIView.animate(withDuration: _animationDuration, delay: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                self.transform = CGAffineTransform(scaleX: 3, y: 3)
                self.alpha = 0.0
            }, completion: { (finished) in
                self.layer.removeAllAnimations()
                self.removeFromSuperview()
                self.delegate.appPopoverClose()
            })
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let view = touch.view
        if view!.tag != TAG_SUPER { return false }
        return true
    }
}
