//
//  SettingViewController.swift
//  QuickPressPanel
//
//  Created by t&a on 2023/01/27.
//

import UIKit

// MARK: - 設定ビュー
class SettingTableViewController: UITableViewController {
    
    // MARK: - ViewModels
    private let RecordManager = RecordManagerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AdMobViewModel().admobInit(vc: self)
    }
    
    // MARK: - テーブル選択時の画面遷移と処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // 0 パネル数変更
        // 1 マス目数変更
        // 2 シェア
        // 3 記録データリセット
        if indexPath.row == 0 {
            let nextVC = storyboard.instantiateViewController(withIdentifier: "PanelTableView")
            navigationController?.pushViewController(nextVC, animated: true)
        } else if indexPath.row == 1 {
            let nextVC = storyboard.instantiateViewController(withIdentifier: "SquareTableView")
            navigationController?.pushViewController(nextVC, animated: true)
        } else if indexPath.row == 2 {
            let application = UIApplication.shared
            application.open(URL(string: "https://apps.apple.com/jp/app/quickpresspanel/id1670369210?action=write-review")!)
        } else if indexPath.row == 3 {
            showAlert()
        }
    }
    
    // MARK: - 記録データリセット
    private func showAlert(){
        let alert = UIAlertController(title: "確認", message: "記録をリセットしますか？", preferredStyle: .alert)
        let delete = UIAlertAction(title: "削除", style: .destructive) { action in
            self.RecordManager.resetRecord()
            let confirmAlert = UIAlertController(title: "Success!", message: "記録をリセットしました。",preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            confirmAlert.addAction(ok)
            self.present(confirmAlert, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel)
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
