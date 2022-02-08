//
//  NameAndTitleCell.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/05.
//

import UIKit

class NameCardCell: UITableViewCell {

    let viewModel = MyProfileViewModel.shared
    let identifier = "NameCardCell"
    let nameLabel = UILabel()
    let sesacTitleLabel = UILabel()
    
    let titleCollection: UICollectionView = {
           
           let layout = UICollectionViewFlowLayout()
           layout.minimumLineSpacing = 10
           
           layout.scrollDirection = .vertical
           layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    
          
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           
           return cv
       }()
    let reviewTitleLabel = UILabel()
    let reviewContentLabel = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(sesacTitleLabel)
        contentView.addSubview(titleCollection)
        contentView.addSubview(reviewTitleLabel)
        contentView.addSubview(reviewContentLabel)
        titleCollection.delegate = self
        titleCollection.dataSource = self
        
        configure()
        makeConstraints()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        nameLabel.text = "김새싹"
        nameLabel.font = R.font.notoSansCJKkrMedium(size: 16)
        sesacTitleLabel.text = "새싹 타이틀"
        sesacTitleLabel.font = R.font.notoSansCJKkrRegular(size: 12)
        reviewTitleLabel.text = "새싹 리뷰"
        reviewTitleLabel.font = R.font.notoSansCJKkrRegular(size: 12)
        reviewContentLabel.placeholder = "첫 리뷰를 기다리는 중이예요"
        reviewContentLabel.font = R.font.notoSansCJKkrRegular(size: 14)
        reviewContentLabel.isUserInteractionEnabled = false
        
        titleCollection.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: "TitleCollectionViewCell")
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1).cgColor
        
        
    }
    
    func makeConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            
        }
        
        sesacTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            
        }
        
        titleCollection.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(sesacTitleLabel.snp.bottom).offset(16)
            make.height.equalTo(120)
            make.centerX.equalToSuperview()
        }
        
        reviewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleCollection.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            
        }
        
        reviewContentLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
         
        }
        
        
    }

}
extension NameCardCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 78) / 2, height: 32)
    }
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = titleCollection.dequeueReusableCell(withReuseIdentifier: "TitleCollectionViewCell", for: indexPath) as! TitleCollectionViewCell
        cell.titleLabel.text = viewModel.titleArray[indexPath.row]
        cell.makeBackground(hasTitle: viewModel.userInfo?.reputation[indexPath.row] ?? 0)
                
        return cell
    }
    
    
}
