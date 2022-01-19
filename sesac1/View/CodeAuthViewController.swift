//
//  CodeAuthViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/18.
//

import UIKit

class CodeAuthViewController: UIViewController {
    
    let codeView = CodeAuthView()
    
    
    override func loadView() {
        view = codeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = R.color.white()

        
        let gesture = UIGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(gesture)
    
    }
    


}
