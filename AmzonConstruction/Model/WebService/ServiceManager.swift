 //
 //  ServiceManager.swift
 //  Shelvinza
 //
 //  Created by Setblue on 10/11/16.
 //  Copyright © 2016 Setblue. All rights reserved.
 //
 
 import Foundation
 import Alamofire
 // import SwiftyJSON
 
 class ServiceManager {
    
    static let sharedInstance = ServiceManager()
    
    var URLString : String!
    var Message : String!
    var resObjects:Any!
    var arrOfGetKeyValue: NSMutableArray = NSMutableArray()
    // METHODS
    init() {}
    
    //MARK:- GET Request
    func getRequest(_ endpointurl:String, parameters:typeAliasDictionary,responseData:@escaping (_ data: Any?, _ error: NSError?, _ message: String?, _ rstatus : Int ) -> Void) {
        
        ShowNetworkIndicator(true)
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        AF.request(endpointurl, method: .get , parameters: parameters )
            .responseJSON { response in
                
                print("--------------******------------")
                //                print(response.request ?? "")
                //                print(response.result)
                print("--------------******------------")
                
                ShowNetworkIndicator(false)
                if let _ = response.error {
                    responseData(nil,  response.error as NSError?, "Unable to connect to server, please check your internet connection or try switching your network", 0)
                }else {
                    switch response.result {
                    case .success(_):
                        if endpointurl.isContainString("getClusterdetails") {
                            guard let responseJSON:[typeAliasDictionary] = response.value as? [typeAliasDictionary] else {
                                print("Invalid tag information received from the service")
                                responseData(nil, nil, SOMETHING_WRONG, 0)
                                return
                            }
                            self.Message = ""
                            responseData(responseJSON, nil, self.Message, 1)
                        }
                        else if endpointurl.isContainString("getCategoydetails") {
                            guard let responseJSON:[typeAliasDictionary] = response.value as? [typeAliasDictionary] else {
                                print("Invalid tag information received from the service")
                                responseData(nil, nil, SOMETHING_WRONG, 0)
                                return
                            }
                            self.Message = ""
                            responseData(responseJSON, nil, self.Message, 1)
                        }
                        else if endpointurl.isContainString("getSitedetails") {
                            guard let responseJSON:[typeAliasDictionary] = response.value as? [typeAliasDictionary] else {
                                print("Invalid tag information received from the service")
                                responseData(nil, nil, SOMETHING_WRONG, 0)
                                return
                            }
                            self.Message = ""
                            responseData(responseJSON, nil, self.Message, 1)
                        }
                        else {
                            
                            guard let responseJSON:typeAliasDictionary = response.value as? typeAliasDictionary else {
                                print("Invalid tag information received from the service")
                                responseData(nil, nil, SOMETHING_WRONG, 0)
                                return
                            }
                            self.Message = ""
                            responseData(responseJSON, nil, self.Message, 1)
                        }
                    case .failure(let error):
                        responseData(nil, error as NSError, SOMETHING_WRONG, 0)
                    }
                }
        }
    }
    
    //MARK:- GET Request
    func getRequestWithheaders(_ endpointurl:String, parameters:typeAliasDictionary,responseData:@escaping (_ data: Any?, _ error: NSError?, _ message: String?, _ rstatus : Int ) -> Void) {
        
        ShowNetworkIndicator(true)
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        
        AF.request(endpointurl, method: .get , parameters: parameters, headers : getHeaders())
            .responseJSON { response in
                
                print("--------------******------------")
                print(response.request ?? "")
                print(response.value ?? "")
                print("--------------******------------")
                
                ShowNetworkIndicator(false)
                if let _ = response.error {
                    responseData(nil,  response.error as NSError?, "Unable to connect to server, please check your internet connection or try switching your network", 0)
                }else {
                    switch response.result {
                    case .success(_):
                        
                        guard let responseJSON:typeAliasDictionary = response.value as? typeAliasDictionary else {
                            print("Invalid tag information received from the service")
                            responseData(nil, nil, SOMETHING_WRONG, 0)
                            return
                        }
                        
                        self.Message = responseJSON["Message"] as? String
                        let status : Int = responseJSON["Status"] as! Int
                        let aToken : Int = responseJSON["AccessTokenStatus"] as! Int
                        
                        if aToken == 0 {
                            responseData(nil, nil, self.Message, status)
                            return
                        }
                        switch status {
                        case RESPONSE_STATUS.VALID.rawValue :
                            self.resObjects  = responseJSON[RES_data]
                            break
                        case RESPONSE_STATUS.INVALID.rawValue :
                            self.resObjects  = responseJSON[RES_data]
                            break
                        default:
                            break
                        }
                        responseData(self.resObjects, nil, self.Message, status)
                        
                    case .failure(let error):
                        responseData(nil, error as NSError, SOMETHING_WRONG, 0)
                    }
                }
        }
    }
    //MARK:- POST REQUEST
    func postRequest(_ endpointurl:String, parameters:typeAliasDictionary,responseData:@escaping (_ data: Any?, _ error: NSError?, _ message: String?, _ rstatus : Int ) -> Void) {
        
        ShowNetworkIndicator(true)
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        AF.request(endpointurl, method: .post, parameters: parameters)
            .responseJSON { response in
                
                print("--------------******------------")
                print(response )
                print(response.request ?? "")
                print(response.result)
                print("--------------******------------")
                //
                ShowNetworkIndicator(false)
                if let _ = response.error {
                    responseData(nil,  response.error as NSError?, "Unable to connect to server, please check your internet connection or try switching your network", 0)
                }else {
                    switch response.result {
                    case .success(_):
                        if endpointurl.isContainString("getClustersites") {
                            guard let responseJSON:[typeAliasDictionary] = response.value as? [typeAliasDictionary] else {
                                print("Invalid tag information received from the service")
                                responseData(nil, nil, SOMETHING_WRONG, 0)
                                return
                            }
                            self.Message = ""
                            responseData(responseJSON, nil, self.Message, 1)
                        }
                        else {
                            guard let responseJSON:typeAliasDictionary = response.value as? typeAliasDictionary else {
                                responseData(nil, nil, SOMETHING_WRONG, 0)
                                return
                            }
                            self.Message = ""
                            responseData(responseJSON, nil, self.Message, 1)
                        }
                        //                        self.Message = (responseJSON["message"] as! String)
                        
                        //                        let status : Int = Int(responseJSON["status"] as! String)!
                        
                        //                        switch status {
                        //                        case RESPONSE_STATUS.VALID.rawValue :
                        //                            self.resObjects  = responseJSON
                        //                            break
                        //                        case RESPONSE_STATUS.INVALID.rawValue :
                        //                            self.resObjects  = responseJSON
                        //                            break
                        //                        default:
                        //                            break
                        //                        }
                        
                    case .failure(let error):
                        responseData(nil, error as NSError, SOMETHING_WRONG, 0)
                    }
                }
        }
    }
    
    func postRequest1(_ endpointurl:String, parameters:typeAliasDictionary,responseData:@escaping (_ data: Any?, _ error: NSError?, _ message: String?, _ rstatus : Int ) -> Void) {
        
        ShowNetworkIndicator(true)
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        AF.request(endpointurl, method: .post , parameters: parameters)
            .responseJSON { response in
                
                print("--------------**------------")
                print(response )
                print(response.request ?? "")
                print("--------------**------------")
                //
                ShowNetworkIndicator(false)
                if let _ = response.error {
                    responseData(nil,  response.error as NSError?, "Unable to connect to server, please check your internet connection or try switching your network", 0)
                }else {
                    switch response.result {
                    case .success(_):
                        
                        guard let responseJSON:typeAliasDictionary = response.value as? typeAliasDictionary else {
                            responseData(nil, nil, SOMETHING_WRONG, 0)
                            return
                        }
                        
                        self.Message = (responseJSON[RES_message] as! String)
                        let status : String = "\(responseJSON["status"]!)"
                        
                        switch status {
                        case "1" :
                            self.resObjects = responseJSON
                            break
                        case "0" :
                            self.resObjects = responseJSON
                            break
                        default:
                            break
                        }
                        responseData(self.resObjects, nil, self.Message, status == "1" ? 1 : 0)
                        
                    case .failure(let error):
                        responseData(nil, error as NSError, SOMETHING_WRONG, 0)
                    }
                }
        }
    }
    
    func getRequestParam(_ endpointurl:String, parameters:typeAliasDictionary,responseData:@escaping (_ data: Any?, _ error: NSError?, _ message: String?, _ rstatus : Int ) -> Void) {
        
        ShowNetworkIndicator(true)
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        
        var request = URLRequest(url: URL(string: endpointurl)!)
        request.httpMethod = "get"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        }
        catch {}
        AF.request(request).responseString { (response) in
            ShowNetworkIndicator(false)
            print(response )
        }
    }
    
    //MARK:- POST REQUEST FOR REGISTRATION
    func postRequestHandler(_ endpointurl:String, parameters:typeAliasDictionary,responseData:@escaping (_ data: Any?, _ error: NSError?, _ message: String?, _ rstatus : Bool ) -> Void) {
        
        ShowNetworkIndicator(true)
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        AF.request(endpointurl, method: .get , parameters: parameters)
            .responseJSON { response in
                
                //                print("--------------******------------")
                //                print(response )
                //                print(response.request ?? "")
                //                print(response.result.value ?? "")
                print("--------------******------------")
                
                ShowNetworkIndicator(false)
                if let _ = response.error {
                    responseData(nil,  response.error as NSError?, "Unable to connect to server, please check your internet connection or try switching your network", false)
                }else {
                    switch response.result {
                    case .success(_):
                        
                        guard let responseJSON:typeAliasDictionary = (response.value as? typeAliasDictionary) else {
                            responseData(nil, nil, SOMETHING_WRONG, false)
                            return
                        }
                        self.Message = (responseJSON["msg"] as! String)
                        let status : Bool = responseJSON[RES_success] as! Bool
                        switch status {
                        case true:
                            self.resObjects  = responseJSON[RES_data]
                            break
                        case false:
                            self.resObjects  = responseJSON[RES_data]
                            break
                        }
                        responseData(self.resObjects, nil, self.Message, status)
                        
                    case .failure(let error):
                        responseData(nil, error as NSError, SOMETHING_WRONG, false)
                    }
                }
        }
    }
    
    func postRequestHandler1(_ endpointurl:String, parameters:typeAliasDictionary,responseData:@escaping (_ data: Any?, _ error: NSError?, _ message: String?, _ rstatus : Bool ) -> Void) {
        
        ShowNetworkIndicator(true)
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        AF.request(endpointurl, method: .get , parameters: parameters){ $0.timeoutInterval = 1000 }
            .validate()
            .responseJSON { response in
                
                
                ShowNetworkIndicator(false)
                if let _ = response.error {
                    responseData(nil,  response.error as NSError?, "Unable to connect to server, please check your internet connection or try switching your network", false)
                }else {
                    switch response.result {
                    case .success(_):
                        
                        guard let responseJSON:typeAliasDictionary = (response.value as? typeAliasDictionary) else {
                            responseData(nil, nil, SOMETHING_WRONG, false)
                            return
                        }
                        self.Message = (responseJSON[RES_message] as! String)
                        let status : Bool = responseJSON[RES_success] as! Bool
                        switch status {
                        case true:
                            self.resObjects  = responseJSON[RES_data]
                            break
                        case false:
                            self.resObjects  = responseJSON[RES_data]
                            break
                        }
                        responseData(self.resObjects, nil, self.Message, status)
                        
                    case .failure(let error):
                        responseData(nil, error as NSError, SOMETHING_WRONG, false)
                    }
                }
        }
    }
    
    func postMultipartFormData(_ endpointurl:String, parameters:typeAliasDictionary,responseData:@escaping (_ data: Any?, _ error: NSError?, _ message: String?, _ rstatus : Int ) -> Void) {
        
        ShowNetworkIndicator(true)
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        print(parameters)
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value)in parameters {
                var valueStr:String = ""
                if let intVlaue:Int   = value as? Int{
                    valueStr = String(format:"%d",intVlaue)
                }else{
                    valueStr = value as! String
                }
                multipartFormData.append(valueStr.data(using: String.Encoding.utf8)!, withName: key )
            }
            
        }, to: endpointurl)
            
            .responseJSON { response in
                debugPrint(response)
                guard let responseJSON:typeAliasDictionary = response.value as? typeAliasDictionary else {
                    print("Invalid tag information received from the service")
                    responseData(nil, nil, SOMETHING_WRONG, 0)
                    return
                }
                self.Message = ""
                responseData(responseJSON, nil, self.Message, 1)
                
        }
    }
    
    func postUploadImage(endpointurl:String,imageTagName: String, parameters:typeAliasDictionary, imageData:UIImage, responseData:@escaping ( _ responseDict: Any?, _ error: NSError?, _ message: String?, _ rstaus:Int) -> Void)  {
        
        print(parameters)
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value)in parameters{
                if key != imageTagName  {
                    var valueStr:String = ""
                    if let intVlaue:Int = value as? Int{
                        valueStr = String(format:"%d",intVlaue)
                    }else{
                        valueStr = value as! String
                    }
                    multipartFormData.append(valueStr.data(using: String.Encoding.utf8)!, withName: key )
                }
            }
            multipartFormData.append(imageData.jpegData(compressionQuality: 0.5)!, withName: imageTagName, fileName: "\(imageTagName).png", mimeType: "image/png")

//            if filePath.count > 0 {
//                for obj in filePath {
//                    let url : URL = obj
//                    multipartFormData.append(url, withName: imageTagName)
//                }
//            }else{
//                multipartFormData.append("".data(using: String.Encoding.utf8)!, withName: imageTagName)
//            }
        }, to: endpointurl)
            .responseJSON { response in
                debugPrint(response)
                if let JSON:typeAliasDictionary = response.value as? typeAliasDictionary {
                    print("JSON: \(JSON)")
                    if let st = JSON["status"] as? String {
                        responseData(typeAliasDictionary() ,nil, "Success", st == "1" ? 1 : 0)

                    }
                    else if let stBool = JSON["status"] as? Bool {
                        responseData(typeAliasDictionary() ,nil, "Success", stBool ? 1 : 0)

                    }
                    else {
                        responseData(nil, nil, "Something went wrong",0)
                    }
                } else {
                    responseData(nil, nil, "Something went wrong",0)
                }
        }
    }
    
    
    func getHeaders() -> HTTPHeaders {
        var param : HTTPHeaders = [:]
        param = ["Authorization" : String(format: "Bearer %@", getAccessToken())]
        return param
    }
    
 }
