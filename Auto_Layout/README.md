## 오토 레이아웃 (Auto Layout)
- 오토 레이아웃을 적용하면 서로 다른 기종에서도 같은 비율의 화면을 볼 수 있다.
  - 왼쪽: 아이폰 14 Pro
  - 오른쪽 : 아이폰 SE (3세대)

<img width="200" alt="image" src="https://user-images.githubusercontent.com/89764127/224477803-cb276822-8377-4723-997b-4113b268c5d0.png">  <img width="200" alt="image" src="https://user-images.githubusercontent.com/89764127/224477835-e3f00a5e-f32f-4bbc-ac1b-9dc96ab2b052.png">


-----

- 보조 편집기에서 **[ Command + Option + Enter ]** 커맨드를 입력해서 미리보기 창을 볼 수 있다.
- 기기별로 미리보기 화면을 통해 화면 레이아웃을 비교할 수 있다.
  <img width="1396" alt="image" src="https://user-images.githubusercontent.com/89764127/224471801-9964e3a2-71e9-49d4-8373-47e5c416a7ee.png">

----
- 오토 레이아웃은 각 객체마다 제약 조건(constraints)을 설정하여 사용한다.
- 제약 조건은 스토리보드 하단의 정렬 조건 아이콘과 제약 조건 아이콘을 클릭하여 설정할 수 있다.
<img width="152" alt="스크린샷 2023-03-11 오후 4 39 23" src="https://user-images.githubusercontent.com/89764127/224471934-8c417049-4708-4419-a7a8-04c54760ac72.png">

----
### 스택 뷰 (Stack View)
- 객체가 많을 때는 고려해야 할 요소들이 많기 때문에 레이아웃을 설정하기 어렵다.
- 이 때 쉽게 사용할 수 있는 객체가 스택 뷰!!
- 스택 뷰는 별다른 제약 조건을 사용하지 않아도 내부 객체들을 원하는 모양으로 정렬할 수 있다.
- **[ 가로 스택 뷰 / 세로 스택 뷰 ]** 로 나뉨
- 스택 뷰는 중첩해서 사용 가능
<img width="778" alt="image" src="https://user-images.githubusercontent.com/89764127/224477580-6bd61123-5b85-4fdf-af32-625112a6fe06.png">
