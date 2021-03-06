//
//  SceneDelegate.swift
//  AmzonConstruction
//
//  Created by Jashu Prajapati on 8/13/20.
//  Copyright © 2020 JDC. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging

@available(iOS 13.0, *)
var APP_SCENE_DELEGATE : SceneDelegate!
@available(iOS 13.0, *)
let scene = UIApplication.shared.connectedScenes.first

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    //MARK: VARIABLES
    
    var window: UIWindow?
    var dictUserInfo : typeAliasDictionary = typeAliasDictionary()
    var navigationController: AppNavigationController!
    var loaderView :UIView!
    var imglogoBG :UIView!
    var imglogo:UIImageView!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowscene = (scene as? UIWindowScene) else { return }
        if let sd : SceneDelegate = (scene.delegate as? SceneDelegate) {
            APP_SCENE_DELEGATE  = sd }
        window = UIWindow.init(frame: windowscene.coordinateSpace.bounds)
        window?.windowScene = windowscene
        window?.makeKeyAndVisible()
        
        if GetSetModel.iskeyAlreadyExist(key: UD_KEY_APPUSER_INFO) { self.dictUserInfo = GetSetModel.getObjectFromUserDefaults(UD_KEY_APPUSER_INFO)
            switch APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String {
            case "2":
                //site manager
                let vc = ALSiteManagerVC.init(nibName: "ALSiteManagerVC", bundle: nil)
                vc.intLoginType = Int(APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String)!
                navigationController = AppNavigationController.init(rootViewController: vc)
                self.window?.rootViewController = navigationController
                break
            case "3":
                //contractor
                let vc = ALContractorVC.init(nibName: "ALContractorVC", bundle: nil)
                navigationController = AppNavigationController.init(rootViewController: vc)
                self.window?.rootViewController = navigationController
                break
            case "4":
                //Region manager
                let vc = ALReligionManagerVC.init(nibName: "ALReligionManagerVC", bundle: nil)
                vc.isDirect = true
                vc.arrList = APP_SCENE_DELEGATE.dictUserInfo["site_details"] as! [typeAliasDictionary]
                navigationController = AppNavigationController.init(rootViewController: vc)
                self.window?.rootViewController = navigationController
                break
            case "5":
                //Admin
                let vc = ALPhosterAdminVC.init(nibName: "ALPhosterAdminVC", bundle: nil)
                navigationController = AppNavigationController.init(rootViewController: vc)
                self.window?.rootViewController = navigationController
                break
            default:break
            }
        }
        else {
            self.setLoginVC() }
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func setRootVC() {
        
        
        switch APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String {
        case "2":
            //site manager
            let vc = ALSiteManagerVC.init(nibName: "ALSiteManagerVC", bundle: nil)
            vc.intLoginType = Int(APP_SCENE_DELEGATE.dictUserInfo["user_type"]as! String)!
            navigationController = AppNavigationController.init(rootViewController: vc)
            self.window?.rootViewController = navigationController
            break
        case "3":
            //contractor
            let vc = ALContractorVC.init(nibName: "ALContractorVC", bundle: nil)
            navigationController = AppNavigationController.init(rootViewController: vc)
            self.window?.rootViewController = navigationController
            break
        case "4":
            //Region manager
            let vc = ALReligionManagerVC.init(nibName: "ALReligionManagerVC", bundle: nil)
            vc.isDirect = true
            vc.arrList = APP_SCENE_DELEGATE.dictUserInfo["site_details"] as! [typeAliasDictionary]
            navigationController = AppNavigationController.init(rootViewController: vc)
            self.window?.rootViewController = navigationController
            break
        case "5":
            //Admin
            let vc = ALPhosterAdminVC.init(nibName: "ALPhosterAdminVC", bundle: nil)
            navigationController = AppNavigationController.init(rootViewController: vc)
            self.window?.rootViewController = navigationController
            break
        default:break
        }
    }
    
    //MARK: CUSTOM METHOD
    func setHomeVC(){
        let homeVC = HomeVC.init(nibName: "HomeVC", bundle: nil)
        navigationController = AppNavigationController.init(rootViewController: homeVC)
        self.window?.rootViewController = navigationController
    }
    
    func setLoginVC(){
        let loginVC = LoginVC.init(nibName: "LoginVC", bundle: nil)
        navigationController = AppNavigationController.init(rootViewController: loginVC)
        self.window?.rootViewController = navigationController
    }
    
    func showAppLoader() {
        if loaderView != nil {
            loaderView.removeFromSuperview()
        }
        loaderView = UIView(frame: CGRect(x: 0,y: 0,width: SCREENWIDTH(),height: SCREENHEIGHT()))
        loaderView.backgroundColor = COLOR_CUSTOM(0, 0, 0, 0.3)
        imglogoBG = UIView(frame: CGRect(x: 0,y: 0,width: 75,height: 75))
        imglogoBG.backgroundColor = .white
        imglogoBG.setCornerRadius(radius: 10)
        imglogo = UIImageView(frame: CGRect(x: 0,y: 0,width: 50,height: 50))
        imglogo.image = UIImage.init(systemName: "goforward")
        imglogo.tintColor = COLOUR_DARK_RED
        imglogo.rotate()
        imglogoBG.center = loaderView.center
        imglogo.center = loaderView.center
        imglogo.contentMode = .scaleAspectFit
        loaderView.addSubview(imglogoBG)
        loaderView.addSubview(imglogo)
        self.window?.addSubview(loaderView)
    }
    
    func removeAppLoader() {
        if loaderView != nil {
            loaderView.removeFromSuperview()
        }
    }
    
    //PUSH NOTIFICATION
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
}

