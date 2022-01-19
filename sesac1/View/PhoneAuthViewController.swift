//
//  PhoneAuthViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/18.
//

import UIKit
import Rswift
import RxSwift
import AnyFormatKit

class PhoneAuthViewController: UIViewController, UITextFieldDelegate {
    let phoneView = PhoneAuthView()
    
    override func loadView() {
        view = phoneView
        


        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.white()

        
        let gesture = UIGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(gesture)
    

    }

}

