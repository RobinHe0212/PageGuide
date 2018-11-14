//
//  PageCell.swift
//  PageGuide
//
//  Created by Robin He on 11/10/18.
//  Copyright © 2018 Robin He. All rights reserved.
//

import UIKit
class PageCell : UICollectionViewCell{
    
    var page : PageModel? {
        didSet{
            guard page != nil else{
                
                fatalError("did not call ")
                
            }
            imageView.image = UIImage(named: page!.imageUrl)
            let attributedMute = NSMutableAttributedString(string: page!.title, attributes: [NSMutableAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
            let pageMessage = "\n\n"+page!.message
            attributedMute.append(NSMutableAttributedString(string:pageMessage, attributes: [NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
           // texts.text = page!.title + "\n" + page!.message
          
            let paraStyle = NSMutableParagraphStyle()
            paraStyle.alignment = .center
            let len = attributedMute.string.count
            attributedMute.addAttribute(NSMutableAttributedString.Key.paragraphStyle, value: paraStyle, range: NSRange(location: 0, length: len))
             texts.attributedText = attributedMute
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
        let imageView : UIImageView = {
            let image = UIImageView()
            
         //   image.image = UIImage(named: "diamond")
            image.contentMode = .scaleToFill
            image.clipsToBounds = true
            return image
        }()
        
        let texts : UITextView = {
            let text = UITextView()
            text.isEditable = false
            text.backgroundColor = .white
            text.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            return text
            
            
        }()
    
    let spaceLine : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return line
        
    }()
    
    
    
    
     func setupView(){
        addSubview(imageView)
        addSubview(spaceLine)
        addSubview(texts)
        
        
        imageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 250, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        spaceLine.anchor(imageView.bottomAnchor, left: leftAnchor, bottom: texts.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        texts.anchor(spaceLine.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
       
        
    }
}
