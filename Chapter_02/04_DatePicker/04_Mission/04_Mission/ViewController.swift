//
//  ViewController.swift
//  04_Mission
//
//  Created by 김영빈 on 2023/03/06.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentTime: UILabel!
    @IBOutlet var pickerTime: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    
    let interval = 1.0
    let timeSelector: Selector = #selector(ViewController.updateTime)
    
    // 시:분 비교를 위한 문자열
    var pickerTimeForComp: String!
    var currentTimeForComp: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        let formatterForComp = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        formatterForComp.dateFormat = "hh:mm aaa"
        pickerTimeForComp = formatterForComp.string(from: datePickerView.date)
        pickerTime.text = "선택시간 : \(formatter.string(from: datePickerView.date))"
    }
    
    @objc func updateTime() {
        let date = NSDate()
        
        let formatter = DateFormatter()
        let formatterForComp = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        formatterForComp.dateFormat = "hh:mm aaa"
        currentTimeForComp = formatterForComp.string(from: date as Date)
        currentTime.text = "현재시간 : \(formatter.string(from: date as Date))"
        
        // 시:분이 같으면 빨간색으로
        if (pickerTimeForComp == currentTimeForComp) {
            view.backgroundColor = UIColor.red
        } else { // 시:분이 다르면 흰색으로
            view.backgroundColor = UIColor.white
        }
    }

}

