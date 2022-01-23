//
//  PhoneAuthViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/18.
//

import UIKit
import Rswift
import RxSwift
import RxCocoa
import AnyFormatKit

class PhoneAuthViewController: UIViewController, UITextFieldDelegate {
    let repo = Repository()
    let descriptionLabel = UILabel()
    let registerView = RegisterView(frame: CGRect(), mode: .disabled)
    let viewModel = PhoneAuthViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = R.color.white()
        
        let gesture = UIGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(gesture)
        
        registerView.button.addTarget(self, action: #selector(verifyNumber), for: .touchUpInside)
        
        BindUI()
        configure()
        makeConstraints()

    }
    
    
    
    func BindUI() {
        registerView.textField.rx.text.subscribe { text in
            print(text!)
            self.viewModel.phoneNumber = text!
            print("this is from viewModel - \(self.viewModel.phoneNumber)")
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)
        

    }
    
    func configure() {
        view.addSubview(descriptionLabel)
        view.addSubview(registerView)
        descriptionLabel.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해 주세요"
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = R.font.notoSansCJKkrRegular(size: 20)
        descriptionLabel.textAlignment = .center
        descriptionLabel.attributedText = lineSpacing(text: descriptionLabel.text!, spacing: 1.08, fontSize: 20)
    }

    func makeConstraints() {


        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(169)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(64)

        }

        registerView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottomMargin).offset(64)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

    }
    
    @objc func verifyNumber() {
        
        viewModel.modifyNumber { error, statusCode in
            if error == .failed {
                print("phone number verification failed")
            } else {
                print("phone number verification success")
            }
        }
    }
    
    
    

}

