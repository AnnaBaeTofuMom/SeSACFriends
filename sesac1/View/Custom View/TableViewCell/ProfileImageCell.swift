//
//  ProfileImageTableViewCell.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/05.
//

import UIKit
import SnapKit

class ProfileImageCell: UITableViewCell {
    
    let identifier = "ProfileImageCell"
    let profileImageView = UIImageView()
    let button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)
        contentView.addSubview(profileImageView)
        contentView.addSubview(button)
      
        
        configure()
        makeConstraints()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        profileImageView.image = UIImage(named: "profile_img_large")
        profileImageView.layer.cornerRadius = 8
        profileImageView.sizeToFit()
        
        button.setImage(UIImage(named: "user_card_match_btn"), for: .normal)
    }

    func makeConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(12)
        }
        
    }

}
