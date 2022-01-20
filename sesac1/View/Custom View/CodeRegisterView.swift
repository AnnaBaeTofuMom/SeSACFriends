//
//  CodeRegisterView.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/20.
//

import SnapKit
import UIKit
import Rswift
import RxCocoa
import RxSwift
import AnyFormatKit


enum CodeTextFieldMode: Int {
    case active
    case disabled
}

class CodeRegisterView: UIView{


    let contentsView = UIView()
    let textField = UITextField()
    let lineView = UIView()
    let placeHolderText: String = ""
    let resendButton = UIButton()
    let startButton = UIButton()
    var mode: CodeTextFieldMode = .disabled
    let disposeBag = DisposeBag()
    let timer = UILabel()
    let inputStackView = UIStackView()
//    let viewModel = PhoneAuthViewModel()
    
    
    
    init(frame: CGRect, mode: CodeTextFieldMode, placeHolderText: String) {
        super.init(frame: frame)
        self.mode = mode
        setupView(placeHolderText: placeHolderText)
        setupConstraints()
        BindUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView(placeHolderText: String) {
        [contentsView, startButton, resendButton].forEach {
            self.addSubview($0)
        }
        
        
        [lineView, textField, timer].forEach {
            contentsView.addSubview($0)
        }
        
        
        
        contentsView.clipsToBounds = true
        contentsView.layer.cornerRadius = 4
       

        
        textField.backgroundColor = .clear
        textField.font = R.font.notoSansCJKkrRegular(size: 14)
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor : R.color.gray7()!])
        textField.keyboardType = .numberPad
        textField.placeholder = "인증번호 입력"
        textField.isUserInteractionEnabled = true
        textField.becomeFirstResponder()
        textField.tintColor = .blue
        
        startButton.clipsToBounds = true
        startButton.layer.cornerRadius = 8
        startButton.setTitle("인증하고 시작하기", for: .normal)
        startButton.titleLabel?.font = R.font.notoSansCJKkrRegular(size: 14)
        startButton.setBackgroundColor(R.color.gray6()!, for: .disabled)
        startButton.setTitleColor(R.color.gray3(), for: .disabled)
        startButton.setBackgroundColor(R.color.green()!, for: .normal)
        startButton.setTitleColor(R.color.white(), for: .normal)
        
        resendButton.clipsToBounds = true
        resendButton.layer.cornerRadius = 8
        resendButton.setTitle("재전송", for: .normal)
        resendButton.titleLabel?.font = R.font.notoSansCJKkrRegular(size: 14)
        resendButton.setBackgroundColor(R.color.green()!, for: .normal)
        resendButton.setTitleColor(R.color.white(), for: .normal)
        
        timer.text = "1:00"
        timer.textColor = R.color.green()
        timer.font = R.font.notoSansCJKkrRegular(size: 14)
        
        inputStackView.spacing = 121
        inputStackView.layoutMargins.left = 0
        inputStackView.layoutMargins.right = 0
    
    }
    
    func setupConstraints() {

        
        contentsView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.height.equalTo(48)
            
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-13)
        }
        
        timer.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(37)
            make.height.equalTo(22)
        }
        
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            
        }
        
        resendButton.snp.makeConstraints { make in
            make.leading.equalTo(contentsView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(contentsView.snp.centerY)
            make.height.equalTo(40)
            make.width.equalTo(72)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(contentsView.snp.bottom).offset(72)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    func BindUI() {
        textField.rx.text.orEmpty.map(checkIsFocus).subscribe(onNext: { color in
            self.lineView.backgroundColor = color
        }).disposed(by: disposeBag)
        
        textField.rx.text.orEmpty.map(codeNumberValid).subscribe(onNext: { b in
            self.startButton.isEnabled = b
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


