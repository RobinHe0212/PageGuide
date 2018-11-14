//
//  LoginCell.swift
//  PageGuide
//
//  Created by Robin He on 11/12/18.
//  Copyright © 2018 Robin He. All rights reserved.
//

import UIKit
class LoginCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    let imageView : UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(named: "nike")
        image.contentMode = .scaleAspectFill
        return image
        
        
    }()
    let nikeText : UITextView = {
        let word = "YOUR ACCOUNT FOR EVERYTHING NIKE"
        let attributeMutedText = NSMutableAttributedString(string: word, attributes: [NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 25)])
        
        let uiText = UITextView()
        uiText.attributedText = attributeMutedText
        uiText.isEditable = false
        return uiText
        
    }()
    let addressText : UITextField = {
        let address = LeftPadding()
        address.placeholder = "Email"
        address.keyboardType = .emailAddress
        address.layer.borderColor = UIColor(white: 0, alpha: 0.5).cgColor
        address.layer.borderWidth = 1
        return address
        
    }()
    
    
    let pwText : UITextField = {
        let password = LeftPadding()
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.layer.borderColor = UIColor(white: 0, alpha: 0.5).cgColor
        password.layer.borderWidth = 1
        return password
        
    }()
    lazy var buttonView : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
        
    }()
    
    func setUpView(){
        
        addSubview(imageView)
        addSubview(nikeText)
        addSubview(addressText)
        addSubview(pwText)
        addSubview(buttonView)
        imageView.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -230, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 60)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
       nikeText.anchor(imageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 25, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 150)
        addressText.anchor(nikeText.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: -60, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        pwText.anchor(addressText.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        buttonView.anchor(pwText.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
    }
    
}

class LeftPadding : UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+10, y: bounds.origin.y, width: bounds.width+10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+10, y: bounds.origin.y, width: bounds.width+10, height: bounds.height)
    }
}
