//
//  ViewController.swift
//  CameraPhotoLibrary
//
//  Created by 김영빈 on 2023/03/13.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imgView: UIImageView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController() // UIImagePickerController클래스의 인스턴스
    var captureImage: UIImage! // 촬영 혹은 포토 라이브러리에서 불러온 사진
    var videoURL: URL! // 녹화한 비디오의 URL
    var flagImageSave = false // 이미지 저장 여부
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 사진 촬영
    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) { // 카메라를 사용할 수 있다면
            flagImageSave = true // 이미지 저장을 허용
            
            imagePicker.delegate = self // 델리게이트 설정
            imagePicker.sourceType = .camera // 이미지 피커의 소스 타입 .camera로 설정
            imagePicker.mediaTypes = ["public.image"] // 미디어 타입 설정
            imagePicker.allowsEditing = false // 편집 허용 여부 설정
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            // 카메라 사용 불가 시 경고창 띄우기
            myAlert("Camera inaccessable!!", message: "Application cannot access the camera.")
        }
    }
    
    // 사진 불러오기
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) { // 포토 라이브러리의 사용 가능 여부를 확인
            flagImageSave = false // 이미지 저장을 허용하지 않음
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary // 이미지 피커의 소스 타입 .photoLibrary로 설정
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.allowsEditing = true // 편집 허용 여부 설정
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            // 포토 라이브러리 사용 불가 시 경고창 띄우기
            myAlert("Photo album inaccessable!!", message: "Application cannot access the photo album.")
        }
    }
    
    // 비디오 촬영
    @IBAction func btnRecordVideoFromCamera(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = ["public.movie"] // 비디오 촬영은 미디어 타입 ["public.movie]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Camera inaccessable!!", message: "Application cannot access the camera.")
        }
    }
    
    // 비디오 불러오기
    @IBAction func btnLoadVideoFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["pubilc.movie"]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessable!!", message: "Application cannot access the photo album.")
        }
    }
    
    /* 델리게이트 메서드 구현 */
    // 사용자가 사진이나 비디오를 촬영하거나 포토 라이브러리에서 선택이 끝났을 때 호출되는 델리게이트 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString // 미디어 타입 확인
        
        if mediaType.isEqual(to: "public.image" as String) { // 미디어 타입이 사진(Image)일 경우
            // 사진을 갖고와 captureImage에 저장
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            // flagImageSave가 true이면 가져온 사진을 포토 라이브러리에 저장
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            imgView.image = captureImage // 이미지 뷰 출력
        }
        else if mediaType.isEqual(to: "public.movie" as String) { // 미디어 타입이 비디오(Movie)일 경우
            // flagImageSave가 true이면 활영한 비디오를 가져와 포토 라이브러리에 저장
            if flagImageSave {
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL) // 비디오를 가져옴
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        
        // 현재의 뷰 컨트롤러를 제거 --> 이미지 피커 화면을 제거
        self.dismiss(animated: true, completion: nil)
    }
    
    // 사용자가 사진이나 비디오를 찍지 않고 취소하거나 선택하지 않고 취소하는 경우 호출되는 델리게이트 메서드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 이미지 피커를 제거하고 이전의 뷰로 돌아간다
        self.dismiss(animated: true, completion: nil)
    }
    
    // 문제 발생 시 경고 표시용 메서드
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}

