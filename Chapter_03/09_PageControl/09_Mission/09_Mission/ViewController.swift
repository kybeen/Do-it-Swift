//
//  ViewController.swift
//  09_Mission
//
//  Created by 김영빈 on 2023/03/09.
//

import UIKit

class ViewController: UIViewController {
    let pages = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    @IBOutlet var pageLabel: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        pageLabel.text = String(pages[pageControl.currentPage])
    }
    
}

