//  GetSetModel.swift
//  CalcVault
//
//  Created by Setblue on 20/07/18.
//  Copyright © 2018 Setblue. All rights reserved.
//

import UIKit

// STATIC KEYS
let UD_KEY_UDID                                 = "UD_Device_Unique_Key"
let UD_KEY_ACCESSTOKEN                          = "Access TokenKey"
let UD_KEY_APPUSER_INFO                         = "KEY_APPUSER_INFO"
let UD_KEY_CART_COUNT                           = "KEY_CART_COUNT"


class GetSetModel: NSObject {

    class func setStringValueToUserDefaults(strValue: String, ForKey: String) {
        UserDefaults.standard.setValue(strValue, forKey:ForKey)
        UserDefaults.standard.synchronize()
    }
    
    class func getStringValueFromUserDefaults(_ ForKey: String) -> String {
        var strValue : String = ""
        if self.iskeyAlreadyExist(key: ForKey) {
            strValue = UserDefaults.standard.value(forKey: ForKey) as! String
        }
        return strValue
    }
    
    class func setIntegerValueToUserDefaults(intValue: Int, ForKey: String) {
        UserDefaults.standard.setValue(intValue, forKey: ForKey)
        UserDefaults.standard.synchronize()
    }
    
    class func getIntegerValueFromUserDefaults(_ forKey: String) -> Int {
        var intValue : Int = 0
        if self.iskeyAlreadyExist(key: forKey) {
            intValue = (UserDefaults.standard.value(forKey: forKey) as! Int) }
        return intValue
    }
    
    class func setDoubleValueToUserDefaults(DoubleValue: Double, ForKey: String) {
        UserDefaults.standard.setValue(DoubleValue, forKey: ForKey)
        UserDefaults.standard.synchronize()
    }
    
    class func getDoubleValueFromUserDefaults(_ forKey: String) -> Double {
        var intValue : Double = 0.0
        if self.iskeyAlreadyExist(key: forKey) {
            intValue = (UserDefaults.standard.value(forKey: forKey) as! Double) }
        return intValue
    }
    
    class func setBoolValueToUserDefaults(boolValue: Bool, ForKey: String) {
        UserDefaults.standard.setValue(boolValue, forKey: ForKey)
        UserDefaults.standard.synchronize()
    }
    
    class func getBooleanValueFromUserDefaults(_ ForKey: String) -> Bool {
        var value : Bool = false
        if self.iskeyAlreadyExist(key: ForKey) {
            value = (UserDefaults.standard.value(forKey: ForKey) as! Bool) }
        return value
    }
    
    class func setObjectToUserDefaults(objValue: typeAliasDictionary, ForKey: String) {
        UserDefaults.standard.set(objValue, forKey: ForKey)
        UserDefaults.standard.synchronize()
    }
    
    class func getObjectFromUserDefaults(_ ForKey: String) -> typeAliasDictionary {
        var dict : typeAliasDictionary = typeAliasDictionary()
        if self.iskeyAlreadyExist(key: ForKey){
            dict = UserDefaults.standard.object(forKey: ForKey) as! typeAliasDictionary
        }
        return dict
    }
    
    class func setCustomObjToUserDefaultsInSystem(CustomeObj: AnyObject, ForKey CustomeObjKey: String) {
        let defaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: CustomeObj)
        defaults.set(encodedData, forKey: CustomeObjKey)
        defaults.synchronize()
        
    }
    class func getCustomObjFromUserDefaultsInSystem_ForKey(CustomeObjKey: String) -> AnyObject {
        let defaults = UserDefaults.standard
        let decoded  = defaults.object(forKey: CustomeObjKey) as! NSData
        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) 
        return decodedTeams as AnyObject
    }

    class func setArrayToUserDefaults(arrayData: [typeAliasDictionary], ForKey: String) {
        UserDefaults.standard.setValue(arrayData, forKey: ForKey)
        UserDefaults.standard.synchronize()
    }
    class func getArrayFromUserDefaults(_ ForKey: String) -> [typeAliasDictionary] {
        var arrValue : [typeAliasDictionary] = [typeAliasDictionary]()
        if self.iskeyAlreadyExist(key: ForKey) {
            arrValue = (UserDefaults.standard.value(forKey: ForKey)) as! [typeAliasDictionary] }
        return arrValue
    }
    class func setNSMutebleArrayToUserDefaults(arrayData: NSMutableArray, ForKey: String) {
        let defaults = UserDefaults.standard
           let encodedData : NSData = NSKeyedArchiver.archivedData(withRootObject: arrayData) as NSData
            defaults.set(arrayData, forKey: ForKey)
            defaults.synchronize()
     
    }
    class func getNSMutebleArrayFromUserDefaults(_ ForKey: String) -> NSMutableArray {
        let arrValue : NSMutableArray = NSMutableArray()
        if self.iskeyAlreadyExist(key: ForKey) {
            let defaults = UserDefaults.standard
            let decoded  = defaults.object(forKey: ForKey) as! NSData
           let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)! as AnyObject
            return decodedTeams as! NSMutableArray
        }
        return arrValue
    }
    class func setArrayObjToUserDefaults(arrayData: AnyObject, ForKey: String) {
        let defaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: arrayData)
        defaults.set(encodedData, forKey: ForKey)
        defaults.synchronize()

    }
    class func getArrayObjFromUserDefaults(_ ForKey: String) -> AnyObject {
      if self.iskeyAlreadyExist(key: ForKey) {
        let defaults = UserDefaults.standard
        let decoded  = defaults.object(forKey: ForKey) as! NSData
        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)! as AnyObject
        return decodedTeams
        }
        return [typeAliasDictionary]() as AnyObject 
    }
    class func setArrayToUserDefaults(arrayData: [String], ForKey: String) {
        UserDefaults.standard.setValue(arrayData, forKey: ForKey)
        UserDefaults.standard.synchronize()
    }
    class func getStringArrayFromUserDefaults(_ ForKey: String) -> [String] {
        var arrValue : [String] = [""]
        if self.iskeyAlreadyExist(key: ForKey) {
            arrValue = (UserDefaults.standard.value(forKey: ForKey)) as! [String] }
        return arrValue
    }
    class func removeObjectForKey(objectKey: String) {
        UserDefaults.standard.removeObject(forKey: objectKey)
        UserDefaults.standard.setValue(nil, forKey: objectKey)
        UserDefaults.standard.synchronize()
    }
    
    class func removeAllKeyFromDefault(){
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        if let bundle = Bundle.main.bundleIdentifier { UserDefaults.standard.removePersistentDomain(forName: bundle) }
        UserDefaults.standard.synchronize()
    }
    
    class func iskeyAlreadyExist(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
