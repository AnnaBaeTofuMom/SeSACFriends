//
//  TitleCollectionViewCell.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/06.
//

import UIKit
import SnapKit


class TitleCollectionViewCell: UICollectionViewCell {
    
    var hasTitle : Int = 0
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
        titleLabel.text = "좋은 매너"
        titleLabel.font = R.font.notoSansCJKkrRegular(size: 14)
        contentView.layer.cornerRadius = 8
        print("hasTitle = \(hasTitle)")
        
   
     
        
        
        
    }
    
    func makeBackground(hasTitle: Int) {
        if hasTitle == 0 {
            contentView.backgroundColor = R.color.white()
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = R.color.gray4()?.cgColor

            titleLabel.textColor = R.color.black()

        } else {
            contentView.backgroundColor = R.color.green()
            titleLabel.textColor = R.color.white()
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
