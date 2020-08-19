//
//  ServiceCollection.swift
//  Shelvinza
//
//  Created by Setblue on 10/11/16.
//  Copyright © 2016 Setblue. All rights reserved.
//

import Foundation
//import Alamofire
//import SwiftyJSON
//import FCAlertView

class ServiceCollection {
    
    static let sharedInstance = ServiceCollection()
    init() {}
    
    //MARK:LOGIN
    func getLogin(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
    let url : String = WebServicePrefix.GetWSUrl(.GetLogin)
        ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                if rstatus == 1 {
                    response(data as! typeAliasDictionary, 1, message!)
                }else{
                    response(typeAliasDictionary(), 0, message!)
                }
            }
        }
    }
    
    //MARK: CITY LIST
    func getCategoryList(param : typeAliasDictionary,response : @escaping( _ data : [typeAliasDictionary] , _ rstatus : Int, _ message : String) -> Void ) {
    let url : String = WebServicePrefix.GetWSUrl(.GetHomeCategoryList)
        ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response([typeAliasDictionary](), 0, message!)
            }else{
                if rstatus == 1 {
                    response(data as! [typeAliasDictionary], 1, message!)
                }else{
                    response([typeAliasDictionary](), 0, message!)
                }
            }
        }
    }
    
    //MARK: SITE LIST
    func getSitesList(param : typeAliasDictionary,response : @escaping( _ data : [typeAliasDictionary] , _ rstatus : Int, _ message : String) -> Void ) {
    let url : String = WebServicePrefix.GetWSUrl(.GetSiteList)
        ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response([typeAliasDictionary](), 0, message!)
            }else{
                if rstatus == 1 {
                    response(data as! [typeAliasDictionary], 1, message!)
                }else{
                    response([typeAliasDictionary](), 0, message!)
                }
            }
        }
    }
    
    func createWorkPermit(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
    let url : String = WebServicePrefix.GetWSUrl(.CreateWorkpermit)
        ServiceManager.sharedInstance.postMultipartFormData(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                if rstatus == 1 {
                    response(data as! typeAliasDictionary, 1, message!)
                }else{
                    response(typeAliasDictionary(), 0, message!)
                }
            }
        }
    }
    
    func createHotWork(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
    let url : String = WebServicePrefix.GetWSUrl(.CreateHotWork)
        ServiceManager.sharedInstance.postMultipartFormData(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                if rstatus == 1 {
                    response(data as! typeAliasDictionary, 1, message!)
                }else{
                    response(typeAliasDictionary(), 0, message!)
                }
            }
        }
    }
    
    
    
    func updateWorkPermit(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
    let url : String = WebServicePrefix.GetWSUrl(.UpdateWorkpermit)
        ServiceManager.sharedInstance.postMultipartFormData(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                if rstatus == 1 {
                    response(data as! typeAliasDictionary, 1, message!)
                }else{
                    response(typeAliasDictionary(), 0, message!)
                }
            }
        }
    }

    func CreateSubcontractors(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
    let url : String = WebServicePrefix.GetWSUrl(.CreateSubcontractors)
        ServiceManager.sharedInstance.postMultipartFormData(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                if rstatus == 1 {
                    response(data as! typeAliasDictionary, 1, message!)
                }else{
                    response(typeAliasDictionary(), 0, message!)
                }
            }
        }
    }
    
    //MARK: CITY LIST
    func getCityList(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
    let url : String = WebServicePrefix.GetWSUrl(.GetCityList)
        ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                if rstatus == 1 {
                    response(data as! typeAliasDictionary, 1, message!)
                }else{
                    response(typeAliasDictionary(), 0, message!)
                }
            }
        }
    }
    
    //MARK: REGISTER
       func getRegister(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
       let url : String = WebServicePrefix.GetWSUrl(.UserRegistration)
           ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
               if error != nil {
                   response(typeAliasDictionary(), 0, message!)
               }else{
                   if rstatus == 1 {
                       response(data as! typeAliasDictionary, 1, message!)
                   }else{
                       response(typeAliasDictionary(), 0, message!)
                   }
               }
           }
       }
       
       //MARK: ForgotPassword
       func getForgotPassword(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
       let url : String = WebServicePrefix.GetWSUrl(.ForgotPassword)
           ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
               if error != nil {
                   response(typeAliasDictionary(), 0, message!)
               }else{
                   if rstatus == 1 {
                       response(data as! typeAliasDictionary, 1, message!)
                   }else{
                       response(typeAliasDictionary(), 0, message!)
                   }
               }
           }
       }
       
    //MARK: USER REVIEW
     func getUserReviewList(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
     let url : String = WebServicePrefix.GetWSUrl(.GetUserReviews)
         ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
             if error != nil {
                 response(typeAliasDictionary(), 0, message!)
             }else{
                 if rstatus == 1 {
                     response(data as! typeAliasDictionary, 1, message!)
                 }else{
                     response(typeAliasDictionary(), 0, message!)
                 }
             }
         }
     }
    
    //MARK: UPDATE DETAILS
    func updateUser(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
    let url : String = WebServicePrefix.GetWSUrl(.UpdateUserdetails)
        ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                if rstatus == 1 {
                    response(data as! typeAliasDictionary, 1, message!)
                }else{
                    response(typeAliasDictionary(), 0, message!)
                }
            }
        }
    }

    //MARK: CART DETAILS
    func getCart(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
    let url : String = WebServicePrefix.GetWSUrl(.GetCart)
        ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                if rstatus == 1 {
                    response(data as! typeAliasDictionary, 1, message!)
                }else{
                    response(typeAliasDictionary(), 0, message!)
                }
            }
        }
    }
    
    //MARK: COUPON LIST
    func getCoupons(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
    let url : String = WebServicePrefix.GetWSUrl(.GetCoupons)
        ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                if rstatus == 1 {
                    response(data as! typeAliasDictionary, 1, message!)
                }else{
                    response(typeAliasDictionary(), 0, message!)
                }
            }
        }
    }

    //MARK: REMOVE CART
    func removeCart(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
    let url : String = WebServicePrefix.GetWSUrl(.DeleteUserCart)
        ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                if rstatus == 1 {
                    response(data as! typeAliasDictionary, 1, message!)
                }else{
                    response(typeAliasDictionary(), 0, message!)
                }
            }
        }
    }
    
    //MARK: REMOVE CART ITEM
       func removeCartItem(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
       let url : String = WebServicePrefix.GetWSUrl(.deleteCartitem)
           ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
               if error != nil {
                   response(typeAliasDictionary(), 0, message!)
               }else{
                   if rstatus == 1 {
                       response(data as! typeAliasDictionary, 1, message!)
                   }else{
                       response(typeAliasDictionary(), 0, message!)
                   }
               }
           }
       }
    
    func getClusterSiteList (param : typeAliasDictionary,response : @escaping( _ data : [typeAliasDictionary] , _ rstatus : Int, _ message : String) -> Void ) {
        let url : String = WebServicePrefix.GetWSUrl(.PostClusterSiteList)
        ServiceManager.sharedInstance.postRequest(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response([], 0, message!)
            }else{
                if rstatus == 1 {
                    response((data as! [typeAliasDictionary]) , 1, message!)
                }else{
                    response([typeAliasDictionary](), 0, message!)
                }
            }
        }
    }
    
    func getClusterList(param : typeAliasDictionary,response : @escaping( _ data : [typeAliasDictionary] , _ rstatus : Int, _ message : String) -> Void ) {
        let url : String = WebServicePrefix.GetWSUrl(.GetClusterList)
        ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response([typeAliasDictionary](), 0, message!)
            }else{
                if rstatus == 1 {
                    response((data as! [typeAliasDictionary]), 1, message!)
                }else{
                    response([typeAliasDictionary](), 0, message!)
                }
            }
        }
    }
    
    func callAddToCart(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
        let url : String = WebServicePrefix.GetWSUrl(.GetAddToCart)
        ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                if rstatus == 1 {
                    response((data as! typeAliasDictionary), 1, message!)
                }else{
                    response(typeAliasDictionary(), 0, message!)
                }
            }
        }
    }

    func callAddToCartPost(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
        let url : String = WebServicePrefix.GetWSUrl(.GetAddToCart)
        ServiceManager.sharedInstance.postRequest1(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                if rstatus == 1 {
                    response((data as! typeAliasDictionary), 1, message!)
                }else {
                    response(typeAliasDictionary(), 0, message!)
                }
            }
        }
    }
    
    func callPlaceOrder1(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
        let url : String = WebServicePrefix.GetWSUrl(.GetPlaceOrder)
        ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                if rstatus == 1 {
                    response((data as! typeAliasDictionary), 1, message!)
                }else{
                    response(typeAliasDictionary(), 0, message!)
                }
            }
        }
    }
    
    func callDashboard(param : typeAliasDictionary,isRegion:Bool ,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
        let url : String = WebServicePrefix.GetWSUrl(isRegion ? .PostRegionDashboard : .PostDashboard)
           ServiceManager.sharedInstance.postRequest(url, parameters: param) { (data, error, message, rstatus ) in
               if error != nil {
                   response(typeAliasDictionary(), 0, message!)
               }else{
                   if rstatus == 1 {
                       response((data as! typeAliasDictionary), 1, message!)
                   }else {
                       response(typeAliasDictionary(), 0, message!)
                   }
               }
           }
       }

    /*
    func getUploadFiles(param : typeAliasDictionary,response : @escaping( _ data : [typeAliasDictionary] , _ rstatus : Bool, _ message : String) -> Void ) {
        let arrI : NSArray = NSArray.init(object: param[RES_image] as Any)
        let url : String = WebServicePrefix.GetWSUrl(.GetUploadFile)
        ServiceManager.sharedInstance.uploadImage(endpointurl: url, imageTagName: RES_image, parameters: param, filePath: arrI, responseData: { (data, error, message, rstatus ) in
            if error != nil {
                response([typeAliasDictionary](), false, message!)
            }else{
                if rstatus == true {
                    response(data as! [typeAliasDictionary], rstatus, message!)
                }else{
                    response([typeAliasDictionary](), rstatus, message!)
                }
            }
        })
    }*/
}
