//
//  SquareTableViewController.swift
//  QuickPressPanel
//
//  Created by t&a on 2023/01/30.
//

import UIKit

// MARK: - マス目数変更
class SquareTableViewController: UITableViewController {
    
    // MARK: - Current
    private let squareNum:Array<Int> = TimeRecordModel.squareNum
    
    // MARK: - Models
    private let userDefaultsViewModel = UserDefaultsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AdMobViewModel().admobInit(vc: self)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return squareNum.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 現在のマス目行数にチェックマークを付与
        let cell = UITableViewCell(style: .default, reuseIdentifier: "squareCell")
        let selectNum = self.squareNum[indexPath.row]
        cell.textLabel?.text = String(selectNum)
        cell.accessoryType = .none
        if selectNum == userDefaultsViewModel.getCurrentSquares(){
            cell.accessoryType = .checkmark
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 選択された行数のマス目を反映
        let selectPanel = self.squareNum[indexPath.row]
        userDefaultsViewModel.setCurrentSquares(selectPanel)
        tableView.reloadData()
    }
}
