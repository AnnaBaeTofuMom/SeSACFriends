//
//  CodeAuthView.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/20.
//

import Foundation
import UIKit
import RxSwift

class CodeAuthView: UIView {
    let descriptionLabel = UILabel()
    let timeInfoLabel = UILabel()
    let phoneNumberTextField = CodeRegisterView(frame: CGRect(), mode: .disabled, placeHolderText: "인증번호 입력")
    let disposeBag = DisposeBag()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraints()
        BindUI()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {
        self.addSubview(descriptionLabel)
        self.addSubview(phoneNumberTextField)
        self.addSubview(timeInfoLabel)
        descriptionLabel.text = "인증번호가 문자로 전송되었어요"
        descriptionLabel.numberOfLines = 1
        descriptionLabel.font = R.font.notoSansCJKkrRegular(size: 20)
        descriptionLabel.textAlignment = .center
        descriptionLabel.attributedText = lineSpacing(text: descriptionLabel.text!, spacing: 1.08, fontSize: 20)
        timeInfoLabel.text = "(최대 20초 소요)"
        timeInfoLabel.font = R.font.notoSansCJKkrRegular(size: 16)
        timeInfoLabel.textColor = R.color.gray7()
        timeInfoLabel.textAlignment = .center
    }
    
    func makeConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(169)
            make.centerX.equalToSuperview()
        }
        
        timeInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(timeInfoLabel.snp.bottom).offset(64)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        
        
    }
    
    func BindUI() {
        phoneNumberTextField.textField.rx.text.orEmpty.map(checkIsFocus).subscribe(onNext: { color in
            self.phoneNumberTextField.lineView.backgroundColor = color
        }).disposed(by: disposeBag)
        
        phoneNumberTextField.textField.rx.text.orEmpty.map(codeNumberValid).subscribe(onNext: { b in
            self.phoneNumberTextField.startButton.isEnabled = b
        }).disposed(by: disposeBag)
        
    }
    
    func checkIsFocus(_ text: String) -> UIColor {
        if text == "" {
            return R.color.gray3()!
        } else {
            return R.color.focus()!
        }
        
    }
    
    func codeNumberValid(_ phoneNumber: String) -> Bool {
        let pattern = "[0-9]{6}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.count)) {
            return true
        }
        
        return false
    
    }
    
    
}
