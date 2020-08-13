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
    
    func getHomeCategoryList (param : typeAliasDictionary,response : @escaping( _ data : [typeAliasDictionary] , _ rstatus : Int, _ message : String) -> Void ) {
        let url : String = WebServicePrefix.GetWSUrl(.GetHomeCategoryList)
        ServiceManager.sharedInstance.getRequest(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response([], 0, message!)
            }else{
                if rstatus == 1 {
                    response((data as! typeAliasDictionary)[RES_data] as! [typeAliasDictionary], 1, message!)
                }else{
                    response([typeAliasDictionary](), 0, message!)
                }
            }
        }
    }
    
    func getCategoryDetailList (param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
        let url : String = WebServicePrefix.GetWSUrl(.GetCategoryDetail)
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
    
    func callPlaceOrder(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
           let url : String = WebServicePrefix.GetWSUrl(.GetPlaceOrder)
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
    
    class chargePayAPI {
        
        static public func processPayment(_ nonce: String, completion: @escaping (String?, String?) -> Void) {
            let url = URL(string: App_Constant.Square.CHARGE_URL)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let httpBody = nonce.data(using: .utf8)
            request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(App_Constant.Square.CHARGE_TOKEN, forHTTPHeaderField: "Authorization")
            request.httpBody = httpBody
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error as NSError?{
                    if error.domain == NSURLErrorDomain {
                        DispatchQueue.main.async {
                            completion("", "Could not contact host")
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion("", "Something went wrong")
                        }
                    }
                } else if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        
                        print(json)

                        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                            DispatchQueue.main.async {
                                if let payment = json["payment"] as? typeAliasDictionary {
                                    if let status = payment["status"] as? String , status.uppercased() == "COMPLETED" {
                                        completion(payment["order_id"] as? String, nil)
                                    }
                                    else {
                                        if let errors = json["errors"] as? [typeAliasDictionary] , !errors.isEmpty {
                                            completion("", "\(errors[0]["detail"]!)")
                                        }else {
                                            completion("", "FAILED")
                                        }
                                    }
                                }
                                else {
                                    if let errors = json["errors"] as? [typeAliasDictionary] , !errors.isEmpty {
                                        completion("", "\(errors[0]["detail"]!)")
                                    }else {
                                        completion("", "FAILED")
                                    }
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                if let errors = json["errors"] as? [typeAliasDictionary] , !errors.isEmpty {
                                    completion("", "\(errors[0]["detail"]!)")
                                }else {
                                    completion("", "FAILED")
                                }
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion("", "Failure")
                        }
                    }
                }
            }.resume()
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
