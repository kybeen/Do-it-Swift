//
//  ViewController.swift
//  Audio
//
//  Created by 김영빈 on 2023/03/11.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var audioPlayer: AVAudioPlayer! // AVAudioPlayer 인스턴스 변수
    var audioFile: URL! // 재생할 오디오의 파일명 변수
    let MAX_VOLUME: Float = 10.0 // 최대 볼륨
    var progressTimer: Timer! // 타이머를 위한 변수
    let timePlayerSelector: Selector = #selector(ViewController.updatePlayTime)
    let timeRecordSelector: Selector = #selector(ViewController.updateRecordTime)

    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolume: UISlider!
    
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    @IBOutlet var imgView: UIImageView!
    
    // 녹음을 위한 상수와 변수
    var audioRecorder: AVAudioRecorder!
    var isRecordMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 녹음/재생 모드에 따라 다르게 처리
        selectAudioFile()
        if !isRecordMode {
            initPlay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        } else {
            initRecord()
            
        }
        
        imgView.image = UIImage(named: "pause.png")
    }
    
    // 녹음/재생 모드에 따라 다른 파일을 선택하기 위한 함수
    func selectAudioFile() {
        if !isRecordMode { // 재생 모드일 때는 오디오 파일인 "Sicilian_Breeze.mp3"가 선택됨
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        } else { // 녹음 모드일 때는 새 파일인 "recordFile.mp4"가 생성됨
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    // 오디오 녹음 초기화 함수
    func initRecord() {
        // 녹음에 대한 설정
        let recordSettings = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32), // 포맷은 'Apple Lossless'
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue, // 음질은 '최대'
            AVEncoderBitRateKey: 320000, // 비트율은 '320,000bps(320kbps)'
            AVNumberOfChannelsKey: 2, // 오디오 채널은 '2'
            AVSampleRateKey: 44100.0] as [String: Any] // 샘플률은 '44,100Hz'
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        
        audioRecorder.delegate = self
        
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(0)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(play: false, pause: false, stop: false)
        
        let session = AVAudioSession.sharedInstance() // AVAudioSession의 인스턴스 생성
        do { // 카테고리 설정 및 액티브 설정
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print("Error-setCategory : \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("Error-setActive : \(error)")
        }
    }
    
    // 오디오 재생 초기화 함수
    func initPlay() {
        // AVAudioPlayer 함수는 AVAudioPlayer(contentsOf: URL) throws의 형태를 가지는 오류가 발생할 수 있는 함수이기 때문에 오디오 파일이 없을 때의 예외처리를 위해 do-try-catch문 사용
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        
        // 오디오를 재생할 때 필요한 모든 값 초기화
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = slVolume.value
        
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        // 각 버튼 활성화 제어 (처음에는 재생 버튼만 활성화)
        setPlayButtons(play: true, pause: false, stop: false)
    }
    
    // 버튼의 동작(활성화) 여부를 설정하는 함수
    func setPlayButtons(play: Bool, pause: Bool, stop: Bool) {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    // 재생 시간을 "00:00" 형태로 바꾸기 위한 함수
    func convertNSTimeInterval2String(_ time:TimeInterval) -> String {
        let min = Int(time/60) // 재생 시간을 나타내는 매개변수인 time값을 60으로 나눈 몫을 사용
        let sec = Int(time.truncatingRemainder(dividingBy: 60)) // time값을 60으로 나눈 나머지 값을 사용
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }

    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(play: false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)  // 재생할 때 타이머가 작동하도록 0.1초 간격으로 타이머를 생성
        imgView.image = UIImage(named: "play.png")
    }
    
    // 재생 시간에 따라 프로그레스 바와 레이블이 바뀌도록 해주는 함수
    @objc func updatePlayTime() {
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime / audioPlayer.duration)
    }
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(play: true, pause: false, stop: true)
        imgView.image = UIImage(named: "pause.png")
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop() // 오디오 중지
        audioPlayer.currentTime = 0 // 오디오의 현재 재생시간 0으로 초기화
        lblCurrentTime.text = convertNSTimeInterval2String(0) // 재생 시간 레이블도 00:00으로 초기화
        setPlayButtons(play: true, pause: false, stop: false)
        progressTimer.invalidate() // 타이머도 무효화 시키기
        pvProgressPlay.progress = 0
        imgView.image = UIImage(named: "stop.png")
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    // 오디오 재생이 끝나면 호출되는 델리게이트 메서드
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate() // 타이머 무효화
        setPlayButtons(play: true, pause: false, stop: false)
    }
    
    // 녹음/재생 모드 전환 스위치 클릭 시
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn { // 스위치를 녹음 모드로 바꾸면
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else { // 스위치를 재생 모드로 바꾸면
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval2String(0)
        }
        
        // 오디오 파일을 선택한 후, 모드에 따라 초기화할 함수를 호출
        selectAudioFile()
        if !isRecordMode {
            initPlay()
        } else {
            initRecord()
        }
    }
    
    @IBAction func btnRecord(_ sender: UIButton) {
        // 'Record' 버튼을 눌렀을 경우, 녹음을 하고 버튼 이름을 'Stop'으로 변경
        if (sender as AnyObject).titleLabel?.text == "Record" {
            audioRecorder.record()
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true) // 녹음할 때 타이머가 작동하도록 0.1초 간격으로 타이머를 생성
            imgView.image = UIImage(named: "record.png")
        } else {
            // 'Stop' 버튼을 눌렀을 경우(녹음을 중단할 경우), 버튼 이름을 'Record'로 변경하고 [Play]버튼을 활성화하고 방금 녹음한 파일로 재생을 초기화해준다.
            audioRecorder.stop()
            progressTimer.invalidate() // 녹음이 중지되면 타이머를 무효화함
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
        }
    }
    
    // 녹음 시간에 따라 시간 표시 레이블을 수정해주는 함수
    @objc func updateRecordTime() {
        lblRecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime)
    }
    
}

