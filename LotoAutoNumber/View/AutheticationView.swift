//
//  AutheticationView.swift
//  Loto6Number
//
//  Created by Hyungjun Kim on 2021/04/29.
//

import UIKit

// ユーザー登録画面クラス
class AutheticationView: UIView{
    
    // MARK: - Properties
    
    // タイトルラベル設定
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ユーザー登録"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        return label
    }()
    
    // ID、パスワード、メール、ユーザー名のラベルとテキストフィールド設定
    private let idLabel = AuthenticationLabel(text: "ID", textColor: #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))
    private let passwordLabel = AuthenticationLabel(text: "パスワード", textColor: #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))
    private let emailLabel = AuthenticationLabel(text: "メール", textColor: #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))
    private let userNameLabel = AuthenticationLabel(text: "ユーザー名", textColor: #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))
    
    let idTextFiled = AuthenticationTextFiled(placeholder: "IDを入力して下さい。")
    let passwordTextFiled = AuthenticationTextFiled(placeholder: "パスワードを入力して下さい。", isSequreField: true)
    let emailTextFiled = AuthenticationTextFiled(placeholder: "メールアドレスを入力してください。")
    let userTextFiled = AuthenticationTextFiled(placeholder: "ユーザー名を入力して下さい。")
    
    // ユーザー登録ボタン設定
    let signUpButton: UIButton = {
        let button = UIButton(type:.system)
        button.setTitle("ユーザー登録", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        return button
    }()
    
    // MARK: - Lifecycle
    
    // ユーザー登録画面初期化
    override init(frame: CGRect){
        super.init(frame: frame)
        ConfigureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    // ユーザー登録画面のコントロール設定
    func ConfigureUI(){
        // バックグラウンド色設定
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // タイトルラベル追加
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        // ユーザー名、メール、ID、パスワードのラベルとテキストフィールド追加
        let stack = UIStackView(arrangedSubviews: [userNameLabel, userTextFiled, emailLabel, emailTextFiled, idLabel, idTextFiled, passwordLabel, passwordTextFiled])
        
        stack.axis = .vertical
        stack.spacing = 24
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        
        // ユーザー登録ボタン追加
        addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.heightAnchor.constraint(equalToConstant:48).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30).isActive = true
        signUpButton.layer.cornerRadius = 48/2
    }
}


