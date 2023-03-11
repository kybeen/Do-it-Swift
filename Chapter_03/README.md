**[ 세그웨이 지정 방법 ]**
1. **Show** : 기존 뷰 컨트롤러에 새로운 뷰 컨트롤러를 불러올 때 새로운 뷰 컨트롤러가 스택(stack)에 push하면서 활성화 되며, 이전 화면으로 돌아갈 때는 새로운 뷰 컨트롤러가 pop되면서 기존의 뷰 컨트롤러가 활성화 되는 형태
2. **Show Detail** : [Show]와 비슷하지만 push가 아니라 replace(교체)임. 현재 뷰 컨트롤러 스택의 최상단 뷰를 교체한다.
3. **Present Modally** : 새로운 뷰 컨트롤러를 보여 주는 스타일과 화면 전환 스타일을 결정하여 뷰를 모달 형태로 보여준다.
4. **Present As Popover** : 현재 보이는 뷰 컨트롤러 위에 앵커를 가진 팝업 형태로 콘텐츠 뷰를 표시
5. **Custom** : 개발자가 임의로 지정한 동작을 수행


**[ 뷰가 보일 때 호출되는 함수들 ]**
- **ViewDidLoad** : 뷰가 로드되었을 때 호출 (뷰 생성 시 한번만 호출됨)
- **ViewWillAppear** : 뷰가 노출될 준비가 끝났을 때 호출 (뷰가 노출될 때마다 호출)
- **ViewDidAppear** : 뷰가 완전히 보인 후 호출

* ViewDidLoad —> ViewWillAppear —> ViewDidAppear 순으로 호출됨
* 뷰가 전환될 때는 ViewWillAppear —> ViewDidAppear 순