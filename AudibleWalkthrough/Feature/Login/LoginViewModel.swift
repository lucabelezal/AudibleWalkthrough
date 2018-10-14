//
//  LoginViewModel.swift
//  AudibleWalkthrough
//
//  Created by Lucas Nascimento on 14/10/18.
//  Copyright © 2018 Lucas Nascimento. All rights reserved.
//

import UIKit

protocol LoginViewModelProtocol {
    var pages: [Page] { get set }
}

struct LoginViewModel: LoginViewModelProtocol {
    var pages: [Page]
    
    init() {
        self.pages = []
    }
}

extension LoginViewModel {

    init(pages: [Page]) {
        self.pages = pages
    }
}
