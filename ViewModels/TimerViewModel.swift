//
//  TimerViewModel.swift
//  QuickPressPanel
//
//  Created by t&a on 2023/01/19.
//

import UIKit

class TimerViewModel {
    public var timer:Timer
    public var time:Double = 0.0
    public var timeStr:String = ""
    
    init() {
        timer = Timer()
    }
    
    public func start(_ view:UILabel){
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [self] _ in
            self.time += 0.01
            let milliSecond = Int(self.time * 100) % 100
            let second = Int(self.time) % 60
            let minutes = Int(self.time / 60)
            timeStr = String(format: "%02d:%02d:%02d", minutes, second, milliSecond)
            view.text = timeStr
        })
       
    }

}
