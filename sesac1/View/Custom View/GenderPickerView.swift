//
//  GenderPickerView.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/23.
//

import Foundation
import UIKit
import RxSwift

class GenderPickerView: UIView, UIGestureRecognizerDelegate {
    let pickerView = UIView()
    let descriptionLabel = UILabel()
    let subLabel = UILabel()
    let maleButton = UIView()
    let femaleButton = UIView()
    let maleImage = UIImageView(image: UIImage(named: "man"))
    let femaleImage = UIImageView(image: UIImage(named: "woman"))
    let maleLabel = UILabel()
    let femaleLabel = UILabel()
    let button = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [pickerView, descriptionLabel, subLabel, button].forEach {
            self.addSubview($0)
        }
        
        [maleButton, femaleButton].forEach {
            pickerView.addSubview($0)
        }
        
        [maleLabel, maleImage].forEach {
            maleButton.addSubview($0)
        }
        
        [femaleLabel, femaleImage].forEach {
            femaleButton.addSubview($0)
        }
        
        
        configure()
        makeConstraints()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {
        
        descriptionLabel.text = "생년월일을 알려주세요"
        descriptionLabel.font = R.font.notoSansCJKkrRegular(size: 20)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = R.color.black()
        subLabel.text = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
        subLabel.font = R.font.notoSansCJKkrRegular(size: 16)
        subLabel.textAlignment = .center
        subLabel.textColor = R.color.gray7()
        
        maleButton.tintColor = R.color.white()
        maleButton.layer.cornerRadius = 9
        maleButton.layer.borderWidth = 1
        maleButton.layer.borderColor = UIColor(red: 0.887, green: 0.887, blue: 0.887, alpha: 1).cgColor
        
        maleLabel.text = "남자"
        maleLabel.font = R.font.notoSansCJKkrRegular(size: 16)
        maleLabel.textColor = R.color.black()
        
        femaleButton.tintColor = R.color.white()
        femaleButton.layer.cornerRadius = 9
        femaleButton.layer.borderWidth = 1
        femaleButton.layer.borderColor = UIColor(red: 0.887, green: 0.887, blue: 0.887, alpha: 1).cgColor
        
        femaleLabel.text = "여자"
        femaleLabel.font = R.font.notoSansCJKkrRegular(size: 16)
        femaleLabel.textColor = R.color.black()
    
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = R.font.notoSansCJKkrRegular(size: 14)
        button.setBackgroundColor(R.color.gray6()!, for: .disabled)
        button.setBackgroundColor(R.color.green()!, for: .normal)
        button.isEnabled = false
        

       
    }
    
    func makeConstraints() {
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(185)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
        }
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(120)
        }
        
        maleButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(166)
        }
        
        femaleButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(166)
        }
        
        maleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.centerX.equalToSuperview()
        }
        
        maleLabel.snp.makeConstraints { make in
            make.top.equalTo(maleImage.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        
        femaleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.centerX.equalToSuperview()
        }
        
        femaleLabel.snp.makeConstraints { make in
            make.top.equalTo(femaleImage.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
    
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pickerView.snp.bottom).offset(32)
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(12)
            
        }
        
        
    }
    
    
 
 
    
}

