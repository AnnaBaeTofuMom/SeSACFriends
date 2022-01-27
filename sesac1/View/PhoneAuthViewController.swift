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
import Toast_Swift

class PhoneAuthViewController: UIViewController {
    let navi = UINavigationController()
    let repo = Repository()
    let descriptionLabel = UILabel()
    let registerView = RegisterView(frame: CGRect(), mode: .disabled)
    let viewModel = PhoneAuthViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = R.color.white()
        
        registerView.button.addTarget(self, action: #selector(phoneAuthButtonClicked), for: .touchUpInside)
        
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
        
        registerView.textField.rx.text.orEmpty.map(checkIsFocus).subscribe(onNext: { color in
            self.registerView.lineView.backgroundColor = color
        }).disposed(by: disposeBag)
        
        registerView.textField.rx.text.orEmpty.map(checkPhoneNumberValid).subscribe(onNext: { b in
            self.registerView.button.isEnabled = b
            print("this button is enabled")
            self.registerView.textField.text = self.registerView.textField.text?.pretty()
            print("Pretty now")
            
        }).disposed(by: disposeBag)

    }
    
    func configure() {
        view.addSubview(descriptionLabel)
        view.addSubview(registerView)
        
        descriptionLabel.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해 주세요"
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = R.font.notoSansCJKkrRegular(size: 20)
        descriptionLabel.textAlignment = .center
        descriptionLabel.attributedText = lineSpacing(text: descriptionLabel.text!, spacing: 1.08, fontSize: 20)
        registerView.textField.becomeFirstResponder()
        registerView.button.isEnabled = false
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
    
    @objc func phoneAuthButtonClicked() {
        
        viewModel.modifyNumber { error, statusCode in
            if error == .failed {
                print("phone number verification failed")
                self.view.makeToast("전화번호 인증에 실패했습니다.")
                
            } else {
                print("phone number verification success")
                let cav = CodeAuthViewController()
                cav.viewModel.phoneNumber = self.registerView.textField.text!
                self.navigationController?.pushViewController(cav, animated: true)
                
            }
        }
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

