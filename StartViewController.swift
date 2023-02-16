//
//  StartViewController.swift
//  QuickPressPanel
//
//  Created by t&a on 2023/01/19.
//

import UIKit

// 起動画面
class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AdMobViewModel().admobInit(vc: self)

    }
}
