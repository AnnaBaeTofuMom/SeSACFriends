//
//  NicknameViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/23.
//

import UIKit
import SnapKit
import Rswift
import RxSwift
import RxCocoa

class NicknameViewController: UIViewController {
    let viewModel = signInViewModel()
    let registerView = RegisterView(frame: CGRect(), mode: .disabled)
    let nicknameLabel = UILabel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(registerView)
        view.addSubview(nicknameLabel)
        view.backgroundColor = R.color.white()
        configure()
        makeConstraints()
        BindUI()
        
        
    }
    
    func BindUI() {
        
        registerView.button.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        registerView.textField.rx.text.subscribe { text in
            self.viewModel.nickname = "\(text)"
            print(text)
        }.disposed(by: disposeBag)
        
        registerView.textField.rx.text.orEmpty.map(viewModel.verifyNickname).subscribe { b in
            self.registerView.button.isEnabled = b
        }.disposed(by: disposeBag)
        
    }
    
    func configure() {
        nicknameLabel.text = "닉네임을 입력해 주세요"
        nicknameLabel.font = R.font.notoSansCJKkrRegular(size: 20)
        nicknameLabel.textAlignment = .center
        
        registerView.textField.placeholder = "10자 이내로 입력"
        registerView.textField.becomeFirstResponder()
        registerView.textField.keyboardType = .default
        registerView.button.isEnabled = false
        registerView.button.setTitle("다음", for: .normal)
        registerView.button.setBackgroundColor(R.color.gray3()!, for: .disabled)
        registerView.button.setBackgroundColor(R.color.green()!, for: .normal)
        
    }
    
    func makeConstraints() {
        nicknameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(185)
            make.leading.trailing.equalToSuperview()
        }
        
        registerView.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc func nextButtonClicked() {
        self.viewModel.nickname = self.registerView.textField.text!
        let DobVC = DoBPickerViewController()
        DobVC.viewModel = self.viewModel
        self.navigationController?.pushViewController(DobVC, animated: true)
        
    }

    

}
