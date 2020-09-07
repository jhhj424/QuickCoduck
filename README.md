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

 ### 회원가입 페이지 (User, Client 선택가능) : 해당 캡쳐는 양식에 맞추지 않고 진행 했을 경우
 ![회원가입](https://user-images.githubusercontent.com/46177529/92350537-45bee600-f114-11ea-900e-c6e3e9195f03.png)

 ### 로그인 페이지
 ![로그인](https://user-images.githubusercontent.com/46177529/92350560-4f484e00-f114-11ea-85f6-39b1c156299a.png)

 ### 메인 페이지 (인기소스, 인기프로젝트 : 스크랩/Duck, 조회수 등을 통한 게시글 순위 선정) : 로그인 이후 이용 가능
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




