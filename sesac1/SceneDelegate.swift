//
//  SceneDelegate.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/18.
//

import UIKit
import RxSwift
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let repo = Repository()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        
        if UserDefaults.standard.string(forKey: "idToken") == nil {
            
            guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: windowScene)
            
            let nav = OnboardingViewController()

            window?.rootViewController = nav
            window?.makeKeyAndVisible()
            
            guard let _ = (scene as? UIWindowScene) else { return }
            
        } else {
            renewIdtoken {
                
                   
                self.repo.getSignIn { code, error, user in
                        guard let code = code else {
                            
                            return
                        }
                        
                        switch code {
                            
                        case 200:
                            
                            guard let windowScene = (scene as? UIWindowScene) else { return }
                            self.window = UIWindow(windowScene: windowScene)
                            
                            let vc = TabBarViewController()
                            

                            self.window?.rootViewController = vc
                            self.window?.makeKeyAndVisible()
                            
                            guard let _ = (scene as? UIWindowScene) else { return }
                            
                        case 406:
                            
                            guard let windowScene = (scene as? UIWindowScene) else { return }
                            self.window = UIWindow(windowScene: windowScene)
                            
                            let vc = UINavigationController(rootViewController: PhoneAuthViewController())

                            self.window?.rootViewController = vc
                            self.window?.makeKeyAndVisible()
                            
                            guard let _ = (scene as? UIWindowScene) else { return }
                            
                        
                        case 401:
                            UserDefaults.standard.set(Auth.auth().currentUser?.refreshToken, forKey: "idToken")
                            self.repo.getSignIn { code, error, user in
                                guard let code = code else {
                                    return
                                }
                                switch code {
                                case 200:
                                    
                                    guard let windowScene = (scene as? UIWindowScene) else { return }
                                    self.window = UIWindow(windowScene: windowScene)
                                    
                                    let vc = TabBarViewController()

                                    self.window?.rootViewController = vc
                                    self.window?.makeKeyAndVisible()
                                    
                                    guard let _ = (scene as? UIWindowScene) else { return }
                                    
                                case 406:
                                    
                                    guard let windowScene = (scene as? UIWindowScene) else { return }
                                    self.window = UIWindow(windowScene: windowScene)
                                    
                                    let vc = UINavigationController(rootViewController: PhoneAuthViewController())

                                    self.window?.rootViewController = vc
                                    self.window?.makeKeyAndVisible()
                                    
                                    guard let _ = (scene as? UIWindowScene) else { return }
                                    
                                default:
                                    guard let windowScene = (scene as? UIWindowScene) else { return }
                                    self.window = UIWindow(windowScene: windowScene)
                                    
                                    let vc = OnboardingViewController()

                                    self.window?.rootViewController = vc
                                    self.window?.makeKeyAndVisible()
                                    
                                    guard let _ = (scene as? UIWindowScene) else { return }
                                }
                            }
                            
                            
                        default:
                            guard let windowScene = (scene as? UIWindowScene) else { return }
                            self.window = UIWindow(windowScene: windowScene)
                            
                            let vc = OnboardingViewController()

                            self.window?.rootViewController = vc
                            self.window?.makeKeyAndVisible()
                            
                            guard let _ = (scene as? UIWindowScene) else { return }
                        }
                    }
                    
                
            }
        }
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
      
    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
       
    }

    
    func renewIdtoken(completion: @escaping ()-> Void) {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if error != nil {
            // Handle error
            return;
          }
            print("this is idToken = \(String(describing: idToken))")
            UserDefaults.standard.set(idToken, forKey: "idToken")
            completion()
          // Send token to your backend via HTTPS
          // ...
        }
    }
}



