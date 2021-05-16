//
//  AuthenticationTextFiled.swift
//  Loto6App
//
//  Created by Hyungjun Kim on 2021/04/04.
//

import UIKit

// テキストフィールドクラス
class AuthenticationTextFiled : UITextField
{
    // MARK: - Lifecycle
    
    // テキストフィールド設定関数
    init(placeholder: String, isSequreField: Bool? = false)
    {
        super.init(frame: .zero)
        self.attributedPlaceholder = NSAttributedString(string:placeholder, attributes: [.foregroundColor : UIColor.lightGray] )
        self.isSecureTextEntry = isSequreField!
        self.textColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    // テキストフィールドデザイン設定
    override func draw(_ rect: CGRect)
    {
        let border = CALayer()
        border.frame = CGRect(x: rect.origin.x, y: rect.height - 0.75, width: bounds.width, height: 0.75)
        border.backgroundColor = UIColor.lightGray.cgColor
        layer.addSublayer(border)
        
    }
}
