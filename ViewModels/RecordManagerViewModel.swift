//
//  RecordManagerViewModel.swift
//  QuickPressPanel
//
//  Created by t&a on 2023/01/20.
//

import UIKit
import RealmSwift
import RxSwift


class RecordManagerViewModel{
    
    // MARK: - Realm
    private var realm = try! Realm()
    
    // MARK: - Models
    private let userDefaultsViewModel = UserDefaultsViewModel()
    
    // MARK: - Cache用
    private var records:Results<TimeRecordModel>? = nil
    
    
    // MARK: - RxSwift
    // イベントの検知と発生を管理する元クラス
    private var subject = PublishSubject<Results<TimeRecordModel>>()
    
    // 外部からイベント検知観測用クラスへ参照できるように
    public var observable :Observable<Results<TimeRecordModel>>{
        return subject.asObservable()
    }
    // MARK: - RxSwift
    

    
    public func createRecord(time:Double){
        try! realm.write {
            let record = TimeRecordModel()
            record.time = time
            record.panel = userDefaultsViewModel.getCurrentPanel()
            record.squares = userDefaultsViewModel.getCurrentSquares()
            
            realm.add(record)
            
        }
    }
    
    
    public func roadRecord(){
        self.records = realm.objects(TimeRecordModel.self).sorted(byKeyPath: "time",ascending: true)
        subject.onNext(self.records!)
    }
    
    public func filterPanelRecord(panel:Int){
        subject.onNext(self.records!.filter("panel == %@",panel).sorted(byKeyPath: "time",ascending: true))
    }
    
//    func filterSquaresRecord(squares:String){
//        records = self.records!.filter("squares == %@",squares).sorted(byKeyPath: "time",ascending: true)
//    }
    
    
    public func resetRecord(){
        try! realm.write {
            let timeRecords = realm.objects(TimeRecordModel.self)
            realm.delete(timeRecords)
        }
    }
}

extension RecordManagerViewModel{
    // MARK: - Error
    enum crudError:Error{
        case EmptyError
    }
    // MARK: - Error
}
