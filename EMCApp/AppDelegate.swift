//
//  AppDelegate.swift
//

import UIKit
import IQKeyboardManagerSwift
//import SVProgressHUD
import EHPlainAlert

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initializeReachability()

        IQKeyboardManager.shared.enable = true
        EHPlainAlert.updateNumber(ofAlerts: 2)
        EHPlainAlert.updateHidingDelay(1)
        EHPlainAlert.update(UIColor.appYellowColor, for: ViewAlertInfo)
        EHPlainAlert.update(UIColor.appRedColor, for: ViewAlertError)
        EHPlainAlert.update(UIColor.appGreenColor, for: ViewAlertSuccess)

        return true
    }
    
    func initializeReachability()
    {
        do {
            Network.reachability = try Reachability(hostname: "www.google.com")
            do {
                try Network.reachability?.start()
            } catch let error as Network.Error {
                print(error)
            } catch {
                print(error)
            }
        }
        catch {
            print(error)
        }
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

