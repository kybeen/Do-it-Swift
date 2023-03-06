//
//  ViewController.swift
//  03_Mission
//
//  Created by 김영빈 on 2023/03/06.
//

import UIKit

class ViewController: UIViewController {
    var imgIndex = 1
    var minIndex = 1
    var maxIndex = 6
    
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgView.image = UIImage(named: "1.png")
    }

    @IBAction func movePrev(_ sender: UIButton) {
        if imgIndex == minIndex {
            
        } else {
            imgIndex -= 1
            imgView.image = UIImage(named: "\(imgIndex).png")
        }
    }
    
    @IBAction func moveNext(_ sender: UIButton) {
        if imgIndex == maxIndex {
            
        } else {
            imgIndex += 1
            imgView.image = UIImage(named: "\(imgIndex).png")
        }
    }
}

