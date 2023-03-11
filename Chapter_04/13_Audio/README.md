## 13 음악 재생하고 녹음하기
```
import AVFoundation
```
----

**[ AVAudioPlayer ]**
- 오디오 파일을 재생할 수 있도록 지원해주는 객체
- AVAudioPlayerDelegate 프로토콜 상속 필요

**[ AVAudioRecorder ]**
- 오디오 녹음을 지원해주는 객체
- AVAudioRecorderDelegate 프로토콜 상속 필요
——

- 오디오를 재생하려면 **’초기화’** 단계를 거쳐야 한다.
- 초기화란 오디오를 재생하기 위한 준비 과정뿐만 아니라 재생 시간을 맨 처음으로 돌리고 버튼의 활성화 또는 비활성화를 설정하는 과정까지 말한다.
