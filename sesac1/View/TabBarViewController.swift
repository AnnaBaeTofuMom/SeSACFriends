//
//  TabBarViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/03.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.tintColor = R.color.white()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.tintColor = R.color.green()
        self.tabBar.unselectedItemTintColor = R.color.gray6()
        
        
        let tabOne = MainMapViewController()
        let tabOneBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), tag: 0)
        
        tabOne.tabBarItem = tabOneBarItem
        let tabTwo = UINavigationController(rootViewController: ShopViewController())
        let tabTwoBarItem = UITabBarItem(title: "새싹샵", image: UIImage(named: "shop"), tag: 1)
        tabTwo.tabBarItem = tabTwoBarItem
        let tabThree = UINavigationController(rootViewController: FriendViewController())
        let tabThreeBarItem = UITabBarItem(title: "새싹친구", image: UIImage(named: "friend"), tag: 2)
        tabThree.tabBarItem = tabThreeBarItem
        let tabFour = UINavigationController(rootViewController: MyPageViewController())
        let tabFourBarItem = UITabBarItem(title: "내정보", image: UIImage(named: "mypage"), tag: 3)
        tabFour.tabBarItem = tabFourBarItem
        
        self.viewControllers = [tabOne, tabTwo, tabThree, tabFour]
        
        
    }
    
   

}
