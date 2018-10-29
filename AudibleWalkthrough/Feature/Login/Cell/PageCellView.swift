//
//  PageCellView.swift
//  AudibleWalkthrough
//
//  Created by Lucas Nascimento on 14/10/18.
//  Copyright © 2018 Lucas Nascimento. All rights reserved.
//

import UIKit

class PageCellView: UICollectionViewCell, Reusable {
    
    let imageView: UIImageView
    let textView: UITextView
    let lineSeparatorView: UIView
    let color: UIColor
    
    var attributedText: NSMutableAttributedString
    var paragraphStyle: NSMutableParagraphStyle
    
    var viewModel: PageCellViewProtocol {
        didSet {
            updateView()
        }
    }
    
    var page: Page? {
        didSet {
            updateView()
        }
    }
    
    override init(frame: CGRect) {
        self.imageView = UIImageView()
        self.textView = UITextView()
        self.lineSeparatorView = UIView()
        self.color = UIColor(white: 0.2, alpha: 1)
        self.attributedText = NSMutableAttributedString()
        self.paragraphStyle = NSMutableParagraphStyle()
        self.viewModel = PageCellViewModel()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView() {
        attributedText = NSMutableAttributedString(string: viewModel.title, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor: color])
        
        attributedText.append(NSAttributedString(string: "\n\n\(viewModel.message)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: color]))
        
        paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let length = attributedText.string.count
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
        
        textView.attributedText = attributedText
        imageView.image = UIImage(named: viewModel.imageName)
    }
}

extension PageCellView: ViewCodable {
    
    func configure() {
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "page1")
        imageView.clipsToBounds = true
        
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        textView.isEditable = false
        textView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
    }
    
    func hierarchy() {
        addView(imageView, textView, lineSeparatorView)
    }
    
    func constraints() {
        
        imageView.layout.makeConstraints { make in
            make.top.equalTo(contentView.layout.top)
            make.bottom.equalTo(textView.layout.top)
            make.right.equalTo(contentView.layout.right)
            make.left.equalTo(contentView.layout.left)
        }
        
        textView.layout.makeConstraints { make in
            make.bottom.equalTo(contentView.layout.bottom)
            make.right.equalTo(contentView.layout.right, constant: -16)
            make.left.equalTo(contentView.layout.left, constant: 16)
        }
        
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        lineSeparatorView.layout.makeConstraints { make in
            make.bottom.equalTo(textView.layout.top)
            make.right.equalTo(contentView.layout.right)
            make.left.equalTo(contentView.layout.left)
            make.height.equalTo(constant: 1)
        }
    }
    
    func styles() {
        imageView.backgroundColor = UIColor.yellow
        lineSeparatorView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
}
