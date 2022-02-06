//
//  ProfileDetailTableViewCell.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/06.
//

import UIKit
import SnapKit
import RangeSeekSlider

class ProfileDetailTableViewCell: UITableViewCell {

   
    let identifier = "ProfileDetailTableViewCell"
    let genderLabel = UILabel()
    let genderBox1 = UIView()
    let genderBox2 = UIView()
    let hobbyLabel = UILabel()
    let hobbyTextfield = UITextField()
    let hobbyTextfieldLine = UIView()
    let numberSearchableLabel = UILabel()
    let numberSearchableToggle = UISwitch()
    let counterAgeLabel = UILabel()
    var ageRangeLabel = UILabel()
    let ageSlider = RangeSeekSlider()
    let deleteAccountLabel = UILabel()
    
    let maleLabel = UILabel()
    let femaleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)
       
        ageSlider.delegate = self
        configure()
        makeConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(genderLabel)
        contentView.addSubview(genderBox1)
        contentView.addSubview(genderBox2)
        contentView.addSubview(hobbyLabel)
        contentView.addSubview(hobbyTextfield)
        contentView.addSubview(hobbyTextfieldLine)
        contentView.addSubview(numberSearchableLabel)
        contentView.addSubview(numberSearchableToggle)
        contentView.addSubview(counterAgeLabel)
        contentView.addSubview(ageRangeLabel)
        contentView.addSubview(ageSlider)
        contentView.addSubview(deleteAccountLabel)
        
        genderBox1.addSubview(maleLabel)
        genderBox1.layer.borderWidth = 1
        genderBox1.layer.borderColor = R.color.gray2()?.cgColor
        genderBox1.layer.cornerRadius = 8
        genderBox2.addSubview(femaleLabel)
        genderBox2.layer.borderWidth = 1
        genderBox2.layer.borderColor = R.color.gray2()?.cgColor
        genderBox2.layer.cornerRadius = 8
        
        genderLabel.text = "내 성별"
        genderLabel.font = R.font.notoSansCJKkrRegular(size: 14)
        hobbyLabel.text = "자주 하는 취미"
        hobbyLabel.font = R.font.notoSansCJKkrRegular(size: 14)
        
        hobbyTextfield.font = R.font.notoSansCJKkrRegular(size: 14)
        hobbyTextfieldLine.backgroundColor = R.color.gray3()
        
        numberSearchableLabel.text = "내 번호 검색 허용"
        numberSearchableLabel.font = R.font.notoSansCJKkrRegular(size: 14)
        counterAgeLabel.text = "상대방 연령대"
        counterAgeLabel.font = R.font.notoSansCJKkrRegular(size: 14)
        ageRangeLabel.text = "18 - 35"
        ageRangeLabel.textColor = R.color.green()
        ageRangeLabel.font = R.font.notoSansCJKkrRegular(size: 14)
        deleteAccountLabel.text = "회원탈퇴"
        deleteAccountLabel.font = R.font.notoSansCJKkrRegular(size: 14)
        maleLabel.text = "남자"
        maleLabel.font = R.font.notoSansCJKkrRegular(size: 14)
        femaleLabel.text = "여자"
        femaleLabel.font = R.font.notoSansCJKkrRegular(size: 14)
        
        ageSlider.handleColor = R.color.green()
        ageSlider.colorBetweenHandles = R.color.green()
        ageSlider.tintColor = R.color.gray2()
        ageSlider.minValue = 18
        ageSlider.maxValue = 65
        ageSlider.selectedMinValue = 18
        ageSlider.selectedMaxValue = 35
        
        numberSearchableToggle.tintColor = R.color.green()
        
        
    }
    
    func makeConstraints() {
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(37)
            make.leading.equalToSuperview()
        }
        
        genderBox2.snp.makeConstraints { make in
            
            make.width.equalTo(56)
            make.height.equalTo(48)
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview()
        }
        
        genderBox1.snp.makeConstraints { make in
            make.width.equalTo(56)
            make.height.equalTo(48)
            make.trailing.equalTo(genderBox2.snp.leading).offset(-8)
            make.top.equalToSuperview().offset(24)
            
        }
        
        maleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        femaleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        hobbyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(genderLabel.snp.bottom).offset(42)
        }
        
        hobbyTextfield.snp.makeConstraints { make in
            make.centerY.equalTo(hobbyLabel)
            make.trailing.equalToSuperview()
            make.width.equalTo(160)
        }
        
        hobbyTextfieldLine.snp.makeConstraints { make in
            make.bottom.equalTo(hobbyTextfield.snp.bottom).offset(12)
            make.trailing.equalToSuperview()
            make.width.equalTo(164)
            make.height.equalTo(1)
        }
        
        numberSearchableLabel.snp.makeConstraints { make in
            make.top.equalTo(hobbyLabel.snp.bottom).offset(42)
            make.leading.equalToSuperview()
            
        }
        
        numberSearchableToggle.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalTo(hobbyTextfieldLine.snp.bottom).offset(21)
           
        }
        
        counterAgeLabel.snp.makeConstraints { make in
            make.top.equalTo(numberSearchableLabel.snp.bottom).offset(42)
            make.leading.equalToSuperview()
        }
        
        ageRangeLabel.snp.makeConstraints { make in
            make.top.equalTo(numberSearchableToggle.snp.bottom).offset(40)
            make.trailing.equalToSuperview()
           
        }
        
        ageSlider.snp.makeConstraints { make in
            make.top.equalTo(counterAgeLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        deleteAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(counterAgeLabel.snp.bottom).offset(80)
            make.leading.equalToSuperview()
        }
        
       
    }
}
extension ProfileDetailTableViewCell: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
    
        self.ageRangeLabel.text = "\(Int(minValue.rounded(.up))) - \(Int(maxValue.rounded(.up)))"
    }
}
