## 14 비디오 재생 앱 만들기
====
```
import AVKit
```

**[ AVPlayerViewController ]**
- 비디오 파일 재생을 지원해주는 객체
----

**[ 앱 내부의 비디오 파일 재생하기 ]**
- 파일의 경로를 NSURL 객체로 불러오고 AVPlayerViewController와 AVPlayer 인스턴스를 만들어서 재생해준다.
```
        let filePath: String? = Bundle.main.path(forResource: “파일명”, ofType: “확장자명”)
        let url = NSURL(fileURLWithPath: filePath!)

        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        
        playerController.player = player
        
        self.present(playerController, animated: true) {
            player.play()
        }
```
----
**[ 앱 외부의 URL로 비디오 재생하기 ]**
- 외부의 비디오 URL을 NSURL 객체로 불러오고 AVPlayerViewController와 AVPlayer 인스턴스를 만들어서 재생해준다.
```
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks.mp4")!

        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        
        playerController.player = player
        
        self.present(playerController, animated: true) {
            player.play()
        }
```