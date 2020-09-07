# 퀵코덕(QuickCoduck)
Spring Framework로 구현 된 개발자를위한 아웃소싱 (매칭 시스템) 및 코드 커뮤니티 웹 사이트<br>
[Outsourcing (matching system) and code community website for developers implemented with Spring Framework]

## 프로젝트 환경
 - Spring Framework
 - Maven
 - Java 8
 
## 기술 스택
 - Spring Framework
 - Maven
 - Java 8
 - MariaDB
 - Mybatis
 - SQL
 - JSP
 - Javascript
 - jQuery
 - Ajax
 - Html
 - CSS
 - Sitemesh
 - W3
 
 ## 공헌한 부분
 - 팀 프로젝트 팀장 역할
 - 프로젝트 버전 관리(github)
 - 의견 조율 및 팀원(4人)별 능력에 맞춘 개발 파트 지시
 - DB설계
 - 오픈소스/프로젝트 게시판 개발
 - 개발자&클라이언트 별점 평가 기능 개발
 - 개발자&클라이언트 프로젝트 진행 기능 개발
 - 인재(개발자) 매칭 기능 개발
 
## 구현 설명

#### (아래의 '실제 페이지'부분을 참고하시면 이해가 쉽습니다.)
1. 메인화면에서 슬라이드를 통해 게시판을 보여주도록 구현하였습니다.
2. 자유게시판을 제외한 게시판에서 체크박스와 Ajax을통한 기술별 게시글 검색이
가능하도록 구현하였습니다.
3. 사용자의 타입을 줘서 1.개발자, 2.클라이언트 3,관리자의 구분을 하였습니다.
4. 자유게시판에서 관리자타입의 글쓰기를 통해 공지사항을 구현하였습니다.
5. 마이페이지에서는 사용자의 개인정보를 수정할 수 있고, 맘에 드는 오픈소스를
저장하거나 개인소스를 관리하는 나만의소스 게시판이 있습니다.
6. 개발자의 경우 내가 지원한 프로젝트와 스크랩한프로젝트, 지원프로젝트의
수락거절 여부, 진행중인 프로젝트, 완료한프로젝트를 볼 수 있습니다.
7. 클라이언트의 경우 내가 등록한 프로젝트를 볼 수 있고, 진행중인 프로젝트와
완료한 프로젝트를 볼 수 있습니다.
8. 프로젝트가 완료되면 개발자와 클라이언트 상호간에 평가를 할 수 있도록 하고
개인정보에서 별점을 통해 보여주도록 구현하였습니다.
9. 클라이언트가 공고 모집글을 등록 할 경우 매칭인재를 받아볼 수 있도록
프로젝트에 필요로 하는 기술목록과 일치하고 평점이 높은 개발자를 추천해서
보여주고 선택할 수 있도록 구현하였습니다.

 
 ## 실제 페이지
 
 <details>
<summary>공통 페이지</summary>
<div markdown="1">
 
 ### 시작 페이지
 ![시작페이지](https://user-images.githubusercontent.com/46177529/92350454-13ad8400-f114-11ea-9285-b9b51c2dabdb.png)

 ### 회원가입 (User, Client 선택가능) : 해당 캡쳐는 양식에 맞추지 않고 진행 했을 경우
 ![회원가입](https://user-images.githubusercontent.com/46177529/92350537-45bee600-f114-11ea-900e-c6e3e9195f03.png)

 ### 로그인
 ![로그인](https://user-images.githubusercontent.com/46177529/92350560-4f484e00-f114-11ea-85f6-39b1c156299a.png)

 ### 메인 (인기소스, 인기프로젝트) : 스크랩/Duck, 조회수 등을 참고하여 순위 설정
 ![메인인기소스](https://user-images.githubusercontent.com/46177529/92350571-57a08900-f114-11ea-8dd5-542d38155263.png)
 ---
 ![메인인기프로젝트](https://user-images.githubusercontent.com/46177529/92350582-5ec79700-f114-11ea-879d-693b2216f373.png)


 ### 게시판 (오픈소스, 프로젝트공고, 자유) : 로그인 이후 이용 가능, 좌측 체크박스를 클릭할 시 Ajax 요청&응답에 의해 게시글 목록 Update
 ![오픈소스게시판](https://user-images.githubusercontent.com/46177529/92350592-66873b80-f114-11ea-852d-9bd9aff24d91.png)
 ---
 ![프로젝트공고게시판](https://user-images.githubusercontent.com/46177529/92350603-6d15b300-f114-11ea-8d99-35198109d306.png)
 ---
 ![자유게시판](https://user-images.githubusercontent.com/46177529/92351078-b4e90a00-f115-11ea-86c8-728a7a85ecb9.PNG)
</div>
</details>


 <details>
<summary>개발자 페이지</summary>
<div markdown="1">
 
 ### 마이페이지 - 퀵코덕 통계 + 클라이언트가 평가한 개인 별점
![개발자마이페이지](https://user-images.githubusercontent.com/46177529/92351566-02b24200-f117-11ea-8f53-792ee5e9d576.png)
 ### 회원정보 보기
![회원정보](https://user-images.githubusercontent.com/46177529/92351578-05ad3280-f117-11ea-9beb-ab19c7f81311.png)
 ### 회원정보 수정
![개발자정보수정](https://user-images.githubusercontent.com/46177529/92351568-034ad880-f117-11ea-935a-bafaebbf2fd8.png)
 ### 나만의 소스보기 - Private 하게 관리 할 수 있는 게시판
![나만의소스](https://user-images.githubusercontent.com/46177529/92351570-03e36f00-f117-11ea-933f-8c79c5880901.png)
 ### Duck(스크랩)한 오픈소스 - 오픈 소스 중에서 Duck(스크랩)을 진행 한 오픈소스
 ![Duck(스크랩)한오픈소스](https://user-images.githubusercontent.com/46177529/92351564-01811500-f117-11ea-9971-f645b5c665ad.png)
 ### 관심(스크랩)한 프로젝트 - 프로젝트 공고 중에서 스크랩을 진행 한 프로젝트
![관심(스크랩)프로젝트](https://user-images.githubusercontent.com/46177529/92351569-034ad880-f117-11ea-83a1-b456dd85d0fa.png)
 ### 지원내역 - 프로젝트 공고 중에서 지원신청을 진행 한 프로젝트 모음
![지원내역](https://user-images.githubusercontent.com/46177529/92351574-05149c00-f117-11ea-8bee-dd698aef2f81.png)
 ### 지원선택된 프로젝트 (지원 후 클라이언트가 확인 진행)
![지원선택된프로젝트](https://user-images.githubusercontent.com/46177529/92351576-05149c00-f117-11ea-94d2-85eb2c22b164.png)
 ### 지원탈락된 프로젝트 (지원 후 클라이언트가 취소 진행)
![지원탈락된프로젝트](https://user-images.githubusercontent.com/46177529/92352518-3a21ee00-f119-11ea-97de-ec7ac2d76d97.png)
 ### 제안받은 프로젝트 (인재매칭 시스템에서 클라이언트에게 먼저 제안받은 프로젝트)
![제안받은프로젝트](https://user-images.githubusercontent.com/46177529/92351573-047c0580-f117-11ea-96af-e4868242c758.png)
 ### 진행중인 프로젝트 - 클라이언트의 수락, 해당 프로젝트의 인원이 전부 모였을 경우 진행되는 프로젝트 (개발자는 한번에 한개의 진행중인 프로젝트만 가진다.)
![진행중인프로젝트](https://user-images.githubusercontent.com/46177529/92351577-05ad3280-f117-11ea-8087-a83e525a7743.png)
 ### 완료한 프로젝트 - 클라이언트가 프로젝트 완료를 진행 한 프로젝트
![완료한프로젝트](https://user-images.githubusercontent.com/46177529/92351572-047c0580-f117-11ea-82b5-a199da06be2b.png)
 ### 클라이언트 평가 - 완료 된 프로젝트의 클라이언트를 별점 평가 진행
![완료프로젝트클라이언트평가](https://user-images.githubusercontent.com/46177529/92351571-03e36f00-f117-11ea-954a-f70de26b8683.png)
 
</div>
</details>

 <details>
<summary>클라이언트 페이지</summary>
<div markdown="1">

 ### 마이페이지 - 퀵코덕 통계 + 개발자가 평가한 개인 별점
![클라이언트마이페이지](https://user-images.githubusercontent.com/46177529/92353132-99343280-f11a-11ea-8425-b31169a41abe.png)
 ### 프로젝트 공고 등록 아이템 리스트/구매 - 퀵코덕에 결제 후 정해진 갯수 만큼 프로젝트 공고 등록 가능
![프로젝트공고등록아이템리스트](https://user-images.githubusercontent.com/46177529/92353138-9b968c80-f11a-11ea-8f4a-ff59a257825e.png)
![프로젝트공고등록아이템구매](https://user-images.githubusercontent.com/46177529/92353137-9afdf600-f11a-11ea-90d7-7b7de18e100a.png)
 ### 회원정보 보기
![클라이언트회원정보보기](https://user-images.githubusercontent.com/46177529/92353134-99ccc900-f11a-11ea-84eb-34c9d5cd5de5.png)
 ### 회원정보 수정
![마이페이지정보수정](https://user-images.githubusercontent.com/46177529/92353145-9e917d00-f11a-11ea-84d3-2a9502d3e17f.png)
 ### 추천인재 목록 - 추천인재 매칭 시스템을 통해 요청을 보낸 개발자 전체 목록
![추천받은인재목록](https://user-images.githubusercontent.com/46177529/92353129-976a6f00-f11a-11ea-9d94-d8825c815983.png)
 ### 대기중인 프로젝트 - 개발자 지원을 아직 받고있는 프로젝트
![대기중인프로젝트](https://user-images.githubusercontent.com/46177529/92353144-9df8e680-f11a-11ea-9b93-ccaee323e614.png)
 ### 진행중인 프로젝트 - 개발자 선정이 다 끝난 프로젝트 -> 진행 (클라이언트는 다수의 프로젝트 진행 가능)
![진행중인프로젝트](https://user-images.githubusercontent.com/46177529/92353128-96d1d880-f11a-11ea-9eab-d17cabad041c.png)
 ### 완료한 프로젝트 - 프로젝트 완료를 진행 한 프로젝트
![완료된프로젝트](https://user-images.githubusercontent.com/46177529/92353148-a05b4080-f11a-11ea-8332-eb78cac7dfc2.png)
 ### 개발자 평가 - 완료한 프로젝트 각각의 개발자를 선택하여 별점 평가 진행
![완료된프로젝트참여개발자목록보기](https://user-images.githubusercontent.com/46177529/92353149-a0f3d700-f11a-11ea-9f21-19c3b21a0442.png)
![개발자평가](https://user-images.githubusercontent.com/46177529/92353143-9d605000-f11a-11ea-85f5-04b3f296d37e.png)
 ### 프로젝트 공고 글쓰기 - 클라이언트이고 공고 등록 아이템 개수가 남았을 경우에만 등록가능
![프로젝트공고글쓰기](https://user-images.githubusercontent.com/46177529/92353135-9a655f80-f11a-11ea-8b5e-c473a1627641.png)
 ### 프로젝트 공고 등록 완료 - 공고 등록 후 매칭 인재 시스템을 이용 여부를 결정할 수 있음
![프로젝트공고등록완료](https://user-images.githubusercontent.com/46177529/92353139-9c2f2300-f11a-11ea-90f6-c69322f8aa21.png)
 ### 매칭 유저 리스트 - 해당 프로젝트의 기술스택, 개발자 평점등을 이용한 인재 매칭
![매칭유저리스트](https://user-images.githubusercontent.com/46177529/92353147-9f2a1380-f11a-11ea-9fb3-2f1b7686d04c.png)
 ### 프로젝트 지원자 목록 - 공고를 통해 지원한 개발자 목록
![지원자목록](https://user-images.githubusercontent.com/46177529/92353122-95081500-f11a-11ea-9aca-4fab7471c7b1.png)
 ### 프로젝트 추천 인재 목록 - 매칭 시스템을 통해 요청을 보낸 해당 프로젝트 개발자 목록
![추천인재목록](https://user-images.githubusercontent.com/46177529/92353130-98030580-f11a-11ea-892e-edd626030225.png)

</div>
</details>

## 프로젝트를 마치고..
#### "Keep in Sync, Aiming for the Same Goal!"
우리의 목표는 두 가지였습니다.<br>
웹 애플리케이션 개발&서비스 관점에서의 사용자들의 니즈(NEEDS)를 파악한 설계 및 개발, 또 한 가지는 실무 프로젝트와는 다른 성격인 학원 평가 팀 프로젝트라는 것에 따른 짧은 기간, 완성도를 고려한 목표 설정이었습니다.<br>
첫 번째 목표에서는 기존에 있었던 개발자 커뮤니티와 IT 아웃소싱 웹사이트에서 직접 사용자가 되어 내가 필요하고 원하는 게 무엇인지 파악하고 정리를 하였습니다. <br>
그리고 두 번째 목표에 맞춰서 앞서 정리한 니즈 중에서 정해진 기간(4주)과 팀원(4명)들의 개발 역량에서 완벽한 결과물을 만들어 낼 수 있는 구현 가능 범위가 어느 정도인지를 파악하였습니다.<br>
이런 협의를 통해 확실한 목표를 가지고 개발을 진행하였지만, 진행 과정 중 달려져야 할 기능들과 개발 수준에 따라 또 다른 방향성이 생기기 시작하였습니다. <br>
개발 과정 중 멤버들의 피드백이 있다면 사용자의 니즈를 만족하면서 개발 기간에 맞춰 구현이 가능할 것인가 판단을 하였고, 팀원들과 회의를 통해 목표를 다시 설정해야 했습니다. <br>
이러한 과정 중 두 명의 팀원이 각기 다른 방향으로의 개발을 진행했던 적이 있었고, 의사소통의 부재가 문제였습니다. <br>
이후 모든 팀원이 정확한 방향을 가지고 진행해야 된다는 것을 느끼고 팀장으로서 소스를 병합하고 다음 단계의 개발을 진행할 때마다 팀원들과 단기적인 목표와 최종 목표를 공유하고 이해시켰습니다.
