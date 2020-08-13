//
//  Constants.swift
//
//  Created by Devang Tandel on 22/03/17.
//  Copyright © 2017 Setblue. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import SystemConfiguration
import FCAlertView
import AVFoundation

//MARK:- Application related variables

@available(iOS 13.0, *)
let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
public let APP_NAME  = "Fitness Food Factory"
public let APP_VERSION : String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
public let KEYCHAIN_KEY                         = ""
public let APP_SHARE_LINK                       = "https://itunes.apple.com/us/app/fitness-food/id1511733245?ls=1&mt=8"
public let APP_STOREID: String                  = "1511733245"

//MARK: BASE_URL
//let BASE_URL = "http://79.170.40.161/takeawayzapp.co.uk/Fitnessfood/Webservice/RestController.php?action="
//let BASE_URL_PLACE_ORDER = "http://79.170.40.161/takeawayzapp.co.uk/Fitnessfood/Webservice/"

let BASE_URL = "https://thefitnessfoodfactory.co.uk/app/Webservice/RestController.php?action="
let BASE_URL_PLACE_ORDER = "https://thefitnessfoodfactory.co.uk/app/Webservice/"
//https://thefitnessfoodfactory.co.uk/app/Webservice.

let SELECTION_SUPER_VIEW_TAG                    = 10001
let SCROLLVIEW_FIX_HEIGHT                       = 550
let SCROLLVIEW_EDIT_HEIGHT                      = 400
let VIEW_RECORDING_EDIT_HEIGHT                  = 150

public var DEVICE_ID:String                     = ""
public var CURRENCY_ICON                        = "£"

struct App_Constant {
    
    struct Square {
        static let SQUARE_LOCATION_ID: String = "<# REPLACE_ME #>"
        static let CHARGE_URL: String = "https://" + "\(CHARGE_SERVER_HOST)/"
        // sendbox
//        static let APPLICATION_ID: String  = "sandbox-sq0idb-9cTxzQkeMZxFMSilMXP-tg"
//        static let CHARGE_SERVER_HOST: String = "connect.squareupsandbox.com/v2/payments"
//        static let CHARGE_TOKEN: String = "Bearer EAAAECs4sOW_fvbAYDyqbU2xD2b-01rwqQ-gml2fIkN8mK9y-Kk8EFFcf3f8L_vH"
        
        //Live
        static let APPLICATION_ID: String  = "sq0idp-I2eSPEx67hpR55w-e7ATwA"
        static let CHARGE_SERVER_HOST: String = "connect.squareup.com/v2/payments"
        static let CHARGE_TOKEN: String = "Bearer EAAAEARzfkhuWaa9npoP5hP_mGJT8Iogv_j8UUPVA8iTOZz8BBE-5437oysylVM5"
        
    }
    struct ApplePay {
        static let MERCHANT_IDENTIFIER: String = "REPLACE_ME"
        static let COUNTRY_CODE: String = "US"
        static let CURRENCY_CODE: String = "USD"
    }
}

func isUserLoggedIn() -> Bool {
    let userInfo = GetSetModel.getObjectFromUserDefaults(UD_KEY_APPUSER_INFO)
    return !userInfo.isEmpty
}

//MARK: - IS SIMULATOR
public let isSimulator: Bool = {
    var isSim = false
    #if arch(i386) || arch(x86_64)
        isSim = true
    #endif
    return isSim
}()

func isPhoneNotched() -> Bool {
    if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return false
        //            print("iPhone 5 or 5S or 5C")
        case 1334:
            //            print("iPhone 6/6S/7/8")
            return false
        case 1920, 2208:
            //            print("iPhone 6+/6S+/7+/8+")
            return false
        case 2436:
            //            print("iPhone X, Xs")
            return true
        case 2688:
            //            print("iPhone Xs Max")
            return true
        case 1792:
            return true
        //            print("iPhone Xr")
        default:
            return false
            //            print("unknown")
        }
    }
    return false
}
//MARK: - iOS version checking Functions
public func IOS_VERSION() -> String {
    return UIDevice.current.systemVersion
}

public func IOS_EQUAL_TO(_ xx: Float) -> Bool {
    return IOS_VERSION().compare(String(xx), options: .numeric) == .orderedSame
}

//MARK: - GET FULL SCREEN SIZE
public func fixedScreenSize() -> CGSize {
    
    let screenSize = UIScreen.main.bounds.size
    if NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1 && (UIInterfaceOrientation(rawValue: UIApplication.shared.statusBarOrientation.rawValue) != nil) {
        return CGSize(width: screenSize.width, height: screenSize.height)
    }
    return screenSize
}

public func SCREENWIDTH() -> CGFloat{
    return fixedScreenSize().width
}

public func SCREENHEIGHT() -> CGFloat{
    return fixedScreenSize().height
}

//MARK: - NETWORK INDICATOR

public func ShowNetworkIndicator(_ xx :Bool){
    runOnMainThread {
         UIApplication.shared.isNetworkActivityIndicatorVisible = xx
    }
}

//MARK: APP ENUM
public enum Unit: Int {
    case inch = 0, centimeter, meter
    
    func convertTo(unit to: Unit, value val: Double) -> Double? {
        return nil;
    }
}

public enum CHAT_MSG_TYPE: Int {
    case NORMAL
    case TODO
    case QUOTE
    case FILE
}

public enum POPOVER_ANIMATION: Int {
    case popover_ANIMATION_CROSS_DISSOLVE
    case popover_ANIMATION_RIGHT_TO_LEFT
    case popover_ANIMATION_BOTTOM_TO_TOP
    case popover_ANIMATION_FADE_IN_OUT
    case popover_ANIMATION_BLUR
}


public enum MEDIA_PAGE_TYPE: Int {
    case IMAGE
    case VIDEO
    case CAMERA
}

public enum LIST_PAGE_TYPE: String {
    case ListOfSet
    case ListOfTest
    case ListOfSection
    case ListOfQuestion
}

public enum SIDEMENU_TYPE: Int {
    case HOME
    case INTRO_TO_IELTS_SPEAKING
    case HOW_TO_PREPARE
    case HELPFUL_TIPS
    case SPEAKING_TEST_SECTIONS
    case SPEAKING_PRACTICE_TESTS
    case TUTOR_FEEDBACK
    case PURCHESE_HISTORY
    case LOGOUT
}
public enum SELECTION_ANIMATION: Int {
    case DUMMY
    case CROSS_DISSOLVE
    case RIGHT_TO_LEFT
    case FADE_IN_OUT
    case BOTTOM_TO_TOP
    case BLUR
}
public enum SELECTION_TYPE: Int {
    case DUMMY
    case SINGLE
    case MULTIPLE
}

public enum FCALERT_TYPE: Int {
    case UPDATE_PASSCODE
    case UPDATE_QUESTION
    case MOVE_TO_PHONE
    case DUMMY
}
public enum INPUT_DAYS: Int {
    case DAY
    case WEEK
    case MONTH
    case MONDAY
    case TUESDAY
    case WEDNESDAY
    case THRUSDAY
    case FRIDAY
    case SATURDAY
    case SUNDAY
    
}

public enum JD_DateFormat: Int {
    case DDMMYYYY
    case DDMMMYYYY
    case MMDDYYYY
    case YYYYMMDD
    case HHMMAA
    case DDMMYYYY_HH_MM
    case YYYYMMDD_HH_MM
}

public enum JD_TimeFormat: Int {
    case HHMMA
    case HHMM
    case HHMMSS
}

public enum JD_PickerFormat: Int {
    case Picker_Date
    case Picker_DateAndTime
    case Picker_Time
}

public enum DATE_TYPE:Int {
    case DUMMY
    case DATE_TO
    case DATE_FROM
}
public enum TIME_TYPE:Int {
    case DUMMY
    case DATE_TO
    case DATE_FROM
}



public enum AttachmentType: String{
    case camera, videoCamera, video, photoLibrary
}

/**
 Get image from image name
 */
//MARK: - Get image from image name
public func Set_Local_Image(_ imageName :String) -> UIImage{
    return UIImage(named:imageName)!
}

/**
 Log trace
 */
//MARK: - Log trace

public func DLog<T>(_ message:T,  file: String = #file, function: String = #function, lineNumber: Int = #line ) {
    #if DEBUG
        if let text = message as? String {
            print("\((file as NSString).lastPathComponent) -> \(function) line: \(lineNumber): \(text)")
        }
    #endif
}


/**
 Check string is available or not
 */
//MARK: - Check string is available or not
public func isLike(_ source: String , compare: String) ->Bool{
    var exists = true
    ((source).lowercased().range(of: (compare as String))  != nil) ? (exists = true) : (exists = false)
    return exists
}


/**
 Get current time stamp
 */
//MARK: - Get current time stamp
public var CurrentTimeStamp: String {
    return "\(Date().timeIntervalSince1970 * 1000)"
}

struct Constants {
    //MARK: - Constants
        static let actionFileTypeHeading = "Add a File"
        static let actionFileTypeDescription = "Choose a filetype to add..."
        static let camera = "Camera"
        static let phoneLibrary = "Phone Library"
        static let video = "Video"
        static let file = "File"
        static let alertForPhotoLibraryMessage = "App does not have access to your photos. To enable access, tap settings and turn on Photo Library Access."
        static let alertForCameraAccessMessage = "App does not have access to your camera. To enable access, tap settings and turn on Camera."
        static let alertForVideoLibraryMessage = "App does not have access to your video. To enable access, tap settings and turn on Video Library Access."
        static let settingsBtnTitle = "Settings"
        static let cancelBtnTitle = "Cancel"
    
    enum CurrentDevice : Int {
        case phone // iPhone and iPod touch style UI
        case pad // iPad style UI
    }
    
    struct MixpanelConstants {
        static let activeScreen = "Active Screen";
    }
    
    struct CrashlyticsConstants {
        static let userType = "User Type";
    }
}


//MARK: NULL to NIL
//Convert Null Value to nil
public func NULL_TO_NIL(_ value : AnyObject?) -> AnyObject? {
    if value is NSNull || value == nil {
        return "" as AnyObject?
    } else {
        return value
    }
}
func removeNullFromDictionary(_ dictParam: typeAliasDictionary) -> typeAliasDictionary {
    var dictionaryNew: typeAliasDictionary = dictParam
    for pKey in dictionaryNew.keys {
        if dictionaryNew[pKey] is [typeAliasDictionary] {
            var array: [typeAliasDictionary] = dictionaryNew[pKey] as! [typeAliasDictionary]
            for i in 0..<array.count {
                let dictArray: typeAliasDictionary = array[i]
                var dict: typeAliasDictionary = dictArray
                dict = removeNullFromDictionary(dict)
                array[i] = dict
            }
            dictionaryNew[pKey] = array as AnyObject?
        }
        if dictionaryNew[pKey] is typeAliasDictionary {
            var dict: typeAliasDictionary = dictionaryNew[pKey] as! typeAliasDictionary
            dict = removeNullFromDictionary(dict)
            dictionaryNew[pKey] = dict as AnyObject?
        }
        if dictionaryNew[pKey] is NSNull {
            dictionaryNew[pKey] = "" as AnyObject?
        }
    }
    return dictionaryNew
}
//MARK:- RANDOM STRING GENERATOR
//Generate random string with specified length
func randomString(length: Int) -> String {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    
    var randomString = ""
    
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    
    return randomString
}

//MARK : - CHECK INTERNET CONNECTION
func isConnectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}

//MARK: - ISIPAD
func isiPad()->Bool{
    return UIDevice.current.userInterfaceIdiom == .pad ? true :  false
}
func isIphoneX() -> Bool {
    if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436{
     return true
    }
    return false
}
func isIphoneX_XS_XSMAX_XR() -> Bool {
    if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 1792 {
        return true
    }
    return false
}
//MARK: - GET UDID
func getUDID() -> String {
    
    var UDID = ""
    if GetSetModel.iskeyAlreadyExist(key: UD_KEY_UDID){
        UDID = GetSetModel.getStringValueFromUserDefaults(UD_KEY_UDID)
    }else{
        let theUUID : CFUUID = CFUUIDCreate(nil);
        let string : CFString = CFUUIDCreateString(nil, theUUID);
        UDID =  string as String
        GetSetModel.setStringValueToUserDefaults(strValue: UDID, ForKey: UD_KEY_UDID)
    }
    return UDID
}

//MARK: - GET UDID
func getAccessToken() -> String {
    
    var accessToken = ""
    if GetSetModel.iskeyAlreadyExist(key: UD_KEY_ACCESSTOKEN){
        accessToken = GetSetModel.getStringValueFromUserDefaults(UD_KEY_ACCESSTOKEN)
    }
    return accessToken
}

//MARK: - GET UNIQUE ID FOR DEVICE
func getUniqueID() -> String{
    
//    let keychain = KeychainSwift()
//    if let receivedData = keychain.get(KEYCHAIN_KEY) {
//        return receivedData
//    }else{
//        let strId: String = CFUUIDCreateString(nil, CFUUIDCreate(nil)) as String
//        keychain.set(strId, forKey: KEYCHAIN_KEY)
//        return strId
//    }
    return ""
}

//MARK: - FONT FUNCTION
public func printFonts(){
    
    for family in UIFont.familyNames {
        print(family)
        for name in UIFont.fontNames(forFamilyName: family) {
            print(" \(family) :  \(name)")
        }
    }
}
public func FONT_HEADER_REGULAR(_ size: CGFloat) -> UIFont {
    return UIFont(name: "TrebuchetMS-Bold", size: size)!
}
public func FONT_REGULAR(_ size: CGFloat) -> UIFont {
    return UIFont(name: "TrebuchetMS", size: size)!
}

//MARK: - THREAD FUNCTION
/**
 Runs a block On Main Thread
 */
public func runOnMainThread(block: @escaping () -> ()) {
    DispatchQueue.main.async { block() }
}

/**
 Runs a block in background
 */
public func runInBackground(block: @escaping () -> ()) {
    DispatchQueue.global(qos: .background).async { block() }
}

public func runAfterTime(time: Double ,block : @escaping() -> ()){
    DispatchQueue.main.asyncAfter(deadline: .now() + time) { block() }
}
public func secondsToHoursMinutesSeconds (seconds : Int) -> [Int] {
    let arr : [Int] = [seconds / 3600,(seconds % 3600) / 60,(seconds % 3600) % 60]
    return arr
}

public func hideKeyboard(){
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
}


//MARK: - SHOW ALERT
func showAlertWithTitleWithMessage(message:String)  {
    let alert : FCAlertView = FCAlertView()
    alert.avoidCustomImageTint =  true
    alert.detachButtons = true
    alert.colorScheme = COLOUR_LIGHT_RED
    alert.showAlert(in: APP_SCENE_DELEGATE.window, withTitle: APP_NAME, withSubtitle: message, withCustomImage: nil   , withDoneButtonTitle: "Ok", andButtons: nil)
}
func showAlertWithMessageAndButtons(message:String, alert : FCAlertView,buttons : [String],withDoneTitle : String)  {
    alert.avoidCustomImageTint =  true
    alert.detachButtons = true
    alert.colorScheme = COLOUR_LIGHT_RED
    alert.showAlert(in: APP_SCENE_DELEGATE.window, withTitle: APP_NAME, withSubtitle: message, withCustomImage: nil, withDoneButtonTitle: withDoneTitle, andButtons: buttons)
}

func showAlertWithTitleWithMessageAndButtons(message:String, alert : FCAlertView,buttons : [String],withDoneTitle : String,alertTitle : String)  {
    alert.avoidCustomImageTint =  true
    alert.detachButtons = true
    alert.colorScheme = COLOUR_LIGHT_RED
    alert.showAlert(in: APP_SCENE_DELEGATE.window, withTitle: alertTitle, withSubtitle: message, withCustomImage: nil, withDoneButtonTitle: withDoneTitle, andButtons: buttons)
}

func showAlertWithTitleWithMessageAndButtonWithImage(message:String, alert : FCAlertView,withCustomImage: UIImage,buttons : [String],withDoneTitle : String,alertTitle: String)  {
    alert.avoidCustomImageTint = true
    alert.detachButtons = true
    alert.colorScheme = COLOUR_LIGHT_RED
    alert.showAlert(in: APP_SCENE_DELEGATE.window, withTitle: alertTitle, withSubtitle: message, withCustomImage: withCustomImage, withDoneButtonTitle: withDoneTitle, andButtons: nil)
}
func showAlertWithTitleWithMessageAndButtonsWithImage(message:String, alert : FCAlertView,withCustomImage: UIImage,buttons : [String],withDoneTitle : String)  {
    alert.avoidCustomImageTint =  true
    alert.detachButtons = true
    alert.colorScheme = COLOUR_LIGHT_RED
    alert.showAlert(in: APP_SCENE_DELEGATE.window, withTitle: APP_NAME, withSubtitle: message, withCustomImage: withCustomImage, withDoneButtonTitle: withDoneTitle, andButtons: buttons)
}

func showAlertWithTitleWithMessageAndSingleButton(message:String, alert : FCAlertView,withCustomImage: UIImage,buttons : [String],withDoneTitle : String,alertTitle : String)  {
    alert.avoidCustomImageTint =  true
    alert.detachButtons = true
    alert.colorScheme = COLOUR_LIGHT_RED
    alert.showAlert(in: APP_SCENE_DELEGATE.window, withTitle: alertTitle, withSubtitle: message, withCustomImage: withCustomImage, withDoneButtonTitle: withDoneTitle, andButtons: nil)
}
func showNoInternetAlert()  {
    let alert : FCAlertView = FCAlertView()
    alert.detachButtons = true
    alert.colorScheme = COLOUR_LIGHT_RED
    alert.showAlert(in: APP_SCENE_DELEGATE.window, withTitle: APP_NAME, withSubtitle: "No internet connection available. Please try again!", withCustomImage: nil , withDoneButtonTitle: "Dismiss", andButtons: nil)
}


func getDirectoryPath() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory
}
func getDocumentDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

func getThumbnailFrom(path: URL) -> UIImage? {
    do {
        let asset = AVURLAsset(url: path , options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        imgGenerator.appliesPreferredTrackTransform = true
        let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
        let thumbnail = UIImage(cgImage: cgImage)
        return thumbnail
    } catch let error {
        print("*** Error generating thumbnail: \(error.localizedDescription)")
        return nil
    }
}

func getListFromDirectory(_ folderPath : String) -> [String]  {
    let fm = FileManager.default
    do {
        if fm.fileExists(atPath: folderPath) {
            let items = try fm.contentsOfDirectory(atPath: folderPath)
            var arrStr = [String]()
            for item in items {
//                print("Found \(item)")
                if item != ".DS_Store" { arrStr.append(item) }
            }
            return arrStr
        }
    }
    catch { }
    return [String]()
}

func showNoInternetMAlert()  {
    
    let alert : FCAlertView = FCAlertView()
    alert.avoidCustomImageTint =  true
    alert.titleColor = APP_THEME_COLOR
    alert.firstButtonTitleColor = UIColor.red
    alert.firstButtonTitleColor = UIColor.white
//    alert.cornerRadius = 8
    alert.showAlert(in: APP_DELEGATE.window, withTitle: APP_NAME, withSubtitle: "No internet connection available. Please try again!", withCustomImage: nil , withDoneButtonTitle: "Dismiss", andButtons: nil)
}

func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String {
    let calendar = NSCalendar.current
    let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
    let now = Date()
    let earliest = now < date ? now : date
    let latest = (earliest == now) ? date : now
    let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
    
    if (components.year! >= 2) {
        return "\(components.year!) years ago"
    } else if (components.year! >= 1){
        if (numericDates){
            return "1 year ago"
        } else {
            return "Last year"
        }
    } else if (components.month! >= 2) {
        return "\(components.month!) months ago"
    } else if (components.month! >= 1){
        if (numericDates){
            return "1 month ago"
        } else {
            return "Last month"
        }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!) weeks ago"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){
            return "1 week ago"
        } else {
            return "Last week"
        }
    } else if (components.day! >= 2) {
        return "\(components.day!) days ago"
    } else if (components.day! >= 1){
        if (numericDates){
            return "1 day ago"
        } else {
            return "Yesterday"
        }
    } else if (components.hour! >= 2) {
        return "\(components.hour!) hours ago"
    } else if (components.hour! >= 1){
        if (numericDates){
            return "1 hour ago"
        } else {
            return "An hour ago"
        }
    } else if (components.minute! >= 2) {
        return "\(components.minute!) minutes ago"
    } else if (components.minute! >= 1){
        if (numericDates){
            return "1 minute ago"
        } else {
            return "A minute ago"
        }
    } else if (components.second! >= 3) {
        return "\(components.second!) seconds ago"
    } else {
        return "Just now"
    }
}


