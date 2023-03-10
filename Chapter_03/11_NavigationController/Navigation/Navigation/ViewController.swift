//
//  ViewController.swift
//  Navigation
//
//  Created by 김영빈 on 2023/03/10.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    
    let imgOn = UIImage(named: "lamp_on.png")
    let imgOff = UIImage(named: "lamp_off.png")
    let scale: CGFloat = 2.0
    var isOn = true
    var isZoom = false

    @IBOutlet var txMessage: UITextField!
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn
    }

    // 해당 세그웨이가 해당 뷰 컨트롤러로 전환되기 직전에 호출되는 함수 (데이터 전달을 위해 사용)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as! EditViewController
        if segue.identifier == "editButton" {
            // 버튼을 클릭한 경우
            editViewController.textWayValue = "segue : use button"
        } else if segue.identifier == "editBarButton" {
            // 바 버튼을 클릭한 경우
            editViewController.textWayValue = "segue : use Bar button"
        }
        // EditViewController에 ViewController의 텍스트 필드와 전구 상태값을 전달
        editViewController.textMessage = txMessage.text!
        editViewController.isOn = isOn
        editViewController.isZoom = isZoom
        
        editViewController.delegate = self // 델리게이트 설정
    }
    
    // EditViewController의 메세지를 ViewController에 전달해줌
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txMessage.text = message
    }
    // EditViewController의 전구 점등 여부를 ViewController에 전달해줌
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        if isOn {
            imgView.image = imgOn
            self.isOn = true
        } else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
    // EditViewController의 전구 확대 여부를 ViewController에 전달해줌
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool) {
        var newWidth: CGFloat, newHeight: CGFloat
        
        if isZoom {
            newWidth = imgView.frame.width / scale
            newHeight = imgView.frame.height / scale
        } else {
            newWidth = imgView.frame.width * scale
            newHeight = imgView.frame.height * scale
        }
        
        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
        self.isZoom = !self.isZoom
    }
}

