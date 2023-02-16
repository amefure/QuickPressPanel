//
//  RecordModalViewController.swift
//  QuickPressPanel
//
//  Created by t&a on 2023/02/06.
//

import UIKit
import RxSwift
import RealmSwift

// MARK: -　ゲーム終了後のモーダル画面
class RecordModalViewController: UIViewController ,UIAdaptivePresentationControllerDelegate {
    
    // MARK: -　Outlet
    @IBOutlet weak var foundationView:UIView!
    @IBOutlet weak var timeLabel:UILabel!
    // MARK: -　ViewModels
    private var RecordManagerVM = RecordManagerViewModel()
    // MARK: - 表示するデータ
    private var currentRecords:Results<TimeRecordModel>? = nil
    
    // MARK: - 新しいタイムを受け取る
    public var newTime:String = ""
    
    // MARK: - RxSwiftゴミ箱
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 購読開始
        RecordManagerVM.observable.subscribe { results in
            self.currentRecords = results
        }.disposed(by: disposeBag)
        
        RecordManagerVM.roadRecord()
        timeLabel.text = newTime
    }
    
    // MARK: -　終了→画面遷移　閉じる処理はMainViewに委任
    @IBAction func TappedOKButton(){
        if let presentationController = presentationController{
            presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
        }
    }
    
    
}

// MARK: - UITableView
extension RecordModalViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.currentRecords != nil{
            return self.currentRecords!.count
        }else{
            return 0
        }
        
    }
    
    // セル
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        cell.create(num: indexPath.row + 1, time: self.currentRecords![indexPath.row].timeString)
        cell.addRecordTextColorChange(newTime)
        return cell
    }
    
}
