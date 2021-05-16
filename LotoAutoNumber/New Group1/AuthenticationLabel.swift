//
//  AuthenticationLabel.swift
//  Loto6App
//
//  Created by Hyungjun Kim on 2021/04/04.
//

import UIKit

// ラベルクラス
class AuthenticationLabel: UILabel {
    
    // MARK: - Lifecycle
    
    // ラベル設定関数
    init(text: String, textColor: UIColor)
    {
        super.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: 18)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
