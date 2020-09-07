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
 
## 구현 설명
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

 
 ## 페이지 예시
 
 <details>
<summary>공통 페이지</summary>
<div markdown="1">
 
 ### 시작 페이지
 ![시작페이지](https://user-images.githubusercontent.com/46177529/92350454-13ad8400-f114-11ea-9285-b9b51c2dabdb.png)

 ### 회원가입 (User, Client 선택가능) : 해당 캡쳐는 양식에 맞추지 않고 진행 했을 경우
 ![회원가입](https://user-images.githubusercontent.com/46177529/92350537-45bee600-f114-11ea-900e-c6e3e9195f03.png)

 ### 로그인
 ![로그인](https://user-images.githubusercontent.com/46177529/92350560-4f484e00-f114-11ea-85f6-39b1c156299a.png)

 ### 메인 (인기소스, 인기프로젝트 : 스크랩/Duck, 조회수 등을 통한 게시글 순위 선정) : 로그인 이후 이용 가능
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
 
 ### 마이페이지 - 퀵코덕 통계 + 클라이언트 별점 평가
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
 ### 완료한 프로젝트 - 완료 된 프로젝트의 클라이언트를 평가
![완료프로젝트클라이언트평가](https://user-images.githubusercontent.com/46177529/92351571-03e36f00-f117-11ea-954a-f70de26b8683.png)
 
</div>
</details>





