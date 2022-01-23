//
//  CodeAuthViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/18.
//

import UIKit

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

        
        let gesture = UIGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(gesture)
        
        codeView.phoneNumberTextField.startButton.addTarget(self, action: #selector(verifyCodeNumber), for: .touchUpInside)
        
        
    
    }
    
    @objc func verifyCodeNumber() {
        repo.requestCodeAuth(code: codeView.phoneNumberTextField.textField.text) { error, statusCode in
            if error == nil {
                print("----ViewModel----this code is verified")
                self.viewModel.codeAuthorized = true
            } else {
                print("----ViewModel----this code is not verified")
            }
        }
    }

}
