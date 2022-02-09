//
//  AppDelegate.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/18.
//

import UIKit
import FirebaseAuth
import FirebaseMessaging
import Firebase
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    
    

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "arrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "arrow")
        UINavigationBar.appearance().tintColor = R.color.black()
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for:UIBarMetrics.default)
        
        UITabBar.appearance().backgroundColor = R.color.white()
        UITabBar.appearance().isTranslucent = false
        
//        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()

        // Override point for customization after application launch.
        
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if error != nil {
            // Handle error
            return;
          }
            print("this is idToken = \(String(describing: idToken))")
            UserDefaults.standard.set(idToken, forKey: "idToken")
          // Send token to your backend via HTTPS
          // ...
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")

          let dataDict: [String: String] = ["token": fcmToken ?? ""]
          NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
          )
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    


}

