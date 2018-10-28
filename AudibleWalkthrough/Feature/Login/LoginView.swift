//
//  LoginView.swift
//  AudibleWalkthrough
//
//  Created by Lucas Nascimento on 07/10/18.
//  Copyright © 2018 Lucas Nascimento. All rights reserved.
//

import UIKit

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
            pageControl.numberOfPages = viewModel.pages.count + 1
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
    
    
    // MARK: Actions Buttons
    
    @objc func skip() {
        pageControl.currentPage = viewModel.pages.count - 1
        nextPage()
    }
    
    @objc func nextPage() {
        
        if pageControl.currentPage == viewModel.pages.count {
            return
        }
        
        if pageControl.currentPage == viewModel.pages.count - 1 {
            moveControlConstraintsOffScreen()
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: {
                            
                self.layoutIfNeeded()
            }, completion: nil)
        }
        
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    //MARK: Private Methods
    
    private func moveControlConstraintsOffScreen() {
        pageControlBottomAnchor?.constant = 40
        skipButtonTopAnchor?.constant = -40
        nextButtonTopAnchor?.constant = -40
    }
}

extension LoginView: ViewCodable {
    
    func configure() {
        collectionView.register(cellType: PageCellView.self)
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
        return viewModel.pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        if indexPath.item == viewModel.pages.count {
            let loginCell = collectionView.dequeueReusableCell(for: indexPath, cellType: LoginCellView.self)
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PageCellView.self)
        cell.page = viewModel.pages[indexPath.item]
        
        return cell
    }
}

extension LoginView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
}

extension LoginView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber = Int(targetContentOffset.pointee.x / frame.width)
        pageControl.currentPage = pageNumber
        
        if pageNumber == viewModel.pages.count {
            moveControlConstraintsOffScreen()
        } else {
            pageControlBottomAnchor?.constant = 0
            skipButtonTopAnchor?.constant = 16
            nextButtonTopAnchor?.constant = 16
        }
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        
            self.layoutIfNeeded()
        }, completion: nil)
    }

}

extension LoginView: LoginViewControllerProtocol {
    
    func finishLoggingIn() {
        
    }
    
    func collectionChanged() {
        collectionView.collectionViewLayout.invalidateLayout()
        
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.reloadData()
        }
    }
}
