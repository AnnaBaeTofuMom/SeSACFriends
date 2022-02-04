//
//  FriendViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/02/03.
//

import UIKit

class FriendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        self.navigationController?.navigationBar.topItem?.title = "새싹친구"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
