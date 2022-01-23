//
//  GenderViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/23.
//

import UIKit
import Rswift
import RxSwift
import RxCocoa

class GenderViewController: UIViewController, UIGestureRecognizerDelegate {
    var viewModel = signInViewModel()
    let genderView = GenderPickerView()
    
    
    override func loadView() {
        super.loadView()
        view = genderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.white()
        
        
        let maleGes = UITapGestureRecognizer(target: self, action: #selector(tapMale(_:)))
        let femaleGes = UITapGestureRecognizer(target: self, action: #selector(tapFemale(_:)))
        maleGes.delegate = self
        femaleGes.delegate = self
        
        genderView.maleButton.addGestureRecognizer(maleGes)
        genderView.femaleButton.addGestureRecognizer(femaleGes)
        
        genderView.button.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    

    
    @objc func tapMale(_ sender: UITapGestureRecognizer) {
        self.genderView.maleButton.backgroundColor = R.color.whitegreen()
        self.genderView.femaleButton.backgroundColor = R.color.white()
        self.viewModel.gender = 0
        self.viewModel.genderSelected = true
        self.genderView.button.isEnabled = true
        
    }
    
    @objc func tapFemale(_ sender: UITapGestureRecognizer) {
        self.genderView.femaleButton.backgroundColor = R.color.whitegreen()
        self.genderView.maleButton.backgroundColor = R.color.white()
        self.viewModel.gender = 1
        self.viewModel.genderSelected = true
        self.genderView.button.isEnabled = true
        
    }
    
    @objc func nextButtonClicked() {
        self.navigationController?.pushViewController(MainMapViewController(), animated: true)
    }
    

}
