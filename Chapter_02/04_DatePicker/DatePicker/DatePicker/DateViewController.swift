//
//  ViewController.swift
//  DatePicker
//
//  Created by 김영빈 on 2023/03/06.
//

import UIKit

class DateViewController: UIViewController {
    let timeSelector: Selector = #selector(DateViewController.updateTime) // 타이머가 구동되면 실행할 함수
    let interval = 1.0 // 타이머 간격
    var count = 0 // 타이머가 설정한 간격대로 실행되는지 확인하기 위한 변수
    
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE" // 년-월-일 시:분:초 요일
        // 데이트 피커에서 선택한 날짜를 formatter의 date Format에서 설정한 포맷대로 string 메서드를 사용해서 문자열로 변환한다.
        lblPickerTime.text = "선택시간 : \(formatter.string(from: datePickerView.date))"
    }
    
    // Swift4에서는 #selector()의 인자로 사용될 메서드를 선언할 때 Objective-C와의 호환성을 위해 함수 앞에 반드시 @objc 키워드를 붙여야 함
    @objc func updateTime() {
//        lblCurrentTime.text = String(count)
//        count = count + 1
        
        let date = NSDate() // 현재 시간 갖고오기
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시간 : \(formatter.string(from: date as Date))"
    }
}

