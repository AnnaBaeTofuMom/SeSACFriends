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
        
        genderView.button.isEnabled = true
        self.viewModel.gender = -1
        
        genderView.maleButton.addGestureRecognizer(maleGes)
        genderView.femaleButton.addGestureRecognizer(femaleGes)
        
        genderView.button.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    

    
    @objc func tapMale(_ sender: UITapGestureRecognizer) {
        self.genderView.maleButton.backgroundColor = R.color.whitegreen()
        self.genderView.femaleButton.backgroundColor = R.color.white()
        self.viewModel.gender = 0
        self.genderView.button.isEnabled = true
        
    }
    
    @objc func tapFemale(_ sender: UITapGestureRecognizer) {
        self.genderView.femaleButton.backgroundColor = R.color.whitegreen()
        self.genderView.maleButton.backgroundColor = R.color.white()
        self.viewModel.gender = 1
        self.genderView.button.isEnabled = true
        
    }
    
    @objc func nextButtonClicked() {
        
        self.viewModel.SignUpButtonClicked { statuscode, error in
            switch statuscode {
            case 200:
                self.view.makeToast("회원가입에 성공하셨습니다.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let vc = TabBarViewController()
                    let nav = UINavigationController(rootViewController: vc)
                  
                    self.navigationController?.pushViewController(nav, animated: true)
                }
                
            case 201:
                self.view.makeToast("이미 가입한 유저입니다.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.viewModel.SignIn { statuscode, error in
                        if statuscode == 200 {
                            self.view.window?.rootViewController = TabBarViewController()
                        } else {
                            self.view.makeToast("로그인에 실패했습니다...")
                        }
                    }
                }
                
                
            case 202:
                self.view.makeToast("닉네임을 사용할 수 없습니다")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let vc = NicknameViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            case 401:
                print("401 에러에러")
                
            case .none:
                print("뭔가 잘못됨 statuscode none")
            case .some(_):
                print("더 크게 잘못됨 ")
            }
        }
        
        
    }
    

}
