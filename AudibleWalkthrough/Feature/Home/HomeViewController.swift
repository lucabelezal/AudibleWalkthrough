//
//  HomeViewController.swift
//  AudibleWalkthrough
//
//  Created by Lucas Nascimento on 28/10/18.
//  Copyright © 2018 Lucas Nascimento. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let imageView: UIImageView
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.imageView = UIImageView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupView()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "We're logged in"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
    }
    
    @objc func handleSignOut() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }
}

extension HomeViewController: ViewCodable {
    
    func configure() {
        imageView.image = UIImage(named: "home")
    }
    
    func hierarchy() {
        view.addView(imageView)
    }
    
    func constraints() {
        imageView.layout.makeConstraints { make in
            make.top.equalTo(view.layout.top, constant: 64)
            make.bottom.equalTo(view.layout.bottom)
            make.left.equalTo(view.layout.left)
            make.right.equalTo(view.layout.right)
        }
    }
    
    func styles() {
        
    }
}
