//
//  LoginCellViewModel.swift
//  AudibleWalkthrough
//
//  Created by Lucas Nascimento on 14/10/18.
//  Copyright © 2018 Lucas Nascimento. All rights reserved.
//

import UIKit

protocol LoginCellViewModelProtocol {
    var title: String { get set }
    var message: String { get set }
    var imageName: String { get set }
}

struct LoginCellViewModel: LoginCellViewModelProtocol {
    var title: String
    var message: String
    var imageName: String
}

extension LoginCellViewModel {
    
    init() {
        self.title = String()
        self.message = String()
        self.imageName = String()
    }
    
    init(page: Page) {
        self.title = page.title
        self.message = page.message
        self.imageName = page.imageName
    }
}
