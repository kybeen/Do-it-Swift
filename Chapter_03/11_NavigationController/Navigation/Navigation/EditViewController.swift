//
//  EditViewController.swift
//  Navigation
//
//  Created by 김영빈 on 2023/03/10.
//

import UIKit

// 델리게이트 프로토콜 정의
protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool)
}

class EditViewController: UIViewController {
    // 받아온 문자를 아울렛 변수에 적용시키기 위한 변수
    var textWayValue: String = ""
    var textMessage: String = ""
    var delegate: EditDelegate? // EditDelegate를 갖는 델리게이트 변수
    var isOn = false
    var isZoom = false
    
    @IBOutlet var lblWay: UILabel!
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var swIsOn: UISwitch!
    @IBOutlet var btnZoom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txMessage.text = textMessage
        swIsOn.isOn = isOn    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        // EditViewController의 텍스트 필드 내용을 message 문자열로 전달하여 ViewController로 보내줌
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: txMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
            delegate?.didImageZoomDone(self, isZoom: isZoom)
        }
        
        _ = navigationController?.popViewController(animated: true) // show 방식의 segue로 이동했기 때문에 이전 화면으로 돌아가기 위해 popViewController 해준다.
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
    }
    
    @IBAction func swImageZoom(_ sender: UIButton) {
        isZoom = !isZoom
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
