//
//  MainNavigationController.swift
//  AudibleWalkthrough
//
//  Created by Lucas Nascimento on 06/10/18.
//  Copyright © 2018 Lucas Nascimento. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if isLoggedIn() {
            let homeController = HomeViewController()
            viewControllers = [homeController]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc func showLoginController() {
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: {
           
        })
    }
}
