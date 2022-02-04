//
//  MyPageTableViewCell.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/04.
//

import UIKit

class MyPageDetailCell: UITableViewCell {
    let identifier = "MyPageDetailCell"
    let profileImage = UIImageView()
    let nameLabel = UILabel()
    let button = UIButton()

    let topLine = UIView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)

    
        
        configure()
        makeConstraints()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(profileImage)
        contentView.addSubview(button)
        contentView.addSubview(topLine)
        nameLabel.text = "김새싹"
        nameLabel.font = R.font.notoSansCJKkrMedium(size: 16)
        profileImage.image = UIImage(named: "profile_img")
        button.setImage(UIImage(named: "more_arrow"), for: .normal)
        button.tintColor = R.color.black()
        topLine.backgroundColor = R.color.gray2()
        
    }
    
    func makeConstraints() {
        

        
        profileImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(13)
            make.top.equalToSuperview().offset(37)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(39)
            make.trailing.equalToSuperview().inset(22.5)
        }
    
        
        topLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        
        
    }
    
}
