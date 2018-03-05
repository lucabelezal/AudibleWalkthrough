//
//  PageCell.swift
//  AudibleWalkthrough
//
//  Created by Lucas Nascimento on 04/03/2018.
//  Copyright © 2018 Lucas Nascimento. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.yellow
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "page1")
        iv.clipsToBounds = true 
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = UIColor.blue
        
        addSubview(imageView)
        imageView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
    }
}
