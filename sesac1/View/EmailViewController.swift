//
//  EmailViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/23.
//

import UIKit

class EmailViewController: UIViewController {
    
    var viewModel = signInViewModel()
    let registerView = RegisterView(frame: CGRect(), mode: .disabled)
    let descriptionLabel = UILabel()
    let subLabel = UILabel()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
       
        view.addSubview(registerView)
        view.addSubview(descriptionLabel)
        view.addSubview(subLabel)
        
        
    }
    
    func configure() {
        
        
    }
    
    func makeConstraints() {
        
        
    }
    


}
