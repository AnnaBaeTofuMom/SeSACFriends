//
//  DoBPickerViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/23.
//

import UIKit
import Rswift

class DoBPickerViewController: UIViewController {
    
    var viewModel = signInViewModel()
    var pickerView = DatePickerView()
    
    override func loadView() {
        view = pickerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.white()
        
        
        pickerView.button.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    func BindUI() {
        
    }
    
    
    @objc func nextButtonClicked() {
        viewModel.dateOfBirth = pickerView.datePicker.date
        print("pickerView.datePicker.date \(pickerView.datePicker.date)")
        
        let EVC = EmailViewController()
        EVC.viewModel = self.viewModel
        self.navigationController?.pushViewController(EVC, animated: true)
        
    }

}
