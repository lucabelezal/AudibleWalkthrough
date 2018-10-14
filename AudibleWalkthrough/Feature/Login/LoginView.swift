//
//  LoginView.swift
//  AudibleWalkthrough
//
//  Created by Lucas Nascimento on 07/10/18.
//  Copyright © 2018 Lucas Nascimento. All rights reserved.
//

import UIKit

protocol LoginViewControllerProtocol: class {
    func finishLoggingIn()
}

class LoginView: UIView {
    
    let collectionViewLayout: UICollectionViewFlowLayout
    let collectionView: UICollectionView
    let pageControl: UIPageControl
    let skipButton: UIButton
    let nextButton: UIButton
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    
    var viewModel: LoginViewModelProtocol {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        self.viewModel = LoginViewModel()
        self.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: collectionViewLayout)
        self.pageControl = UIPageControl()
        self.skipButton = UIButton()
        self.nextButton = UIButton()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func skip() {
        
    }
    
    @objc func nextPage() {
        
    }
}

extension LoginView: ViewCodable {
    
    func configure() {
        collectionView.register(cellType: LoginCellView.self)
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        
        pageControl.numberOfPages = viewModel.pages.count + 1
        
        skipButton.setTitle("Skip", for: .normal)
        skipButton.addTarget(self, action: #selector(skip), for: .touchUpInside)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
    }
    
    func hierarchy() {
        addView(collectionView, pageControl, skipButton, nextButton)
    }
    
    func constraints() {
        
        collectionView.layout.makeConstraints { make in
            make.top.equalTo(self.layout.top)
            make.bottom.equalTo(self.layout.bottom)
            make.left.equalTo(self.layout.left)
            make.right.equalTo(self.layout.right)
        }
        
        pageControl.layout.makeConstraints { make in
            make.right.equalTo(self.layout.right)
            make.left.equalTo(self.layout.left).reference(&pageControlBottomAnchor)
            make.bottom.equalTo(self.layout.bottom)
            make.height.equalTo(constant: 40)
        }
        
        skipButton.layout.makeConstraints { make in
            make.top.equalTo(self.layout.top, constant: 16).reference(&skipButtonTopAnchor)
            make.left.equalTo(self.layout.left)
            make.width.equalTo(constant: 60)
            make.height.equalTo(constant: 50)
        }
        
        nextButton.layout.makeConstraints { make in
            make.top.equalTo(self.layout.top, constant: 16).reference(&nextButtonTopAnchor)
            make.right.equalTo(self.layout.right)
            make.width.equalTo(constant: 60)
            make.height.equalTo(constant: 50)
        }
    }
    
    func styles() {
        collectionView.backgroundColor = UIColor.white
        
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        
        skipButton.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        
        nextButton.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
    }
}

extension LoginView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: LoginCellView.self)
        return cell
    }
}

extension LoginView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
}

extension LoginView: UICollectionViewDelegate {
    
}

extension LoginView: LoginViewControllerProtocol {
    
    func finishLoggingIn() {
        
    }
}
