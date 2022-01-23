//
//  TextFieldView.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/19.
//

import SnapKit
import UIKit
import Rswift
import RxCocoa
import RxSwift
import AnyFormatKit


enum TextFieldMode: Int {
    case active
    case disabled
}

class RegisterView: UIView{


    let contentsView = UIView()
    let textField = UITextField()
    let lineView = UIView()
    let additionLabel = UILabel()
    let placeHolderText: String = "휴대폰 번호(-없이 숫자만 입력"
    let button = UIButton()
    var mode: TextFieldMode = .disabled
    let disposeBag = DisposeBag()
    
    
    
    init(frame: CGRect, mode: TextFieldMode) {
        super.init(frame: frame)
        self.mode = mode
        setupView(placeHolderText: placeHolderText)
        setupConstraints()
        BindUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setupView(placeHolderText: String) {
        [contentsView, additionLabel, button].forEach {
            self.addSubview($0)
        }
        [textField, lineView].forEach {
            contentsView.addSubview($0)
        }

        contentsView.clipsToBounds = true
        contentsView.layer.cornerRadius = 4
        
        textField.backgroundColor = .clear
        textField.font = R.font.notoSansCJKkrRegular(size: 14)
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor : R.color.gray7()!])
        textField.keyboardType = .numberPad
        
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitle("인증 문자 받기", for: .normal)
        button.titleLabel?.font = R.font.notoSansCJKkrRegular(size: 14)
        button.setBackgroundColor(R.color.gray6()!, for: .disabled)
        button.setBackgroundColor(R.color.green()!, for: .normal)
    }
    
    func setupConstraints() {
        contentsView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
            make.bottom.equalTo(button.snp.top).offset(-72)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-13)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(72)
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
        
        textField.rx.text.orEmpty.map(checkPhoneNumberValid).subscribe(onNext: { b in
            self.button.isEnabled = b
            print("this button is enabled")
            self.textField.text = self.textField.text?.pretty()
            print("Pretty now")
            
        }).disposed(by: disposeBag)
        
    }
    
    func checkIsFocus(_ text: String) -> UIColor {
        if text == "" {
            return R.color.gray3()!
        } else {
            return R.color.focus()!
        }
        
    }
    
    func checkPhoneNumberValid(_ phoneNumber: String) -> Bool {
        let pattern = "^01[0-1, 7]+-[0-9-]{9}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.count)) {
            return true
        }
        return false
    }
    
    func pretty(text: String) -> String {
    let _str = text.replacingOccurrences(of: "-", with: "")
    let arr = Array(_str)
    if arr.count > 3 {

        
            if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                return modString
                
            }
        
    }
    return text
}
}

