//
//  RNPlacehodlerTextView.swift
//  RNPlacehodlerTextViewExample
//
//  Created by 罗伟 on 2017/2/7.
//  Copyright © 2017年 罗伟. All rights reserved.
//

import UIKit

class RNPlacehodlerTextView: UITextView {

    var placeholderLabel: UILabel?
    
    @IBInspectable var placeholder: String = "" {
        didSet {
            placeholderLabel?.text = placeholder
        }
    }
    
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            placeholderLabel?.textColor = placeholderColor
        }
    }
    
    @IBInspectable var placeholderFont: CGFloat = 14
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.5 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.initUI()
    }
    
    func initUI() {
        guard self.placeholderLabel == nil else {
            return
        }
        
        let placeholderFont = UIFont.systemFont(ofSize: self.placeholderFont)
        let leftMarign: CGFloat = 4
        let rect = (self.placeholder as NSString).boundingRect(with: CGSize.init(width: self.frame.size.width - leftMarign * 2, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : placeholderFont], context: nil)
        
        let placeholderLabel = UILabel.init(frame: CGRect(x: leftMarign, y: 10, width: self.frame.size.width - leftMarign * 2, height: rect.size.height))
        placeholderLabel.numberOfLines = 0
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.text = self.placeholder
        placeholderLabel.font = placeholderFont
        self.addSubview(placeholderLabel)
        self.placeholderLabel = placeholderLabel
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }
    
    func textDidChange() {
        guard self.text.characters.count == 0 else {
            placeholderLabel?.isHidden = true
            return
        }
        placeholderLabel?.isHidden = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    

}
