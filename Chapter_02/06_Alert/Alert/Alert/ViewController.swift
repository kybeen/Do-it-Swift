//
//  ViewController.swift
//  Alert
//
//  Created by 김영빈 on 2023/03/07.
//

import UIKit

class ViewController: UIViewController {
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    let imgRemove = UIImage(named: "lamp-remove.png")
    var isLampOn = true
    
    @IBOutlet var lampImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lampImg.image = imgOn
    }

    // [켜기] 버튼 클릭 시
    @IBAction func btnLampOn(_ sender: UIButton) {
        if (isLampOn == true) { // 전구가 켜져 있을 때
            let lampOnAlert = UIAlertController(title: "경고", message: "현재 On 상태입니다.", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "네, 알겠습니다.", style: .default, handler: nil)
            
            lampOnAlert.addAction(onAction)
            present(lampOnAlert, animated: true)
        } else { // 전구가 켜져 있지 않을 때
            lampImg.image = imgOn
            isLampOn = true
        }
    }
    
    // [끄기] 버튼 클릭 시
    @IBAction func btnLampOff(_ sender: UIButton) {
        if (isLampOn == true) { // 전구가 켜져 있을 때
            let lampOffAlert = UIAlertController(title: "램프 끄기", message: "램프를 끄시겠습니까?", preferredStyle: .alert)
//            let offAction = UIAlertAction(title: "네", style: .default, handler: {
//                ACTION in self.lampImg.image = self.imgOff
//                self.isLampOn = false
//            })
            let offAction = UIAlertAction(title: "네", style: .default, handler: {
                ACTION in self.lampImg.image = self.imgOff
                self.isLampOn = false
            })
            let cancelAction = UIAlertAction(title: "아니오", style: .default, handler: nil)
            
            lampOffAlert.addAction(offAction)
            lampOffAlert.addAction(cancelAction)
            present(lampOffAlert, animated: true)
        }
    }
    
    // [제거] 버튼 클릭 시
    @IBAction func btnLampRemove(_ sender: UIButton) {
        let lampRemoveAlert = UIAlertController(title: "램프 제거", message: "램프를 제거하시겠습니까?", preferredStyle: .alert)
        let offAction = UIAlertAction(title: "아니오, 끕니다(off).", style: .default, handler: {
            ACTION in self.lampImg.image = self.imgOff
            self.isLampOn = false
        })
        let onAction = UIAlertAction(title: "아니오, 켭니다(on).", style: .default) {
            ACTION in self.lampImg.image = self.imgOn
            self.isLampOn = true
        }
        let removeAction = UIAlertAction(title: "네, 제거합니다.", style: .destructive) {
            ACTION in self.lampImg.image = self.imgRemove
            self.isLampOn = false
        }
        
        lampRemoveAlert.addAction(offAction)
        lampRemoveAlert.addAction(onAction)
        lampRemoveAlert.addAction(removeAction)
        present(lampRemoveAlert, animated: true)
    }
    
    
}

