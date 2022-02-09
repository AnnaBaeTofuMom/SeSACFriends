//
//  MainMapViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/24.
//

import UIKit

class MainMapViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        view = MainMapCustomView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        self.tabBarController?.editButtonItem.tintColor = R.color.whitegreen()
        
    
        
    }
    

}
