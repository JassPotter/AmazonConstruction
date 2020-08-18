//
//  ServicePrefix.swift
//  Shelvinza
//
//  Created by Setblue on 10/11/16.
//  Copyright © 2016 Setblue. All rights reserved.
//

import Foundation

//***********************REQUEST PARAMETER***************************

//LOGIN
let REQ_email                           = "email"
let REQ_password                        = "password"
let REQ_name                            = "username"
let REQ_profile                         = "profile"
let REQ_current_password                = "current_password"
let REQ_new_password                    = "new_password"        //test_ids
let REQ_user_id                         = "user_id"
let REQ_group_id                        = "group_id"
let REQ_Massege                         = "Massege"
let REQ_reg_id                          = "reg_id"

//UPLOAD FILE
let REQ_image                           = "image"

//GetCategory detail
let REQ_category_id                     = "category_id"

//Add To Cart
let REQ_items_details                   = "items_details"
let REQ_kart_items                      = "kart_items"
let REQ_order_details                   = "order_details"
let REQ_uniq_id                         = "uniq_id"


//***********************RESPONSE PARAMETER***************************
let RES_message                         = "message"
let RES_success                         = "success"
let RES_data                            = "data"

//Home List
let RES_id                              = "id"
let RES_name                            = "name"
let RES_image_url                       = "image_url"
let RES_description                     = "description"
let RES_price                           = "price"
//let RES_

//CategoryDetail
let RES_product_id                      = "product_id"
let RES_product_name                    = "product_name"
let RES_product_price                   = "product_price"
let RES_minimum_order                   = "minimum_order"
let RES_product_description             = "product_description"
let RES_product_items                   = "product_items"
let RES_item_label                      = "item_label"
let RES_item_selection_type             = "item_selection_type"
let RES_items                           = "items"
let RES_item_id                         = "item_id"
let RES_item_name                       = "item_name"
let RES_item_price                      = "item_price"
let RES_label                           = "label"

//FILE LIST
let RES_file_name                       = "file_name"
let RES_image                           = "image"
let RES_Status                          = "Status"

public enum WSRequestType : Int {
    case GetLogin
    case PostDashboard
    case PostRegionDashboard
    case PostClusterSiteList
    case GetClusterList
    case GetSiteList
    case CreateWorkpermit
    case UpdateWorkpermit
    case CreateSubcontractors
    
    case GetHomeCategoryList
    case GetCityList
    case UserRegistration
    case ForgotPassword
    case GetUserReviews
    case UpdateUserdetails
    case GetCategoryDetail
    case GetCart
    case GetCoupons
    case DeleteUserCart
    case GetAddToCart
    case GetPlaceOrder
    case deleteCartitem
    
}


public enum RESPONSE_STATUS : NSInteger {
    case INVALID
    case VALID
    case SUCCESS
}

struct WebServicePrefix {
    
    static func GetWSUrl(_ serviceType :WSRequestType) -> String {
        
        var serviceURl: String?
        switch serviceType {
        case .GetLogin:
            serviceURl = "userLogin"
        case .GetHomeCategoryList:
            serviceURl = "getCategoydetails"
        case .GetCityList:
            serviceURl = "listCities"
        case .UserRegistration:
            serviceURl = "userRegistration"
        case .ForgotPassword:
            serviceURl = "forgotPassword"
        case .GetUserReviews:
            serviceURl = "getUserreviews"
        case .UpdateUserdetails:
            serviceURl = "updateUserdetails"
        case .GetCategoryDetail:
            serviceURl = "getProductlist"
        case .GetCart:
            serviceURl = "getMobilecartdetail"
        case .GetCoupons:
            serviceURl = "getCouponlist"
        case .DeleteUserCart:
            serviceURl = "deleteUsercart"
        case .GetAddToCart:
            serviceURl = "insertCartdetails"
        case .deleteCartitem:
            serviceURl = "deleteCartitem"
        case .GetPlaceOrder:
            serviceURl = "PlaceOrderWebservice.php"
        case .PostDashboard:
            serviceURl = "getPermitdetails"
        case .PostRegionDashboard:
            serviceURl = "getRegionalpermitdetails"
        case .PostClusterSiteList:
            serviceURl = "getClustersites"
        case .GetClusterList:
            serviceURl = "getClusterdetails"
        case .GetSiteList:
            serviceURl = "getSitedetails"
            
        case .CreateWorkpermit:
            serviceURl = "createWorkpermit"
        case .UpdateWorkpermit:
            serviceURl = "updateWorkpermit"
        case .CreateSubcontractors:
            serviceURl = "createSubcontractors"
        }
        return "\(BASE_URL)\(serviceURl!)"
    }
}
