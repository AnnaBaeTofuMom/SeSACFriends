//
//  MyProfileViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/04.
//

import UIKit
import SnapKit

class MyProfileViewController: UIViewController {
    
    let viewModel = MyProfileViewModel.shared
    
    let tableView = UITableView()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
        configure()
        makeConstraints()
    }
    
    
    
    func configure() {
        view.addSubview(tableView)
        view.backgroundColor = R.color.white()
        title = "정보관리"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        tableView.register(ProfileImageCell.self, forCellReuseIdentifier: "ProfileImageCell")
        tableView.register(NameCardCell.self, forCellReuseIdentifier: "NameCardCell")
        tableView.register(ProfileDetailTableViewCell.self, forCellReuseIdentifier: "ProfileDetailTableViewCell")
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        
        
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        
    }
    
    @objc func saveButtonClicked() {
        
        viewModel.postUpdateUser(UpdateUserModel: self.viewModel.updateUserModel.value) { statuscode, error in
            switch statuscode {
            case 200:
                self.view.makeToast("저장되었습니다.")
                
            case .none:
                self.view.makeToast("저장에 실패했습니다")
            case .some(_):
                self.view.makeToast("저장에 실패했습니다.")
            }
        }
        
    }
    

    
}
extension MyProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileImageCell") as? ProfileImageCell else { return UITableViewCell() }
            cell.button.isHidden = true
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NameCardCell") as? NameCardCell else { return UITableViewCell() }
            
            cell.nameLabel.text = MyProfileViewModel.shared.myUserInfo.value.nick
            
            
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileDetailTableViewCell") as? ProfileDetailTableViewCell else { return UITableViewCell() }
            
            cell.hobbyTextfield.text = viewModel.myUserInfo.value.hobby
            cell.numberSearchableToggle.isOn = (((viewModel.myUserInfo.value.searchable)) != 0)
            cell.ageSlider.selectedMaxValue = CGFloat(Int(viewModel.myUserInfo.value.ageMax))
            cell.ageSlider.selectedMinValue = CGFloat(Int(viewModel.myUserInfo.value.ageMin))

            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            
            return 200
        } else if indexPath.row == 1 {
            return 310
        } else {
            return 450        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    
    
    
    
}
