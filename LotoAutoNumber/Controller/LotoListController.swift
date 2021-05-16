//
//  LotoListController.swift
//  Loto6Number
//
//  Created by Hyungjun Kim on 2021/04/30.
//

import UIKit

class LotoListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var tableView: UITableView?
    
    // ロト6当選番号リストViewの親Viewのインスタンス生成
    private let containerView = UIView()
    
    // ロトリストモデル取得
    var lotolists = [LotoList]()
    
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
        return self.lotolists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let title = "当選番号 回号 : 第" + self.lotolists[indexPath.row].list_number + "回\n当選日 : " + self.lotolists[indexPath.row].list_date + "\n本番号 : "
        let number1 = self.lotolists[indexPath.row].number1
        let number2 = self.lotolists[indexPath.row].number2
        let number3 = self.lotolists[indexPath.row].number3
        let number4 = self.lotolists[indexPath.row].number4
        let number5 = self.lotolists[indexPath.row].number5
        let number6 = self.lotolists[indexPath.row].number6
        let bouns = "\nボーナス番号 : " + self.lotolists[indexPath.row].bonus
        cell.textLabel?.text = title + number1 + "," + number2 + "," + number3 + "," + number4 + "," + number5 + "," + number6 + bouns
        cell.textLabel?.numberOfLines = 4
        
        return cell
    }
    
    func configureUI()
    {
        // 親Viewのバックグラウンド色設定
        view.backgroundColor = .systemPink
        
        // 親Viewにロトリストの元になるViewを追加(コンテイナView)
        view.addSubview(containerView)
        containerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        containerView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        
        // コンテイナViewにログインView追加
        self.tableView = {
            let tableView = UITableView(frame: self.view.bounds, style: .plain)
            tableView.autoresizingMask = [
              .flexibleWidth,
              .flexibleHeight
            ]
            containerView.addSubview(tableView)
            tableView.frame = CGRect(x: containerView.bounds.origin.x, y: containerView.frame.origin.y,
                                     width: containerView.bounds.width, height: containerView.bounds.height)
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.estimatedRowHeight = 200
            tableView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
            tableView.rowHeight = UITableView.automaticDimension
            
            return tableView

          }()

    }
}
