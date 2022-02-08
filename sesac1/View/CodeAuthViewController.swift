//
//  CodeAuthViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/18.
//

import UIKit
import FirebaseAuth

class CodeAuthViewController: UIViewController {
    
    let codeView = CodeAuthView()
    let viewModel = PhoneAuthViewModel()
    let repo = Repository()
    
    
    override func loadView() {
        view = codeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = R.color.white()

        
        codeView.phoneNumberTextField.startButton.addTarget(self, action: #selector(verifyCodeNumber), for: .touchUpInside)
        codeView.phoneNumberTextField.textField.becomeFirstResponder()
        
    
    }
    
    @objc func verifyCodeNumber() {
        
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
            self.repo.requestCodeAuth(code: self.codeView.phoneNumberTextField.textField.text) { error, authresult in
                
                if let authresult = authresult {
                    
                    self.repo.getSignIn { code, error, user in
                        if code == 200 {
                            
                            
                            MyProfileViewModel.shared.userInfo = user
                            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                            windowScene.windows.first?.rootViewController = TabBarViewController()
                            windowScene.windows.first?.makeKeyAndVisible()
                            
                        } else {
                            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                            windowScene.windows.first?.rootViewController = NicknameViewController()
                            windowScene.windows.first?.makeKeyAndVisible()
                        }
                    }
                   
                }
                
                
                
            }
        }
        
       
    }

}
