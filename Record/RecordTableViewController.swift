//
//  RecordTableViewController.swift
//  QuickPressPanel
//
//  Created by t&a on 2023/01/22.
//

import UIKit
import RxSwift
import RealmSwift

// MARK: -　レコードテーブル
class RecordTableViewController: UIViewController {
    
    // MARK: -　ViewModels
    private var RecordManagerVM = RecordManagerViewModel()
    
    // MARK: - Outlet
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var segmented:UISegmentedControl!
    
    // MARK: - 表示するデータ
    private var currentRecords:Results<TimeRecordModel>? = nil
    
    // MARK: - RxSwiftゴミ箱
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdMobViewModel().admobInit(vc: self)
        
        setUpSegmented()
        
        RecordManagerVM.observable.subscribe { results in
            self.currentRecords = results
        }.disposed(by: disposeBag)
        RecordManagerVM.roadRecord()
        
    }
    
    private func setUpSegmented(){
        let params:Array<Int> = TimeRecordModel.panelNum
        segmented.setTitle("All", forSegmentAt: 0)
        for index in 0..<params.count {
            segmented.setTitle(String(params[index]), forSegmentAt:index + 1)
        }
        segmented.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    @objc func segmentChanged() {
        let selectedIndex = segmented.selectedSegmentIndex
        var params:Array<Int> = TimeRecordModel.panelNum
        if selectedIndex != 0{
            let num = params[selectedIndex - 1]
            RecordManagerVM.filterPanelRecord(panel: num)
        }else{
            RecordManagerVM.roadRecord()
        }
        tableView.reloadData()
    }
    
}


// MARK: - UITableView
extension RecordTableViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.currentRecords != nil{
            return self.currentRecords!.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        cell.create(num: indexPath.row + 1, time: self.currentRecords![indexPath.row].timeString)
        return cell
    }
}

