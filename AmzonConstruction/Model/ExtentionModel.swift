//
//  ExtentionModel.swift
//  CalcVault
//
//  Created by Setblue on 20/07/18.
//  Copyright © 2018 Setblue. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.autocapitalizationType = UITextAutocapitalizationType.sentences;
        self.autocorrectionType = UITextAutocorrectionType.no;
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.rightViewMode = UITextField.ViewMode.always;
        self.rightView = view;
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(UITextField.viewClick))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true
        
        let toolbar = UIToolbar.init()
        toolbar.sizeToFit()
        
        let barFlexible = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        if self.tag == 123456 {
            let barBtnDone = UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(btnBarDoneAction))
            barBtnDone.tintColor = UIColor.black
            toolbar.barTintColor = UIColor.lightGray
            toolbar.tintColor = COLOR_RED
            toolbar.items = [barFlexible,barBtnDone]
            toolbar.alpha = 0.8
        }
        else {
            let barBtnDone = UIBarButtonItem.init(image: #imageLiteral(resourceName: "icon_Hide_Keyboard"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(btnBarDoneAction))
            barBtnDone.tintColor = UIColor.black
            toolbar.barTintColor = UIColor.lightGray
            toolbar.tintColor = COLOR_RED
            toolbar.items = [barFlexible,barBtnDone]
            toolbar.alpha = 0.8
        }
        self.inputAccessoryView = toolbar
        
        if self.keyboardType == UIKeyboardType.default {
        }
    }
    
    @objc func viewClick() {
        self.becomeFirstResponder();
    }
    @objc func btnBarDoneAction(){
        self.resignFirstResponder()
    }
}
extension UITableView {
    func reloadDataFully(completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
            { _ in completion() }
    }
}

extension UITextView
{
    open override func awakeFromNib() {
        self.autocapitalizationType = UITextAutocapitalizationType.sentences;
        self.autocorrectionType = UITextAutocorrectionType.no;
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(UITextView.viewClick))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true
        
        let toolbar = UIToolbar.init()
        toolbar.sizeToFit()
        let barFlexible = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let barBtnDone = UIBarButtonItem.init(image: #imageLiteral(resourceName: "icon_Hide_Keyboard"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(btnBarDoneAction))
        barBtnDone.tintColor = UIColor.black
        toolbar.barTintColor = UIColor.lightGray
        toolbar.tintColor = COLOR_RED
        toolbar.items = [barFlexible,barBtnDone]
        toolbar.alpha = 0.9
        self.inputAccessoryView = toolbar
    }
    
    @objc func viewClick() { self.becomeFirstResponder(); }
    @objc func btnBarDoneAction() { self.resignFirstResponder() }
    
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    func offsetLong(from date: Date) -> String {
        if years(from: date)   > 0 { return years(from: date) > 1 ? "\(years(from: date)) years ago" : "\(years(from: date)) year ago" }
        if months(from: date)  > 0 { return months(from: date) > 1 ? "\(months(from: date)) months ago" : "\(months(from: date)) month ago" }
        if weeks(from: date)   > 0 { return weeks(from: date) > 1 ? "\(weeks(from: date)) weeks ago" : "\(weeks(from: date)) week ago"   }
        if days(from: date)    > 0 { return days(from: date) > 1 ? "\(days(from: date)) days ago" : "\(days(from: date)) day ago" }
        if hours(from: date)   > 0 { return hours(from: date) > 1 ? "\(hours(from: date)) hours ago" : "\(hours(from: date)) hour ago"   }
        if minutes(from: date) > 0 { return minutes(from: date) > 1 ? "\(minutes(from: date)) minutes ago" : "\(minutes(from: date)) minute ago" }
        if seconds(from: date) > 0 { return seconds(from: date) > 1 ? "\(seconds(from: date)) seconds ago" : "\(seconds(from: date)) second ago" }
        return ""
    }
}

extension UIImage
{
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func convertImageToBase64() -> String {
        let imageData = self.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
extension UILabel{
    func calculatedHeight() -> CGFloat {
        let text: String = self.text!
        return text.heightForWidth(width: self.frame.size.width, font: self.font)
    }
    func calculatedWidth() -> CGFloat {
        let text: String = self.text!
        return text.widthForHeight(height: self.frame.size.height, font: self.font)
    }
}
extension StringProtocol {
    var ascii: [UInt32] {
        return unicodeScalars.compactMap { $0.isASCII ? $0.value : nil }
    }
}
extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
extension Double {
    var twoPointRounded:String {
        return String(format: "%.1f", self)
    }
    
    var twoPointsRounded:String {
        return String(format: "%.2f", self)
    }
    
    var threePointRounded:String {
        return String(format: "%.3f", self)
    }
    var onePointRounded:String {
        return String(format: "%.0f", self)
    }
    func roundedTo(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension String {
    
    func validateMobileNo() -> Bool {
        do {
            let pattern: String = "^[789]\\d{9}$"
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = self as NSString
            let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
            return results.count > 0 ? true : false
            
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
    }
   
    func validateEmail() -> Bool {
        do {
            let pattern: String = "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?"
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = self as NSString
            let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
            return results.count > 0 ? true : false
            
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    func validatePassword() -> Bool {
        return self.count >= 6 && self.count <= 32 ? true : false
    }
    
    func removeThousandSeperator()->String{
        let decimal = self.components(separatedBy: ".")
        let intString = decimal[0].components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        let Price = intString + "." + decimal[1]
        return Price
    }
    
    func isContainString(subString: String) -> Bool {
        return (self as NSString).range(of: subString).location != NSNotFound ? true : false
    }
    
    func setThousandSeperator()->String { return  self.setThousandSeperator(self, decimal: 2) }
    //46.7
    func setThousandSeperator(_ string:String , decimal:Int)->String {
        let numberFormatter = NumberFormatter.init()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.decimalSeparator = "."
        numberFormatter.maximumFractionDigits = decimal
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.currencySymbol = ""
        numberFormatter.usesGroupingSeparator = true
        return numberFormatter.string(from: NSNumber.init(value: Double(string)! as Double))!
    }
    
    func setDecimalPoint()->String {
        let numberFormatter:NumberFormatter = NumberFormatter.init()
        numberFormatter.decimalSeparator = "."
        numberFormatter.maximumFractionDigits = 2
        return  numberFormatter.string(from: NSNumber.init(value: Double(self)! as Double))!
    }
    
    
    mutating func replace(_ string: String, withString: String) -> String {
        return self.replacingOccurrences(of: string, with: withString)
    }
    
    mutating func encode() -> String {
        let customAllowedSet =  CharacterSet(charactersIn:" !+=\"#%/<>?@\\^`{|}$&()*-").inverted
        self = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)!
        return self
    }
   
    mutating func replaceWhiteSpace(_ withString: String) -> String {
        let components = self.components(separatedBy: CharacterSet.whitespaces)
        let filtered = components.filter({!$0.isEmpty})
        return filtered.joined(separator: "")
    }
    func textWidth(_ textHeight: CGFloat, textFont: UIFont) -> CGFloat {
        let textRect: CGRect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: textHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil)
        let textSize: CGSize = textRect.size
        return ceil(textSize.width)
    }
    
    func textHeight(_ textWidth: CGFloat, textFont: UIFont) -> CGFloat {
        let textRect: CGRect = self.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil)
        let textSize: CGSize = textRect.size
        return ceil(textSize.height)
    }
    
    func textSize(_ textFont: UIFont) -> CGSize {
        let textRect: CGRect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil)
        return textRect.size;
    }
    func trim() -> String { return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
    
    func leftPadding(toLength: Int, withPad: String = " ") -> Int {
        guard toLength > self.count else { return Int(self)! }
        let padding = String(repeating: withPad, count: toLength - self.count)
        return Int(padding + self)!
    }
    
    func containsEmoji() -> Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F:   // Variation Selectors
                return true
            default:
                continue
            }
        }
        return false
    }
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    func convertToAttributedString() -> NSAttributedString? {
        let modifiedFontString = "<span style=\"font-family: Poppins-Regular; font-size: 15 \">" + self + "</span>"
        return modifiedFontString.htmlToAttributedString
    }
    
    func convertToUrl() -> URL {
        let data:Data = self.data(using: String.Encoding.utf8)!
        var resultStr: String = String(data: data, encoding: String.Encoding.nonLossyASCII)!
        
        if !(resultStr.hasPrefix("itms://")) && !(resultStr.hasPrefix("file://")) && !(resultStr.hasPrefix("http://")) && !(resultStr.hasPrefix("https://")) { resultStr = "http://" + resultStr }
        
        resultStr = resultStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        return URL(string: resultStr)!
    }
    
    func isNumeric() -> Bool {
        var holder: Float = 0.00
        let scan: Scanner = Scanner(string: self)
        let RET: Bool = scan.scanFloat(&holder) && scan.isAtEnd
        if self == "." { return false }
        return RET
    }
    
    func isContainString(_ subString: String) -> Bool {
        let range = self.range(of: subString, options: NSString.CompareOptions.caseInsensitive, range: self.range(of: self))
        return range == nil ? false : true
    }
    
    func convertToStringDictionary() -> typeAliasStringDictionary {
        let jsonData: Data = self.data(using: String.Encoding.utf8)!
        do {
            let dict: typeAliasStringDictionary = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! typeAliasStringDictionary
            return dict
        } catch let error as NSError { print(error) }
        
        return typeAliasStringDictionary()
    }
    
    func convertToDictionary() -> typeAliasDictionary {
        let jsonData: Data = self.data(using: String.Encoding.utf8)!
        do {
            let dict: typeAliasDictionary = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! typeAliasDictionary
            return dict
        } catch let error as NSError { print(error) }
        
        return typeAliasDictionary()
    }
    
    func convertToArray() -> [typeAliasDictionary] {
        let jsonData: Data = self.data(using: String.Encoding.utf8)!
        do {
            let array: [typeAliasDictionary] = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! [typeAliasDictionary]
            return array
        } catch let error as NSError { print(error) }
        
        return [typeAliasDictionary]()
    }
    
    func base64Encoded() -> String {
        if let data = self.data(using: .utf8) { return data.base64EncodedString() }
        return ""
    }
    
    func base64Decoded() -> String {
        if let data = Data(base64Encoded: self) { return String(data: data, encoding: .utf8)! }
        return ""
    }
    
    func hexToUIColor () -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }
        
        if ((cString.count) != 6) { return UIColor.gray }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func getRediansFromDegrees() -> Double {
        let degree: Double = Double(self)!
        return degree * .pi / 180.0
    }
    
    func extractString(_ checkingType: NSTextCheckingResult.CheckingType) -> [String] {
        var arrText = [String]()
        let detector = try! NSDataDetector(types: checkingType.rawValue)
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
        
        for match in matches {
            let url = (self as NSString).substring(with: match.range)
            arrText.append(url)
        }
        return arrText
    }
    
    func getPhoneNumber() -> [String] { return self.extractString(.phoneNumber) }
    
    func getUrl() -> [String]  { return self.extractString(.link) }
    
    func getAddress() -> [String]  { return self.extractString(.address) }
    
    var getIntergerFromString: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
            .compactMap { pattern ~= $0 ? Character($0) : nil })
    }
    //**//
    public  func localizedStringWithVariables(value: String, vars: CVarArg...) -> String {
        return String(format: NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: value, comment: ""), arguments: vars)
    }
    
    /// Return the float value
    public var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    /**
     Creates a substring with a given range
     */
    
    public func substringWithRange(range: Range<Int>) -> String {
        
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        return String(self[start...end])
        
    }
    
    
    
    /**
     Returns the index of the given character
     */
    public func indexOfCharacter(character: Character) -> Int {
        
        if let index = self.index(of: character) {
            return self.distance(from: self.startIndex, to: index)
        }
        return -1
    }
    
    
    
    /**
     Check if self is an email
     */
    public func isEmail() -> Bool {
        return String.isEmail(email: self)
    }
    
    public func isEmptyString() -> Bool {
        return String.isValid(string: self)
    }
    
    /**
     Encode the given string to Base64
     */
    public func encodeToBase64() -> String {
        return String.encodeToBase64(string: self)
    }
    
    /**
     Decode the given Base64 to string
     */
    public func decodeBase64() -> String {
        return String.decodeBase64(string: self)
    }
    
    /**
     Convert self to a NSData
     */
    public func convertToNSData() -> NSData {
        return self.data(using: String.Encoding.utf8)! as NSData
    }
    
    
    /**
     Returns a new string containing matching regular expressions replaced with the template string
     */
    public func stringByReplacingWithRegex(regexString: NSString, withString replacement: NSString) throws -> NSString {
        let regex: NSRegularExpression = try NSRegularExpression(pattern: regexString as String, options: .caseInsensitive)
        return regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range:NSMakeRange(0, self.count), withTemplate: "") as NSString
    }
    
    /**
     Encode self to an encoded url string
     */
    public func URLEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
    
    /// Returns the last path component
    public var lastPathComponent: String {
        get {
            return (self as NSString).lastPathComponent
        }
    }
    
    /// Returns the path extension
    public var pathExtension: String {
        get {
            return (self as NSString).pathExtension
        }
    }
    
    /// Delete the last path component
    public var stringByDeletingLastPathComponent: String {
        get {
            return (self as NSString).deletingLastPathComponent
        }
    }
    
    /// Delete the path extension
    public var stringByDeletingPathExtension: String {
        get {
            return (self as NSString).deletingPathExtension
        }
    }
    
    /// Returns an array of path components
    public var pathComponents: [String] {
        get {
            return (self as NSString).pathComponents
        }
    }
    
    /**
     Appends a path component to the string
     */
    public func stringByAppendingPathComponent(path: String) -> String {
        let string = self as NSString
        
        return string.appendingPathComponent(path)
    }
    
    /**
     Appends a path extension to the string
     */
    public func stringByAppendingPathExtension(ext: String) -> String? {
        let nsSt = self as NSString
        
        return nsSt.appendingPathExtension(ext)
    }
    
    /// Converts self to a NSString
    public var NS: NSString {
        return (self as NSString)
    }
    
    /**
     Returns if self is a valid UUID or not
     */
    public func isUUID() -> Bool {
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", options: .caseInsensitive)
            let matches: Int = regex.numberOfMatches(in: self as String, options: .reportCompletion, range: NSMakeRange(0, self.count))
            return matches == 1
        } catch {
            return false
        }
    }
    
    /**
     Returns if self is a valid UUID for APNS (Apple Push Notification System) or not
     */
    public func isUUIDForAPNS() -> Bool {
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: "^[0-9a-f]{32}$", options: .caseInsensitive)
            let matches: Int = regex.numberOfMatches(in: self as String, options: .reportCompletion, range: NSMakeRange(0, self.count))
            return matches == 1
        } catch {
            return false
        }
    }
    
    /**
     Converts self to an UUID APNS valid (No "<>" or "-" or spaces)
     */
    public func convertToAPNSUUID() -> NSString {
        return self.trimmingCharacters(in: CharacterSet.init(charactersIn: "<>")).replacingOccurrences(of: " ", with: "").replacingOccurrences(of:"-", with: "") as NSString
    }
    
    /**
     Used to calculate text height for max width and font
     */
    public func heightForWidth(width: CGFloat, font: UIFont) -> CGFloat {
        var size: CGSize = CGSize.zero
        if self.count > 0 {
            let frame: CGRect = self.boundingRect(with: CGSize(width:width, height:999999), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
            size = CGSize(width: frame.size.width, height: frame.size.height + 1)
        }
        return size.height
    }
    public func widthForHeight(height: CGFloat, font: UIFont) -> CGFloat {
        var size: CGSize = CGSize.zero
        if self.count > 0 {
            let frame: CGRect = self.boundingRect(with: CGSize(width:999999, height:height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
            size = CGSize(width: frame.size.width + 1, height: frame.size.height)
        }
        return size.width
    }
    public func getOnlyString() -> String{
        return self.trimmingCharacters(in: CharacterSet.init(charactersIn: " . ,*%#@!$^&()-")).replacingOccurrences(of: " ", with: "").lowercased()
    }
    
    // MARK: - Subscript functions -
    
    /**
     Returns the character at the given index
     */
    public subscript(index: Int) -> Character {
        return self[self.index(after: self.startIndex)]
    }
    
    /**
     Returns the index of the given character, -1 if not found
     */
    public subscript(character: Character) -> Int {
        return self.indexOfCharacter(character: character)
    }
    
    /**
     Returns the character at the given index as String
     */
    public subscript(index: Int) -> String {
        return String(self[index] as Character)
    }
    
    /**
     Returns the string from a given range
     */
    public subscript(range: Range<Int>) -> String {
        return substringWithRange(range: range)
    }
    
    
    /**
     Check if the given string is an email
     */
    public static func isEmail(email: String) -> Bool {
        let emailRegEx: String = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let regExPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return regExPredicate.evaluate(with: email.lowercased())
    }
    
    /**
     Convert a string to UTF8
     
     - parameter string: String to be converted
     
     - returns: Returns the converted string
     */
    public static func convertToUTF8Entities(string: String) -> String {
        return string.replacingOccurrences(of: "%27", with: "'")
            .replacingOccurrences(of: "%e2%80%99".capitalized, with: "’")
            .replacingOccurrences(of: "%2d".capitalized, with: "-")
            .replacingOccurrences(of: "%c2%ab".capitalized, with: "«")
            .replacingOccurrences(of: "%c2%bb".capitalized, with: "»")
            .replacingOccurrences(of: "%c3%80".capitalized, with: "À")
            .replacingOccurrences(of: "%c3%82".capitalized, with: "Â")
            .replacingOccurrences(of: "%c3%84".capitalized, with: "Ä")
            .replacingOccurrences(of: "%c3%86".capitalized, with: "Æ")
            .replacingOccurrences(of: "%c3%87".capitalized, with: "Ç")
            .replacingOccurrences(of: "%c3%88".capitalized, with: "È")
            .replacingOccurrences(of: "%c3%89".capitalized, with: "É")
            .replacingOccurrences(of: "%c3%8a".capitalized, with: "Ê")
            .replacingOccurrences(of: "%c3%8b".capitalized, with: "Ë")
            .replacingOccurrences(of: "%c3%8f".capitalized, with: "Ï")
            .replacingOccurrences(of: "%c3%91".capitalized, with: "Ñ")
            .replacingOccurrences(of: "%c3%94".capitalized, with: "Ô")
            .replacingOccurrences(of: "%c3%96".capitalized, with: "Ö")
            .replacingOccurrences(of: "%c3%9b".capitalized, with: "Û")
            .replacingOccurrences(of: "%c3%9c".capitalized, with: "Ü")
            .replacingOccurrences(of: "%c3%a0".capitalized, with: "à")
            .replacingOccurrences(of: "%c3%a2".capitalized, with: "â")
            .replacingOccurrences(of: "%c3%a4".capitalized, with: "ä")
            .replacingOccurrences(of: "%c3%a6".capitalized, with: "æ")
            .replacingOccurrences(of: "%c3%a7".capitalized, with: "ç")
            .replacingOccurrences(of: "%c3%a8".capitalized, with: "è")
            .replacingOccurrences(of: "%c3%a9".capitalized, with: "é")
            .replacingOccurrences(of: "%c3%af".capitalized, with: "ï")
            .replacingOccurrences(of: "%c3%b4".capitalized, with: "ô")
            .replacingOccurrences(of: "%c3%b6".capitalized, with: "ö")
            .replacingOccurrences(of: "%c3%bb".capitalized, with: "û")
            .replacingOccurrences(of: "%c3%bc".capitalized, with: "ü")
            .replacingOccurrences(of: "%c3%bf".capitalized, with: "ÿ")
            .replacingOccurrences(of: "%20", with: " ")
    }
    
    /**
     Encode the given string to Base64
     
     - parameter string: String to encode
     
     - returns: Returns the encoded string
     */
    public static func encodeToBase64(string: String) -> String {
        let data: NSData = string.data(using: String.Encoding.utf8)! as NSData
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
    /**
     Decode the given Base64 to string
     
     - parameter string: String to decode
     
     - returns: Returns the decoded string
     */
    public static func decodeBase64(string: String) -> String {
        let data: NSData = NSData(base64Encoded: string as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
        return NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    
    public static func isValid (string: String) -> Bool {
        return ((string.removeWhiteSpacesFromString() == "") || string.count == 0 || (string == "(null)") || (string.isEmpty)) ? false : true
    }
    
    func removeWhiteSpacesFromString() -> String {
        let trimmedString: String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
    
    /**
     Remove double or more duplicated spaces
     
     - returns: String without additional spaces
     */
    var removeExcessiveSpaces: String {
        let components = self.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        let filtered = components.filter({!$0.isEmpty})
        return filtered.joined(separator: " ")
    }
    
    /**
     Used to create an UUID as String
     
     - returns: Returns the created UUID string
     */
    public static func generateUUID() -> String {
        let theUUID: CFUUID? = CFUUIDCreate(kCFAllocatorDefault)
        let string: CFString? = CFUUIDCreateString(kCFAllocatorDefault, theUUID)
        return string! as String
    }
    
    public var parseJSONString: AnyObject?
    {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        if let jsonData = data
        {
            // Will return an object or nil if JSON decoding fails
            do
            {
                let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
                if let jsonResult = message as? NSMutableArray
                {
                    return jsonResult //Will return the json array output
                }else{
                    return nil
                }
            }
            catch let error as NSError{
                print(error)
                return nil
            }
        }
        else{ return nil }
    }
    
    var isBlank: Bool {
        get {
            let trimmed =  trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            return trimmed.isEmpty
        }
    }
    
    func errorPlaceHolderString(stringColor:UIColor) -> NSAttributedString{
        let attributesDictionary = [NSAttributedString.Key.foregroundColor: stringColor]
        return NSAttributedString(string: self, attributes: attributesDictionary)
    }
}
extension UINavigationBar
{
    func applyNavigationGradient( colors : [UIColor]) {
        var frameAndStatusBar: CGRect = self.bounds
        frameAndStatusBar.size.height += 20 // add 20 to account for the status bar
        setBackgroundImage(UINavigationBar.gradient(size: frameAndStatusBar.size, colors: colors), for: .default)
    }
    
    static func gradient(size : CGSize, colors : [UIColor]) -> UIImage?
    {
        let cgcolors = colors.map { $0.cgColor }
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        defer { UIGraphicsEndImageContext() }
        var locations : [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }
        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
extension Dictionary {
    func convertToJSonString() -> String {
        do {
            let dataJSon = try JSONSerialization.data(withJSONObject: self as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted)
            let st: NSString = NSString.init(data: dataJSon, encoding: String.Encoding.utf8.rawValue)!
            return st as String
        } catch let error as NSError { print(error) }
        return ""
    }
    
    func isKeyNull(_ stKey: String) -> Bool {
        let dict: typeAliasDictionary = (self as AnyObject) as! typeAliasDictionary
        if let val = dict[stKey] { return val is NSNull ? true : false }
        return true
    }
}

extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.index(string.startIndex, offsetBy: location)
        let endIndex = string.index(startIndex, offsetBy: length)
        return startIndex..<endIndex
    }
}

extension UIButton {
    func setMultiLineText() {
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.textAlignment = NSTextAlignment.center
    }
}

extension UISegmentedControl {
    func setCubberLayout() {
        self.tintColor = COLOR_RED;
        self.subviews[0].tintColor = COLOR_RED
        self.titleForSegment(at: 0)
    }
}

extension UIView {
    
    class func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    func round(corners: UIRectCorner, radius: CGFloat) -> Void {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func setHighlight() {
        self.setViewBorder(COLOR_RED, borderWidth: 2, isShadow: false, cornerRadius: 0, backColor: UIColor.clear)
    }
    
    func unSetHighlight() {
        self.setViewBorder(COLOR_RED, borderWidth: 1, isShadow: false, cornerRadius: 0, backColor: UIColor.clear)
    }
    
    func setBottomBorder(_ borderColor: UIColor, borderWidth: CGFloat) {
        let tagLayer: String = "100000"
        if (self.layer.sublayers?.count)! > 1 && self.layer.sublayers?.last?.accessibilityLabel == tagLayer {
            self.layer.sublayers?.last?.removeFromSuperlayer()
        }
        let border: CALayer = CALayer()
        border.backgroundColor = borderColor.cgColor;
        border.accessibilityLabel = tagLayer;
        border.frame = CGRect(x: 0, y: self.frame.height - borderWidth, width: self.frame.width, height: borderWidth);
        self.layer.addSublayer(border)
    }
    func setTopBorder(_ borderColor: UIColor, borderWidth: CGFloat) {
        let tagLayer: String = "100000"
        if (self.layer.sublayers?.count)! > 1 && self.layer.sublayers?.last?.accessibilityLabel == tagLayer {
            self.layer.sublayers?.last?.removeFromSuperlayer()
        }
        let border: CALayer = CALayer()
        border.backgroundColor = borderColor.cgColor;
        border.accessibilityLabel = tagLayer;
        border.frame = CGRect(x: 0, y: 0, width: (self.superview?.frame.width)!, height: borderWidth);
        self.layer.addSublayer(border)
    }
    func setViewBorder(_ borderColor: UIColor, borderWidth: CGFloat, isShadow: Bool, cornerRadius: CGFloat, backColor: UIColor) {
        self.backgroundColor = backColor;
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor.cgColor;
        self.layer.cornerRadius = cornerRadius;
        if isShadow { self.setShadowDrop(self) }
    }
    
    func setShadowDrop(_ view: UIView) {
        //http://stackoverflow.com/questions/4754392/uiview-with-rounded-corners-and-drop-shadow
        let layer: CALayer = view.layer
        layer.shadowOffset = CGSize(width: 1, height: 1);
        layer.shadowColor = UIColor.black.cgColor;
        layer.shadowRadius = 10;
        layer.shadowOpacity = 0.7;
        //layer.shadowPath = UIBezierPath(roundedRect: layer.bounds);
    }
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func gradient(size : CGSize, colors : [UIColor]) -> UIImage?
    {
        let cgcolors = colors.map { $0.cgColor }
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        defer { UIGraphicsEndImageContext() }
        var locations : [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }
        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            
            return nil
        }
        set {
            if let color = newValue {
                layer.masksToBounds = false
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    //**//
    
    public func createCornerTriangle(isHide : Bool){
        let width = CGFloat( (UIScreen.main.bounds.width/3) -  13)
        let sizeforTriangle : CGFloat = 40.0
        let path = CGMutablePath()
        path.move(to: CGPoint(x:width - sizeforTriangle,y:0))
        path.addLine(to: CGPoint(x:0,y:0))
        path.addLine(to: CGPoint(x:width,y:width))
        path.addLine(to: CGPoint(x:width,y:0))
        path.addLine(to: CGPoint(x:width,y:sizeforTriangle))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = path
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.bounds =  CGRect(x: 0, y: 0, width: sizeforTriangle, height: sizeforTriangle)
        shapeLayer.anchorPoint = CGPoint(x:0.0, y:0.0)
        shapeLayer.position = CGPoint(x:0.0,y:0.0)
        shapeLayer.zPosition = isHide ? -1 :0
        self.layer.addSublayer(shapeLayer)
    }
    
    public func shakeView() {
        let shake: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
        shake.values = [NSValue(caTransform3D: CATransform3DMakeTranslation(-10.0, 0.0, 0.0)), NSValue(caTransform3D: CATransform3DMakeTranslation(10.0, 0.0, 0.0))]
        shake.autoreverses = true
        shake.repeatCount = 3.0
        shake.duration = 0.07
        
        self.layer.add(shake, forKey:"shake")
    }
    public func shakeViewUpDown() {
        let shake: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
        shake.values = [NSValue(caTransform3D: CATransform3DMakeTranslation(0.0, -10.0, 0.0)), NSValue(caTransform3D: CATransform3DMakeTranslation(0.0, 10.0, 0.0))]
        shake.autoreverses = true
        shake.repeatCount = .infinity
        shake.duration = 0.65
        self.layer.add(shake, forKey:"shake")
    }
    
    public func createBordersWithColor(color: UIColor, radius: CGFloat, width: CGFloat) {
        
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
        self.layer.shouldRasterize = false
        self.layer.rasterizationScale = 2
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        let cgColor: CGColor = color.cgColor
        self.layer.borderColor = cgColor
    }
    
    public func removeBorders() {
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 0
        self.layer.borderColor = nil
    }
    
    public func removeShadow() {
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOpacity = 0.0
        self.layer.shadowOffset = CGSize(width:0.0, height:0.0)
    }
    
    public func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    public func createRectShadowWithOffset(offset: CGSize, opacity: Float, radius: CGFloat) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
    public func createRectShadowForView() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = true
    }
    
    
    public func createCornerRadiusWithShadow(shadowColor : UIColor, cornerRadius: CGFloat, offset: CGSize, opacity: Float, radius: CGFloat) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shouldRasterize = true
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.masksToBounds = false
    }
    
    /**
     Make view Blurr
     */
    public func makeBlurView(effectStyle: UIBlurEffect.Style) {
        
        let blurEffect = UIBlurEffect(style: effectStyle) //UIBlurEffectStyle.Light
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

extension URL {
    func getDataFromQueryString() -> typeAliasStringDictionary {
        let urlComponents: URLComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        let arrQueryItems: Array<URLQueryItem> = urlComponents.queryItems!
        var dictParams = typeAliasStringDictionary()
        for item:URLQueryItem in arrQueryItems { dictParams[item.name] = item.value }
        return dictParams
    }
}

