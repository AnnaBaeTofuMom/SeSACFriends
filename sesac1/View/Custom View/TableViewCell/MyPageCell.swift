//
//  MyPageCell.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/04.
//

import UIKit

class MyPageCell: UITableViewCell {
    
    let identifier = "MyPageCell"
    let icon = UIImageView()
    let label = UILabel()
    let line = UIView()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)
        contentView.addSubview(label)
        contentView.addSubview(icon)
        contentView.addSubview(line)
      

        configure()
        makeConstraints()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        icon.image = UIImage(named: "notice")
        label.text = "알림설정"
        label.font = R.font.notoSansCJKkrRegular(size: 16)
        line.backgroundColor = R.color.gray2()
        
    }
    
    func makeConstraints() {
        
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview().offset(17)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(icon.snp.trailing).offset(14)
            
        }
        
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-17)
            make.top.equalToSuperview()
        }
        
        
        
        
    }

}
