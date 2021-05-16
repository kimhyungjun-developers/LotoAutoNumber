//
//  AuthenticationContoller.swift
//  Loto6App
//
//  Created by Hyungjun Kim on 2021/04/04.
//

import UIKit

// ログインとユーザー登録コントローラー
class AuthenticationContoller: UIViewController {
    
    // MARK: - Properties
    
    // ログインとユーザー登録画面移動関連インスタンス生成
    private var showSingUpView = true
    
    // ログインとユーザー登録Viewの親Viewのインスタンス生成
    private let containerView = UIView()
    
    // ログインViewとユーザー登録Viewクラスのインスタンス生成
    private let loginView = LoginView()
    private let autheticationView = AutheticationView()
    
    // コントローラー生成
    private let lotoListController = LotoListController()
    
    // ログイン状況初期化
    @Published var isLogin = false
    
    // AlertMessageインスタス生成
    var alert:UIAlertController!
    var alertAction:UIAlertAction!
    
    // MARK: - Lifecycle
    
    // ログインとユーザー登録コントローラー初期化
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Actions
    
    // ログイン関数
    @objc func doLogin() {
        let idText : String? = self.loginView.idTextFiled.text
        let passwordText : String? = self.loginView.passwordTextFiled.text
    
        if idText == ""
        {
            // ID確認失敗時のAlert
            alert = UIAlertController(title: "ID確認", message: "IDを入力して下さい。",
                                      preferredStyle: UIAlertController.Style.alert)
            
            //「続けるボタン」のアラートアクションを作成する。
            alertAction = UIAlertAction(
                title: "Retry",
                style: UIAlertAction.Style.default,
                handler: { action in
                    
                    // IDテキストフィールドにフォーカス移動
                    self.loginView.idTextFiled.becomeFirstResponder()
            })
        }
        else if passwordText == ""
        {
            
            alert = UIAlertController(title: "パスワード確認", message: "パスワードを入力して下さい。",
                                      preferredStyle: UIAlertController.Style.alert)
            
            //「続けるボタン」のアラートアクションを作成する。
            alertAction = UIAlertAction(
                title: "Retry",
                style: UIAlertAction.Style.default,
                handler: { action in
                    
                    // パスワードテキストフィールドにフォーカス移動
                    self.loginView.passwordTextFiled.becomeFirstResponder()
            })
        }
        // ログイン成功
        // ログインAPI処理追加予定
        else if idText == "Test" && passwordText == "Test"
        {
            // ログイン成功時のAlert
            alert = UIAlertController(title: "ログインしました。", message: "次の画面に移動します。",
                                      preferredStyle: UIAlertController.Style.alert)
            
            //「続けるボタン」のアラートアクションを作成する。
            alertAction = UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: { action in
                    
                // ロトリストコントロール生成
                let lotoList = self.lotoListController
                
                // 全画面表示
                lotoList.modalPresentationStyle = .fullScreen
                // ロトリストビューコントローラーに画面遷移する。
                self.present(lotoList, animated: true, completion: nil)
                // ログイン状況更新
                self.isLogin = true
            })
        }
        // ログイン失敗
        else
        {
            // ログイン失敗時のAlert
            alert = UIAlertController(title: "ログインに失敗しました。", message: "IDもしくはパスワードが異なっております。",
                                      preferredStyle: UIAlertController.Style.alert)
            
            //「続けるボタン」のアラートアクションを作成する。
            alertAction = UIAlertAction(
                title: "Retry",
                style: UIAlertAction.Style.default,
                handler: { action in
                    
                    // パスワードテキストフィールドにフォーカス移動
                    self.loginView.passwordTextFiled.becomeFirstResponder()
            })
        }
        // アラートアクションを追加する。
        alert.addAction(alertAction)
        
        // アラートコントローラーを表示する。
        self.present(alert, animated: true, completion:{
        
            // アラートコントローラーの親ビューのユーザー操作を許可する。
            self.alert.view.superview?.isUserInteractionEnabled = true
            
            // アラートコントローラーにジェスチャーリコグナイザーを登録する。
            self.alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector(("tapOutside"))))
        })
    }
    
    // ユーザー登録関数
    @objc func doSignUp(){
        
    }

    //画面タップ時の呼び出しメソッド
    func tapOutside(){
        //モーダル表示しているビューコントローラーを閉じる。
        self.dismiss(animated: true, completion: nil)
    }
    
    // toggleViewのAction設定
    @objc func toggleView() {
        // ユーザー登録画面Viewが選択された場合
        if showSingUpView {
            UIView.animate(withDuration: 0.5, animations: {
                // コンテイナViewのY位置設定
                self.containerView.frame.origin.y = -self.view.bounds.height + 144
                // ログインView下の右ボタンイメージ設定
                self.loginView.rightButton.setImage(#imageLiteral(resourceName: "3590202-200"),for: .normal)
                // ログインView下の左ボタンイメージ設定
                self.loginView.leftButton.setImage(#imageLiteral(resourceName: "2500111-200"), for: .normal)
                // ログインView下の右ボタンイメージsize修正
                self.loginView.rightButton.contentEdgeInsets = UIEdgeInsets(top: 17, left: 17, bottom: 17, right: 17)
            }) { _ in
                // ログインView下の右ボを非使用設定
                self.loginView.rightButton.isUserInteractionEnabled = false
                // ログインView下の左ボを使用設定
                self.loginView.leftButton.isUserInteractionEnabled = true
                // ログイン画面Viewの状態設定
                self.showSingUpView = false
            }
        }
        // ログイン画面Viewが選択された場合
        else{
            UIView.animate(withDuration: 0.5, animations: {
                // コンテイナViewのY位置設定
                self.containerView.frame.origin.y = 0
                // ログインView下の右ボタンイメージ設定
                self.loginView.rightButton.setImage(#imageLiteral(resourceName: "2500111-200"), for: .normal)
                // ログインView下の左ボタンイメージ設定
                self.loginView.leftButton.setImage(#imageLiteral(resourceName: "3590202-200"),for: .normal)
                // ログインView下の右ボタンイメージsize修正
                self.loginView.rightButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
            }) { _ in
                // ログインView下の右ボを使用設定
                self.loginView.rightButton.isUserInteractionEnabled = true
                // ログインView下の左ボを非使用設定
                self.loginView.leftButton.isUserInteractionEnabled = false
                // ユーザー登録画面Viewの状態設定
                self.showSingUpView = true
            }
        }
    }
    
    // MARK: - Helpers
    
    // IphoneのStatusBarのスタイル設定
    override var preferredStatusBarStyle: UIStatusBarStyle{
        //文字色表示
        .lightContent
    }
    
    // ログインとユーザー登録コントローラー設定
    func configureUI()
    {
        // 親Viewのバックグラウンド色設定
        view.backgroundColor = .systemPink
        
        // 親Viewにログインとユーザー登録の元になるViewを追加(コンテイナView)
        view.addSubview(containerView)
        containerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * 2)
        containerView.backgroundColor = .white
        
        // コンテイナViewにログインView追加
        containerView.addSubview(loginView)
        loginView.frame = CGRect(x: containerView.bounds.origin.x, y: containerView.frame.origin.y,
                                 width: containerView.bounds.width, height: containerView.bounds.height / 2 - 72)
        
        loginView.idTextFiled.becomeFirstResponder()
        
        // ログインView下の右ボタンAction設定
        loginView.rightButton.addTarget(self, action: #selector(toggleView), for: .touchUpInside)
        // ログインView下の左ボタンAction設定
        loginView.leftButton.addTarget(self, action: #selector(toggleView), for: .touchUpInside)
        // ログインView下の左ボタン非使用設定
        loginView.leftButton.isUserInteractionEnabled = false
        // ログインボタンAction設定
        loginView.loginButton.addTarget(self, action: #selector(doLogin), for: .touchUpInside)
        // ユーザー登録ボタンAction設定
        autheticationView.signUpButton.addTarget(self, action: #selector(doSignUp), for: .touchUpInside)
        
        // コンテイナViewにユーザー登録View追加
        containerView.addSubview(autheticationView)
        autheticationView.frame = CGRect(x: containerView.bounds.origin.x, y: containerView.bounds.height / 2,
                                         width:   containerView.bounds.width, height: containerView.bounds.height / 2 + 72)
    }
}
