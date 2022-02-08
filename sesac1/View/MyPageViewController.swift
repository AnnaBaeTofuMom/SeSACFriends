//
//  MyPageViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/03.
//

import UIKit
import SnapKit
import RxSwift
import XCTest


class MyPageViewController: UIViewController {
    
    let tableView = UITableView()
    let viewModel = MyPageViewModel()
    let profileViewModel = MyProfileViewModel.shared
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configure()
        makeConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        DispatchQueue.main.async {
            self.profileViewModel.getSignIn { code, error, user in
                if code == 200 {
                    if let user = user {
                        self.profileViewModel.myUserInfo.value = user
                    }
                }
                
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        self.navigationController?.navigationBar.topItem?.title = "내정보"
    }
    
    func configure() {
        view.backgroundColor = R.color.white()
        view.addSubview(tableView)
        tableView.register(MyPageDetailCell.self, forCellReuseIdentifier: "MyPageDetailCell")
        tableView.register(MyPageCell.self, forCellReuseIdentifier: "MyPageCell")
        tableView.separatorStyle = .none
        
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailCell", for: indexPath) as? MyPageDetailCell else { return UITableViewCell() }
            
            profileViewModel.myUserInfo.bind { user in
                cell.nameLabel.text = "\(user.nick)"
            }
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell", for: indexPath) as? MyPageCell else { return UITableViewCell() }
            cell.label.text = viewModel.listTitleArray[indexPath.row - 1]
            cell.icon.image = UIImage(named: viewModel.iconTitleArray[indexPath.row - 1])
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + viewModel.iconTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 96
        } else {
            return 74
        }
        return 96
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(MyProfileViewController(), animated: true)
        }
    }
}
