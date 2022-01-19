//
//  PhoneAuthView.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/19.
//

import SnapKit
import UIKit
import RxSwift

class PhoneAuthView: UIView {
    let descriptionLabel = UILabel()
    let phoneNumberTextField = RegisterView(frame: CGRect(), mode: .disabled, placeHolderText: "휴대폰 번호(-없이 숫자만 입력)")

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraints()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {
        self.addSubview(descriptionLabel)
        self.addSubview(phoneNumberTextField)
        descriptionLabel.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해 주세요"
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = R.font.notoSansCJKkrRegular(size: 20)
        descriptionLabel.textAlignment = .center
        descriptionLabel.attributedText = lineSpacing(text: descriptionLabel.text!, spacing: 1.08, fontSize: 20)
    }
    
    func makeConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(169)
            make.leading.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().offset(-70)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(64)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        
        
    }

    

    
    
}
