//
//  SearchSesacViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/11.
//

import Foundation
import UIKit
import SnapKit

class SearchSesacViewController: UIViewController {
    
    let nearLabel = UILabel()
    let nearCollectionView: UICollectionView = {
           
           let layout = UICollectionViewFlowLayout()
           layout.minimumLineSpacing = 10
           
           layout.scrollDirection = .vertical
           layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    
          
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           
           return cv
       }()
    let wantLabel = UILabel()
    let wantCollectionView: UICollectionView = {
           
           let layout = UICollectionViewFlowLayout()
           layout.minimumLineSpacing = 10
           
           layout.scrollDirection = .vertical
           layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    
          
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           
           return cv
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        configure()
        makeConstraints()
    }
    
    func configure() {
        view.backgroundColor = R.color.white()
        [nearLabel, nearCollectionView, wantLabel, wantCollectionView].forEach {
            view.addSubview($0)
        }
        
        var bounds = UIScreen.main.bounds
        var width = bounds.size.width //화면 너비
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 28, height: 0))
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
      
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        nearCollectionView.register(HobbyCollectionViewCell.self, forCellWithReuseIdentifier: "HobbyCollectionViewCell")
        wantCollectionView.register(HobbyCollectionViewCell.self, forCellWithReuseIdentifier: "HobbyCollectionViewCell2")
        
        nearLabel.text = "지금 주변에는"
        nearLabel.font = R.font.notoSansCJKkrRegular(size: 12)
        
        wantLabel.text = "내가 하고 싶은"
        wantLabel.font = R.font.notoSansCJKkrRegular(size: 12)
        
        
        
    }
    
    func makeConstraints() {
        nearLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68)
            make.leading.equalToSuperview().offset(16)
            
        }
        
        nearCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(nearLabel.snp.bottom).offset(16)
            make.width.lessThanOrEqualTo(268)
            make.height.greaterThanOrEqualTo(112)
            
        }
        
        wantLabel.snp.makeConstraints { make in
            make.top.equalTo(nearCollectionView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            
        }
        
        wantCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(wantLabel.snp.bottom).offset(16)
            make.height.greaterThanOrEqualTo(112)
        }
        
        
        
    }
 
    
    

}
extension SearchSesacViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 78) / 2, height: 32)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wantCollectionView.dequeueReusableCell(withReuseIdentifier: "HobbyCollectionViewCell", for: indexPath) as! HobbyCollectionViewCell
        let cell2 = nearCollectionView.dequeueReusableCell(withReuseIdentifier: "HobbyCollectionViewCell2", for: indexPath) as! HobbyCollectionViewCell
        cell.titleLabel.text = "diffkff"
                
        if collectionView == wantCollectionView {
            return cell
        } else if collectionView == nearCollectionView {
            return cell2
        }
        
        return cell
    }
    
    
}
