//
//  ViewController.swift
//  MoviePlayer
//
//  Created by 김영빈 on 2023/03/11.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 내부 파일 mp4 재생 함수
    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        let filePath: String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4") // 비디오 파일명을 사용하여 비디오가 저장된 앱 내부의 파일 경로를 받아온다.
        let url = NSURL(fileURLWithPath: filePath!) // 앱 내부의 파일명을 NSURL 형식으로 변경
        
        playVideo(url: url)
    }
    
    // 외부 파일 mp4 재생 함수
    @IBAction func btnPlayExternalMovie(_ sender: UIButton) {
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks.mp4")!
        
        playVideo(url: url)
    }
    
    private func playVideo(url: NSURL) {
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        // 비디오 재생
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}

