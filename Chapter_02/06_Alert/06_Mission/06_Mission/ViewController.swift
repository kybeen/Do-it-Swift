//
//  ViewController.swift
//  06_Mission
//
//  Created by 김영빈 on 2023/03/07.
//

import UIKit

class ViewController: UIViewController {
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    var currentTimeForComp: String!
    var selectedTimeForComp: String!
    var isAlarmed = false
    
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var selectedTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        let formatterForComp = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        formatterForComp.dateFormat = "HH:mm aaa"
        selectedTimeLabel.text = "선택시간 : \(formatter.string(from: datePickerView.date))"
        selectedTimeForComp = formatterForComp.string(from: datePickerView.date)
        isAlarmed = false
    }
    
    @objc func updateTime() {
        let date = NSDate()
        let formatter = DateFormatter()
        let formatterForComp = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        formatterForComp.dateFormat = "HH:mm aaa"
        currentTimeLabel.text = "현재시간 : \(formatter.string(from: date as Date))"
        currentTimeForComp = formatterForComp.string(from: date as Date)
        
        if (selectedTimeForComp == currentTimeForComp) && (isAlarmed == false) {
            let alarmAlert = UIAlertController(title: "알림", message: "설정된 시간입니다 !!!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "네, 알겠습니다.", style: .default)
            alarmAlert.addAction(okAction)
            present(alarmAlert, animated: true)
            isAlarmed = true
        }
    }
}

