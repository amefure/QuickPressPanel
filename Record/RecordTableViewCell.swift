//
//  RecordTableViewCell.swift
//  QuickPressPanel
//
//  Created by t&a on 2023/01/23.
//

import UIKit

// MARK: -　レコードテーブルカスタムセル
class RecordTableViewCell: UITableViewCell {
    
    // MARK: -　Outlet
    @IBOutlet weak var rankingLable:UILabel!
    @IBOutlet weak var timeLable:UILabel!
    
    // MARK: -　生成メソッド
    public func create(num:Int,time:String){
        
        rankingLable.text = String(num)
        timeLable.text = time
        // MARK: - rankingLable
        setUpLabel(num)
    }
    
    // MARK: - rankingLable
    private func setUpLabel(_ num:Int){
        rankingLable.backgroundColor = .clear
        if num == 1 {
            // 1~3 金銀銅に配色
            rankingLable.backgroundColor = UIColor(red: 218/255, green: 180/255, blue: 19/255, alpha: 1)
        }else if num == 2 {
            rankingLable.backgroundColor = UIColor(red: 110/255, green: 123/255, blue: 132/255, alpha: 1)
        }else if num == 3 {
            rankingLable.backgroundColor = UIColor(red: 160/255, green: 84/255, blue: 26/255, alpha: 1)
        }
        rankingLable.layer.opacity = 0.9
        rankingLable.layer.cornerRadius = 3
        rankingLable.clipsToBounds = true
    }
    
    // MARK: - 新規レコード追加時の色チェンジ
    public func addRecordTextColorChange(_ time:String){
        if timeLable.text == time {
            timeLable.textColor = .orange
        }else{
            timeLable.textColor = .white
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
