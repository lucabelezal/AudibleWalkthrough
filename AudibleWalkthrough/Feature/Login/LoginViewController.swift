//
//  LoginViewController.swift
//  AudibleWalkthrough
//
//  Created by Lucas Nascimento on 07/10/18.
//  Copyright © 2018 Lucas Nascimento. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var mainView: LoginView?
    var pages: [Page]?
    
    override func loadView() {
        super.loadView()
        mainView = LoginView(frame: UIScreen.main.bounds)
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        loadData()
        updateView()
    }
    
    func loadData() {
        pages = {
            let firstPage = Page(title: "Share a great listen",
                                 message: "It's free to send your books to the people in your life. Every recipient's first book is on us.",
                                 imageName: "page1")
            
            let secondPage = Page(title: "Send from your library",
                                  message: "Tap the More menu next to any book. Choose \"Send this Book\"",
                                  imageName: "page2")
            
            let thirdPage = Page(title: "Send from the player",
                                 message: "Tap the More menu in the upper corner. Choose \"Send this Book\"",
                                 imageName: "page3")
            
            return [firstPage, secondPage, thirdPage]
        }()
    }
    
    func updateView() {
        if let pages = pages {
            mainView?.viewModel = LoginViewModel(pages: pages)
        }
    }
}
