//
//  LoginView.swift
//  Loto6App
//
//  Created by Hyungjun Kim on 2021/04/04.
//

import UIKit

// ログイン画面クラス
class LoginView : UIView{
    
    // MARK: - Properties
    
    // タイトルラベル設定
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ログイン"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    // IDとパスワードラベルとテキストフィールド設定
    private let idLabel = AuthenticationLabel(text: "ID", textColor: .white)
    private let passwordLabel = AuthenticationLabel(text: "パスワード", textColor: .white)
    let idTextFiled = AuthenticationTextFiled(placeholder: "IDを入力して下さい。")
    let passwordTextFiled = AuthenticationTextFiled(placeholder: "パスワードを入力して下さい。", isSequreField: true)
 
    // ログインボタン設定
    let loginButton: UIButton = {
        let button = UIButton(type:.system)
        button.setTitle("ログイン", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.tintColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return button
    }()
    
    // 下の左ボタン設定
    let leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "405158-200").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 12, left: 12, bottom: 12, right: 12)
        return button
    }()
    
    // 下の右ボタン設定
    let rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "2500111-200").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 12, left: 12, bottom: 12, right: 12)
        return button
    }()
    
    // MARK: - Lifecycle
    
    // ログイン画面初期化
    override init(frame: CGRect){
        super.init(frame: frame)
        ConfigureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    // ログイン画面のコントロール設定
    func ConfigureUI(){
        // バックグラウンド色設定
        backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        
        // タイトルラベル追加
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 72).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        // IDラベル、パスワードラベル、IDテキストフィールド、パスワードテキストフィールド追加
        let stack = UIStackView(arrangedSubviews: [idLabel, idTextFiled, passwordLabel, passwordTextFiled])
        
        stack.axis = .vertical
        stack.spacing = 24
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        
        // ログインボタン追加
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant:48).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30).isActive = true
        loginButton.layer.cornerRadius = 48/2
        
        // 下の右ボタン追加
        addSubview(rightButton)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
        rightButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        rightButton.topAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
        rightButton.layer.cornerRadius = 64 / 2
        
        // 下の左ボタン追加
        addSubview(leftButton)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
        leftButton.rightAnchor.constraint(equalTo: rightButton.leftAnchor).isActive = true
        leftButton.topAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
        leftButton.layer.cornerRadius = 64 / 2
    }
}
