//
//  TimeRecordModels.swift
//  QuickPressPanel
//
//  Created by t&a on 2023/01/20.
//

import UIKit
import RealmSwift

class TimeRecordModel: Object,ObjectKeyIdentifiable {
    
    // MARK: - RealmDB
    @Persisted(primaryKey: true) var id:ObjectId
    @Persisted var time:Double
    @Persisted var panel:Int
    @Persisted var squares:Int
    @Persisted var date:Date = Date()
    
    // MARK: - 時間表示
    public var timeString:String {
        let milliSecond = Int(self.time * 100) % 100
        let second = Int(self.time) % 60
        let minutes = Int(self.time / 60)
        return String(format: "%02d:%02d:%02d", minutes, second, milliSecond)
    }
    
    // MARK: - パネル数
    static let panelNum:Array<Int> = [20,50,100]
    
    // MARK: - マス目の数
    static var squareNum:Array<Int> {
        // iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            return [55,77,99]
        }
        
        let deviceHeight = UIScreen.main.bounds.height
        if deviceHeight < 736 {
            // SE Size
            return [8,12,16]
        }else{
            // X Size
            return [12,16,20]
        }
    }
    
    
}
