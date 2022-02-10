//
//  HobbyCollectionViewCell.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/11.
//


import UIKit
import SnapKit


class HobbyCollectionViewCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    
    required init?(coder: NSCoder) {
          super.init(coder: coder)
          configure()
          makeConstraints()
      }
      
      override init(frame: CGRect) {
          super.init(frame: .zero)
          configure()
          makeConstraints()
      }
    
    func configure() {
        contentView.addSubview(titleLabel)
        titleLabel.text = "좋은매너랍니다"
        titleLabel.font = R.font.notoSansCJKkrRegular(size: 14)
        contentView.layer.cornerRadius = 8
     
        
   
     
        
        
        
    }
    
    func makeBackground(indexPath: IndexPath) {
        if indexPath.row <= 3 {
            contentView.backgroundColor = R.color.white()
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = R.color.error()?.cgColor

            titleLabel.textColor = R.color.error()

        } else {
            contentView.layer.borderColor = R.color.gray4()?.cgColor
            titleLabel.textColor = R.color.black()
        }

    }
    
    func makeConstraints() {
        
        self.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    

    
    
}
