//
//  EmailViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/23.
//

import UIKit
import Rswift
import RxCocoa
import SnapKit
import RxSwift

class EmailViewController: UIViewController {
    
    var viewModel = signInViewModel()
    let registerView = RegisterView(frame: CGRect(), mode: .disabled)
    let descriptionLabel = UILabel()
    let subLabel = UILabel()
    let disposeBag = DisposeBag()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.white()
       
        view.addSubview(registerView)
        view.addSubview(descriptionLabel)
        view.addSubview(subLabel)
        
        configure()
        makeConstraints()
        BindUI()
        
        
    }
    
    func BindUI() {
        registerView.textField.rx.text.orEmpty.map(viewModel.isFocsed).subscribe { color in
            self.registerView.lineView.backgroundColor = color
        }.disposed(by: disposeBag)
        
        registerView.textField.rx.text.orEmpty.map(viewModel.verifyEmail).subscribe { bool in
            self.registerView.button.isEnabled = bool
        }.disposed(by: disposeBag)

        
    }
    
    func configure() {
        
        registerView.textField.keyboardType = .default
        registerView.textField.becomeFirstResponder()
        registerView.button.setTitle("다음", for: .normal)
        registerView.button.isEnabled = false
        registerView.textField.placeholder = "SeSAC@email.com"
        registerView.textField.textColor = R.color.black()
        
        descriptionLabel.text = "이메일을 입력해 주세요"
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = R.font.notoSansCJKkrRegular(size: 20)
        descriptionLabel.textColor = R.color.black()
        
        subLabel.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        subLabel.textAlignment = .center
        subLabel.font = R.font.notoSansCJKkrRegular(size: 16)
        subLabel.textColor = R.color.gray7()
        
        registerView.button.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        
        
    }
    
    func makeConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(168)
            make.leading.trailing.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        registerView.snp.makeConstraints { make in
            make.top.equalTo(subLabel).offset(76)
            make.leading.trailing.equalToSuperview().inset(16)
            
        }
        
        
    }
    @objc func nextButtonClicked() {
        viewModel.email = self.registerView.textField.text!
        let GVC = GenderViewController()
        GVC.viewModel = self.viewModel
        self.navigationController?.pushViewController(GVC, animated: true)
    }
    


}
