//
//  PanelTableViewController.swift
//  QuickPressPanel
//
//  Created by t&a on 2023/01/30.
//

import UIKit

// MARK: - パネル数変更
class PanelTableViewController: UITableViewController {
    
    // MARK: - Current
    private let panelNum:Array<Int> = TimeRecordModel.panelNum
    
    // MARK: - Models
    private let userDefaultsViewModel = UserDefaultsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        AdMobViewModel().admobInit(vc: self)
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return panelNum.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 現在のパネル行数にチェックマークを付与
        let cell = UITableViewCell(style: .default, reuseIdentifier: "panelCell")
        let selectNum = self.panelNum[indexPath.row]
        cell.textLabel?.text = String(selectNum)
        cell.accessoryType = .none
        if selectNum == userDefaultsViewModel.getCurrentPanel(){
            cell.accessoryType = .checkmark
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 現在のパネル行数にチェックマークを付与
        let selectPanel = self.panelNum[indexPath.row]
        userDefaultsViewModel.setCurrentPanel(selectPanel)
        tableView.reloadData()
    }
}
