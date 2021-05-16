//
//  LotoListController.swift
//  Loto6Number
//
//  Created by Hyungjun Kim on 2021/04/30.
//

import UIKit

class LotoListController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: - Properties
    
    // ロト当選番号リスト生成
    var tableView: UITableView?
    
    // ロト当選回検索コントロール生成
    var searchBar: UISearchBar?
    
    // ロト6当選番号リストViewの親Viewのインスタンス生成
    private let containerView = UIView()
    
    // ロトリストモデル取得
    var lotolists = [LotoList]()
    
    var searchResults = [LotoList]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
    }
    
    // MARK: - Actions
    
    // 前の画面に戻る関数
    @objc func backView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // ロトリストAPIからJSONデータ取得
    @objc func fetchData() {
    
        let url = URL(string: "http://158.101.142.134/Loto6SelectJson?num=0")!

        URLSession.shared.dataTask(with: url) { data, response, error
            in
            guard let data = data else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }

            let decoder = JSONDecoder()

            if let lotolists = try? decoder.decode([LotoList].self, from: data) {
                DispatchQueue.main.async {
                    self.lotolists = lotolists
                    self.tableView?.reloadData()
                    print("Loaded \(lotolists.count) lotolist" )
                }
            } else {
                    print("Unable parse JSON response")
            }
        }.resume()
    }
    
    // MARK: - Helpers
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // IphoneのStatusBarのスタイル設定
    override var preferredStatusBarStyle: UIStatusBarStyle{
        //文字色表示
        .lightContent
    }
    
    // テーブルView行数設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar!.text != "" {
            return searchResults.count
        }
        else{
            return self.lotolists.count
        }
    }
    
    // テーブルView表示データ設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.numberOfLines = 4
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.contentView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        
        cell.separatorInset = .zero
        tableView.separatorColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        if searchBar!.text != "" {
            let title = "当選番号 回号 : 第" + self.searchResults[indexPath.row].list_number + "回\n当選日 : " + self.searchResults[indexPath.row].list_date + "\n本番号 : "
            let number1 = self.searchResults[indexPath.row].number1
            let number2 = self.searchResults[indexPath.row].number2
            let number3 = self.searchResults[indexPath.row].number3
            let number4 = self.searchResults[indexPath.row].number4
            let number5 = self.searchResults[indexPath.row].number5
            let number6 = self.searchResults[indexPath.row].number6
            let bouns = "\nボーナス番号 : " + self.searchResults[indexPath.row].bonus
            cell.textLabel?.text = title + number1 + "," + number2 + "," + number3 + "," + number4 + "," + number5 + "," + number6 + bouns

            return cell
        }
        else{
            let title = "当選番号 回号 : 第" + self.lotolists[indexPath.row].list_number + "回\n当選日 : " + self.lotolists[indexPath.row].list_date + "\n本番号 : "
            let number1 = self.lotolists[indexPath.row].number1
            let number2 = self.lotolists[indexPath.row].number2
            let number3 = self.lotolists[indexPath.row].number3
            let number4 = self.lotolists[indexPath.row].number4
            let number5 = self.lotolists[indexPath.row].number5
            let number6 = self.lotolists[indexPath.row].number6
            let bouns = "\nボーナス番号 : " + self.lotolists[indexPath.row].bonus
            cell.textLabel?.text = title + number1 + "," + number2 + "," + number3 + "," + number4 + "," + number5 + "," + number6 + bouns

            return cell
        }
    }
    
    // 検索ボタンが押された時に呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = true
        self.searchResults = self.lotolists.filter{
            // ロト当選回検索
            $0.list_number == self.searchBar!.text!
        }
        self.tableView!.reloadData()
    }

    // キャンセルボタンが押された時に呼ばれる
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
        searchBar.text = ""
        self.tableView!.reloadData()
    }

    // テキストフィールド入力開始前に呼ばれる
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func configureUI()
    {
        // 親Viewのバックグラウンド色設定
        view.backgroundColor = .systemPink
        
        // 親Viewにロトリストの元になるViewを追加(コンテイナView)
        view.addSubview(containerView)
        containerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        containerView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        
        //当選番号検索コントロール追加
        self.searchBar = {
           let searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:42)
            searchBar.layer.position = CGPoint(x: self.view.bounds.width/2, y: 89)
            searchBar.searchBarStyle = UISearchBar.Style.default
            searchBar.showsSearchResultsButton = true
            searchBar.placeholder = "検索"
            searchBar.setValue("キャンセル", forKey: "cancelButtonText")
            //キャンセルボタン色
            searchBar.tintColor = .white
            //背景色変更
            searchBar.barTintColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
            //テキスト色
            searchBar.searchTextField.textColor = .white
            
            return searchBar
        }()
        
        // コンテイナViewにロト当選番号リストView追加
        self.tableView = {
            let tableView = UITableView(frame: self.view.bounds, style: .plain)
                tableView.autoresizingMask = [
                    .flexibleWidth,
                    .flexibleHeight
                ]
            containerView.addSubview(tableView)
            tableView.frame = CGRect(x: containerView.bounds.origin.x,
                                     y: containerView.frame.origin.y,
                                     width: containerView.bounds.width,
                                     height: containerView.bounds.height)
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.estimatedRowHeight = 200
            tableView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
            tableView.rowHeight = UITableView.automaticDimension
            
            tableView.tableHeaderView = searchBar
            
            return tableView

          }()
    
    }
}
