//
//  LoginCellView.swift
//  AudibleWalkthrough
//
//  Created by Lucas Nascimento on 07/10/18.
//  Copyright © 2018 Lucas Nascimento. All rights reserved.
//

import UIKit

protocol LoginCellViewProtocol: class  {
    func DidLoggingIn()
}

class LoginCellView: UICollectionViewCell, Reusable {
    
    let containerView: UIView
    let logoImageView: UIImageView
    let emailTextField: LeftPaddedTextField
    let passwordTextField: LeftPaddedTextField
    let loginButton: UIButton
    
    weak var delegate: LoginCellViewProtocol?
    
    var viewModel: LoginCellViewModelProtocol? {
        didSet {
            updateView()
        }
    }
    
    override init(frame: CGRect) {
        self.containerView = UIView()
        self.logoImageView = UIImageView()
        self.emailTextField = LeftPaddedTextField()
        self.passwordTextField = LeftPaddedTextField()
        self.loginButton = UIButton(type: .system)
        super.init(frame:frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleLogin() {
        delegate?.DidLoggingIn()
    }
    
    func updateView() {
        
    }
}

extension LoginCellView: ViewCodable {
    
    func configure() {
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    func hierarchy() {
        containerView.addView(logoImageView, emailTextField, passwordTextField, loginButton)
        contentView.addView(containerView)
    }
    
    func constraints() {
        
        containerView.layout.makeConstraints { make in
            make.centerX.equalTo(contentView.layout.centerX)
            make.centerY.equalTo(contentView.layout.centerY)
            make.right.equalTo(contentView.layout.right, constant: -32)
            make.left.equalTo(contentView.layout.left, constant: 32)
            make.height.equalTo(constant: 390)
        }
        
        logoImageView.layout.makeConstraints { make in
            make.top.equalTo(containerView.layout.top)
            make.centerX.equalTo(containerView.layout.centerX)
            make.width.equalTo(constant: 160)
            make.height.equalTo(constant: 160)
        }
        
        emailTextField.layout.makeConstraints { make in
            make.top.equalTo(logoImageView.layout.bottom, constant: 32)
            make.right.equalTo(containerView.layout.right)
            make.left.equalTo(containerView.layout.left)
            make.height.equalTo(constant: 50)
        }
        
        passwordTextField.layout.makeConstraints { make in
            make.top.equalTo(emailTextField.layout.bottom, constant: 16)
            make.right.equalTo(containerView.layout.right)
            make.left.equalTo(containerView.layout.left)
            make.height.equalTo(constant: 50)
        }
        
        loginButton.layout.makeConstraints { make in
            make.top.equalTo(passwordTextField.layout.bottom, constant: 32)
            make.right.equalTo(containerView.layout.right)
            make.left.equalTo(containerView.layout.left)
            make.height.equalTo(constant: 50)
        }
    }
    
    func styles() {
        logoImageView.image = UIImage(named: "logo")
        
        emailTextField.placeholder = "Enter email"
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.keyboardType = .emailAddress
        
        passwordTextField.placeholder = "Enter password"
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.isSecureTextEntry = true
        
        loginButton.backgroundColor = .orange
        loginButton.setTitle("Log in", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
    }
}
