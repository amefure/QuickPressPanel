//
//  UserDefaultsViewModels.swift
//  QuickPressPanel
//
//  Created by t&a on 2023/01/20.
//

import UIKit

class UserDefaultsViewModel {
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Panel set/get
    public func setCurrentPanel(_ panel:Int){
        userDefaults.set(panel, forKey: "CurrentPanel")
    }
    
    public func getCurrentPanel() -> Int {
        let panel = userDefaults.integer(forKey:"CurrentPanel")
        if panel == 0 {
            return TimeRecordModel.panelNum[0]
        }else{
            return panel
        }
    }
    
    // MARK: - Squares set/get
    public func setCurrentSquares(_ panel:Int){
        userDefaults.set(panel, forKey: "CurrentSquares")
    }
    
    public func getCurrentSquares() -> Int {
        let squares = userDefaults.integer(forKey:"CurrentSquares")
        if squares == 0 {
            return TimeRecordModel.squareNum[1]
        }else{
            return squares
        }
    }

}
