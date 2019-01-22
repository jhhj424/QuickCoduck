<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%@ include file="/WEB-INF/view/style/mypage_table_css.jsp" %>
<%@ include file="/WEB-INF/view/style/board_detail_css.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
body,h1,h2,h3,h4,h5,h6,textarea {font-family: "Montserrat", sans-serif;}
input[type=text] {
  -webkit-appearance: none;
  -moz-appearance: none;
  margin: 10px 0 10px 0;
  border: 1px solid rgba(0, 0, 0, 0.2);
  border-width: 0 0 1px 0;
  border-radius: 0;
  background: rgba(0, 0, 0, 0);
  height: 2.5em;
  font-size:15px;
  font: inherit;
  color: inherit;
  outline: none;
  transition: all 180ms;
  padding: 0;
  text-align:center;
  width:63%;
}

.half {
  float: left;
  width: 46%;
  margin-bottom: 1em;
}

.right {
  width: 52%;
  text-align:center;
}

.left {
  margin-right: 2%;
  margin-top:16%;
}
.div{
text-align:left;
margin:20px 10px 10px 50px;
border:2px solid #ada6a6;
border-radius: 10px;
box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
width:47%;
}
b{
font-family:"Lato", Arial, sans-serif;
line-height:2;
}

.ce-linenumber {
    color: #666;
    padding-top: 10px;
    padding-right: 10px;
    border-right: 2px solid #ccc;
    float: left;
    }
    
pre{font-family:Consolas,"Liberation Mono",Menlo,Courier,monospace}

</style>
<c:set var="path" value="${pageContext.request.contextPath}" />
</head>
<body>
<!-- 작업 시작! -->
<div class="movie-card">

  <div class="container">
  
    <div class="cover">
    
    <c:if test="${!empty board.fileurl }">
    <img src="${path}/file/${board.fileurl}"class="cover" style="width:100%;height:100%;">
    <br>
    </c:if>
    <c:if test="${empty board.fileurl && empty notice.fileurl}">
    <img src="../workpic/noimage.png"class="cover" style="width:100%; height:100%;">
    </c:if>
    <c:if test="${!empty notice.fileurl }">
    <img src="${path}/file/${notice.fileurl}"class="cover" style="width:100%;height:100%;">
    <br>
    </c:if>
     </div>
     <!-- 사진 나오는 영역 끝 -->   
    <div class="hero">
            
      <div class="details">
      
        <div class="title1">
         <c:if test="${param.type==1 || boardtype==1}">
<i class="fa fa-github fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>${board.subject}${notice.subject}</c:if>
<c:if test="${param.type==2 || boardtype==2}">
<i class="fa fa-wechat fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>${board.subject}${notice.subject}</c:if>
<c:if test="${param.type==3 || boardtype==3}">
<i class="fa fa-black-tie fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>${board.subject}${notice.subject}</c:if>
<c:if test="${param.type==5 || boardtype==5}">
<i class="fa fa-jsfiddle fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>${board.subject}${notice.subject}</c:if>
        </div>
      </div> <!-- 위에 제목이랑 보여주는 부분 -->
      
    </div> <!--배경사진 부분 끝 -->
    
    <div class="description">
   <div class="half left">
<div class="div">
<div style="margin-top:10px;margin-bottom:10px;">
<b><b style="border:1px solid grey">글쓴이</b>  :  ${board.userid}${notice.userid}</b><br>
<b><b style="border:1px solid grey">제목</b> : ${board.subject}${notice.subject}</b><br>
<c:if test="${param.type==1 || param.type==3 || param.type==5 || boardtype==1 || boardtype==3 || boardtype==5}">
<c:if test="${param.type==1 || boardtype==1}">
<b><b style="border:1px solid grey;border-radius: 5px;">추천수  </b> :</b>
</c:if>
<c:if test="${param.type==3 || boardtype==3}">
<b><b style="border:1px solid grey;border-radius: 5px;">신청자수</b>  : </b>
</c:if>
<input class="recview" style="text-align: center; width:45%;background-color:#f0f0ed8a;border: 1px solid rgba(0, 0, 0, 0.5);border-width: 0 0 1px 0;" readonly value="${board.recmd}"><br>
</c:if>
<c:if test="${!empty board.usetech }">
<b><b style="border:1px solid grey;border-radius: 5px;">사용기술</b> :
<c:forEach var="usetech" items="${board.usetech}" varStatus="g" begin="0">
<span class="tag">${usetech}</span>
<c:out value="${g.end}" />
</c:forEach></b><br>
</c:if>
<c:if test="${board.boardtype==3}">
<b><b style="border:1px solid grey;border-radius: 5px;">프로젝트 기간</b> : ${board.schedule} 일</b><br>
<b><b style="border:1px solid grey;border-radius: 5px;">프로젝트 금액</b> : ${board.price} 원</b><br>
<b><b style="border:1px solid grey;border-radius: 5px;">프로젝트 인원수</b> : ${board.maxperson} 명</b><br>
<b><b style="border:1px solid grey;border-radius: 5px;">현재 참여한 인원수</b> : ${board.nowperson} 명</b><br>
</c:if>
<b><b style="border:1px solid grey;border-radius: 5px;">첨부파일</b> : </b>
<c:if test="${!empty board.fileurl}">
<a href="../file/${board.fileurl}">${board.fileurl}</a><br>
</c:if>
<c:if test="${empty board.fileurl && empty notice.fileurl}">
<b style="color:red; margin-left:-10px;">등록된 이미지가 없습니다</b><br>
</c:if>
<c:if test="${!empty notice.fileurl}">
<a href="../file/${notice.fileurl}">${notice.fileurl}</a><br>
</c:if>
</div>
</div>
</div><!-- 왼족 div 끝나는 지점 -->

<div class="half right">
<div style="text-align:center;margin-right:50%;margin-bottom:10px;">
<c:if test="${param.type == 1 || boardtype == 1 }">
<b>[오픈소스]</b>
</c:if>
<c:if test="${param.type == 3 || boardtype == 3 }">
<b>[공고 내용]</b>
</c:if>
<c:if test="${param.type == 5 || boardtype == 5 }">
<b>[클라우드]</b>
</c:if>
</div>
<div style="margin-right:70px;line-height:initial;text-align:left;width:1000px;max-width:1000px;resize:none;font-size:30px;max-height:560px;height:60%;float:right;border:2px solid #ada6a6;border-radius: 10px;box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);word-break:break-all;overflow:scroll" class="2">
<pre style="font-size: medium; margin: 30px;">
<c:out value="${board.content}" escapeXml="true"/>
<c:out value="${notice.content}" escapeXml="true"/>
<%-- ${fn:replace(notice.content, cn, br)} --%></pre>
</div>
</div><!-- 오른쪽 div 끝나는 지점 -->

    </div> <!-- 내용 나와지는 부분 끝 -->

  </div> <!-- end container -->
  
</div> <!-- 전체적인 div 끝 -->
<!-- 작업 끝! -->
<div style="width:80%;margin:0 auto;margin-bottom:50px;background-color:#f0f0ed8a;box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);">
<h2 class="w3-text-grey w3-padding-16" style="background-color:#f0f0ed8a;">
<i class="fa fa-copyright"></i>2019 QuickCoduck Corp</h2>
<button onclick="location.href='suggest_accept.duck?boardnum=${board.boardnum}&userid=${loginUser.userid}'" class="button"> 수락</button>
<button onclick="location.href='suggest_refuse.duck?boardnum=${board.boardnum}&userid=${loginUser.userid}'" class="button1"> 거절</button>
<button onclick="location.href='../user/mypage_suggestlist.duck?id=${loginUser.userid}&ducktype=6'" class="button2"> 목록</button>
</div>
</body>
</html>