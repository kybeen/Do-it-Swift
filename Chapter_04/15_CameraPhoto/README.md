## 15 카메라와 포토 라이브러리에서 미디어 가져오기
----

**[ 카메라와 포토 라이브러리 사용하기 ]**
- MobileCoreServices : iOS에서 사용할 모든 데이터 타입들이 정의되어 있는 헤더 파일이 모여 있다.
```
// 미디어 타입을 사용하기 위해 임포트
import MobileCoreServices
```
----


**[ 델리게이트 프로토콜 선언 ]**
- ImagePickerController를 사용하기 위한 델리게이트 프로토콜을 선언해준다.
```
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
```


----
**[ 선언 변수 ]**
```
let imagePicker: UIImagePickerController! = UIImagePickerController() // UIImagePickerController클래스의 인스턴스
var captureImage: UIImage! // 촬영 혹은 포토 라이브러리에서 불러온 사진
var videoURL: URL! // 녹화한 비디오의 URL
var flagImageSave = false // 이미지 저장 여부
```


----
**[ 사진/비디오 촬영/불러오기 시 ]**
- 사진 : 미디어 타입은 **[“public.image”]**
- 비디오 :  미디어 타입은 **[“public.movie”]**
- 촬영 시 : 사용 가능 여부와 이미지 피커의 소스 타입은 **.camera**로 체크
- 불러오기 시 : 사용 가능 여부와 이미지 피커의 소스 타입은 **.photoLibrary**로 체크


- 예시 코드는 [사진 촬영]의 경우
```
// 사진 촬영
@IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
    if (UIImagePickerController.isSourceTypeAvailable(.camera)) { // 카메라의 사용 가능 여부를 확인
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
```


----
**[ 델리게이트 메서드 구현 ]**
- 다음의 2가지 델리게이트 메서드를 구현해준다.

- **didFinishPickingMediaWithInfo** : 사용자가 사진이나 비디오를 촬영하거나 포토 라이브러리에서 선택이 끝났을 때 호출되는 델리게이트 메서드
```
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString // 미디어 타입 확인
    
    if mediaType.isEqual(to: "public.image" as String) { // 미디어 타입이 사진(Image)일 경우
        // 사진을 갖고와 captureImage에 저장
        captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        // flagImageSave가 true이면 가져온 사진을 포토 라이브러리에 저장
        if flagImageSave {
            UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
        }
    }
    else if mediaType.isEqual(to: "public.movie" as String) { // 미디어 타입이 비디오(Movie)일 경우
        // flagImageSave가 true이면 활영한 비디오를 가져와 포토 라이브러리에 저장
        if flagImageSave {
            videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
            UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
        }
    }
    
    // 현재의 뷰 컨트롤러를 제거 --> 이미지 피커 화면을 제거
    self.dismiss(animated: true, completion: nil)
}
```
- **imagePickerControllerDidCancel** : 사용자가 사진이나 비디오를 찍지 않고 취소하거나 선택하지 않고 취소하는 경우 호출되는 델리게이트 메서드
```
func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
	// 이미지 피커를 제거하고 이전의 뷰로 돌아간다
    self.dismiss(animated: true, completion: nil)
}
```


----
**[ 핸드폰 빌드 시 권한 설정 ]**
  <img width="512" alt="image" src="https://user-images.githubusercontent.com/89764127/224550725-fde0607c-512a-4ae0-ae43-79af069b390d.png">