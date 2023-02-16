//
//  ViewController.swift
//  QuickPressPanel
//
//  Created by t&a on 2023/01/18.
//

import UIKit

// MARK: - ゲームプレイ画面
class MainViewController: UIViewController {
    
    // MARK: -　Outlet
    @IBOutlet  weak var collectionView:UICollectionView!
    @IBOutlet  weak var limitNumLabel:UILabel!
    @IBOutlet  weak var timeLabel:UILabel!
    @IBOutlet  weak var countdownLabel:UILabel!
    
    // MARK: -　データ
    private var numbers: [Int] = Array(0..<12)
    private var activeCellNum:Int = Int.random(in: 0..<20)
    private var limitNum:Int = 10
    
    // MARK: - ViewModels
    private let timerViewModel = TimerViewModel()
    private let RecordManager = RecordManagerViewModel()
    private let userDefaultsModel = UserDefaultsViewModel()
    
    
    // MARK: - 必要なデータをセット
    private func updateSetting(){
        let numP = userDefaultsModel.getCurrentPanel()
        limitNumLabel.text = String(numP)
        limitNum = numP
        let numS = userDefaultsModel.getCurrentSquares()
        activeCellNum = Int.random(in: 0..<numS - 1)
        numbers = Array(0..<numS)
    }
    
    // MARK: - 最初のカウントダウン
    private func countdown(){
        countdownLabel.isHidden = false
        var num = 4
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { timer in
            num -= 1
            self.countdownLabel.text = String(num)
            if num == 0 {
                timer.invalidate()
                self.countdownLabel.isHidden = true
                self.timerViewModel.start(self.timeLabel)
            }
        }
    }
    
    // MARK: - 処理
    private func registerRecord(){
        RecordManager.createRecord(time: timerViewModel.time)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countdown()
        updateSetting()
        AdMobViewModel().admobInit(vc: self)
        
    }
    
}

// MARK: - UICollectionView(マス目部分)
extension MainViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    // セル生成
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        let view = cell.contentView.viewWithTag(1)!
        view.backgroundColor = UIColor(named: "GrayColor")
        cell.backgroundColor = UIColor(named: "GrayOpacityColor")
        if activeCellNum == indexPath.row {
            view.backgroundColor = UIColor(named: "MainColor")
            cell.backgroundColor = UIColor(named: "MainOpacityColor")
        }
        return cell
    }
    
    // タップイベント
    func collectionView(_ collectionView: UICollectionView,   didSelectItemAt indexPath: IndexPath) {
        if countdownLabel.isHidden && limitNumLabel.text != "Clear!!!"  {
            if activeCellNum == indexPath.row {
                let numS = userDefaultsModel.getCurrentSquares()
                activeCellNum = Int.random(in: 0..<numS - 1)
                collectionView.reloadData()
                limitNum -= 1
                limitNumLabel.text = String(limitNum)
                if limitNum == 0 {
                    limitNumLabel.text = "Clear!!!"
                    limitNumLabel.textColor = UIColor(named: "MainOpacityColor")
                    timerViewModel.timer.invalidate()
                    registerRecord()
                    showAlert()
                }
            }
        }
    }
}

// MARK: - UICollectionViewSetting
extension MainViewController: UICollectionViewDelegateFlowLayout {
    // 外周余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // Cellのサイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize : CGFloat = 75
        return CGSize(width: cellSize, height: cellSize)
    }
    // 行の最小余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    // 列の最小余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: - AlertView(終了後のレコード表示)
extension MainViewController: UIAdaptivePresentationControllerDelegate{
    private func showAlert(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "modal") as! RecordModalViewController
        nextVC.modalPresentationStyle = .overCurrentContext
        nextVC.newTime = timerViewModel.timeStr
        nextVC.presentationController?.delegate = self
        present(nextVC, animated: true, completion: nil)
        
    }
    
    internal func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        dismiss(animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
