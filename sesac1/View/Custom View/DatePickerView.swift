//
//  DatePickerView.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/23.
//

import Foundation
import UIKit
import RxSwift

class DatePickerView: UIView {
    
    
    let datePicker = UIDatePicker()
    
    let descriptionLabel = UILabel()
    let yearView = UIView()
    let monthView = UIView()
    let dayView = UIView()
    let yearTextField = UITextField()
    let monthTextField = UITextField()
    let dayTextField = UITextField()
    let yearLabel = UILabel()
    let monthLabel = UILabel()
    let dayLabel = UILabel()
    let lineView1 = UIView()
    let lineView2 = UIView()
    let lineView3 = UIView()
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [yearView, monthView, dayView, descriptionLabel, button, datePicker].forEach {
            self.addSubview($0)
        }
        
        [yearLabel, lineView1, yearTextField].forEach {
            yearView.addSubview($0)
        }
        
        [monthLabel, lineView2, monthTextField].forEach {
            monthView.addSubview($0)
        }
        
        [dayLabel, lineView3, dayTextField].forEach {
            dayView.addSubview($0)
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
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        
        yearLabel.text = "년"
        yearLabel.font =  R.font.notoSansCJKkrRegular(size: 16)
        yearLabel.textColor = R.color.black()
        monthLabel.text = "월"
        monthLabel.font =  R.font.notoSansCJKkrRegular(size: 16)
        monthLabel.textColor = R.color.black()
        dayLabel.text = "일"
        dayLabel.font =  R.font.notoSansCJKkrRegular(size: 16)
        dayLabel.textColor = R.color.black()
        
        lineView1.backgroundColor = R.color.gray3()
        lineView2.backgroundColor = R.color.gray3()
        lineView3.backgroundColor = R.color.gray3()
        
        yearTextField.font = R.font.notoSansCJKkrRegular(size: 14)
        yearTextField.textColor = R.color.black()
        yearTextField.placeholder = "1990"
        monthTextField.font = R.font.notoSansCJKkrRegular(size: 14)
        monthTextField.textColor = R.color.black()
        monthTextField.placeholder = "1"
        dayTextField.font = R.font.notoSansCJKkrRegular(size: 14)
        dayTextField.textColor = R.color.black()
        dayTextField.placeholder = "1"
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = R.font.notoSansCJKkrRegular(size: 14)
        button.setBackgroundColor(R.color.gray6()!, for: .disabled)
        button.setBackgroundColor(R.color.green()!, for: .normal)
        button.isEnabled = false
        
        datePicker.becomeFirstResponder()
        datePicker.backgroundColor = R.color.gray3()
        
        
       
    }
    
    func makeConstraints() {
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(185)
        }
        
        
        monthView.snp.makeConstraints { make in
            make.width.equalTo(99)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(80)
        }
        
        
        monthTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            make.leading.equalToSuperview().offset(12)
            
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(11)
            make.trailing.equalToSuperview().offset(-4)
        }
        
        lineView2.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(1)
        }
        
        yearView.snp.makeConstraints { make in
            make.width.equalTo(99)
            make.height.equalTo(48)
            make.trailing.equalTo(monthView.snp.leading).offset(-23)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(80)
        }
        
        yearTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            make.leading.equalToSuperview().offset(12)
            
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(11)
            make.trailing.equalToSuperview().offset(-4)
        }
        
        lineView1.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(1)
        }
        
        
        dayView.snp.makeConstraints { make in
            make.width.equalTo(99)
            make.height.equalTo(48)
            make.leading.equalTo(monthView.snp.trailing).offset(23)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(80)
        }

        dayTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            make.leading.equalToSuperview().offset(12)
            
        }
        
        dayLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(11)
            make.trailing.equalToSuperview().offset(-4)
        }
        
        
        
        lineView3.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(1)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(monthView.snp.bottom).offset(74)
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(12)
            
        }
        
        datePicker.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        
        
        
       
        
        
    }
    
    
    @objc
       private func handleDatePicker(_ sender: UIDatePicker) {
           print(sender.date)
           yearTextField.text = "\(sender.calendar.component(.year, from: sender.date))"
           monthTextField.text = "\(sender.calendar.component(.month, from: sender.date))"
           dayTextField.text = "\(sender.calendar.component(.day, from: sender.date))"
           button.isEnabled = true
           
       }
    
 
    
}
