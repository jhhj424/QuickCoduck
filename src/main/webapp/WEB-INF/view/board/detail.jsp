<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%@ include file="/WEB-INF/view/style/board_detail_css.jsp" %>
<%
   //줄바꿈
   pageContext.setAttribute("br","<br/>");
   pageContext.setAttribute("cn","\n");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세보기</title>
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
.button3 {
	background: #009688d1;
	border-radius: 5px;
	margin-bottom: 15px;
	margin-top:15px;
	color: #fff;
	border: none;
	position: relative;
	height: 50px;
	font-size: 18px;;
	font-weight: bold;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
	padding: 0 2em;
	width: 12%;
}

.button3:hover {
	background: #fff;
	color: #009688;
	border-radius: 5px;
}

.button3:before, .button3:after {
	content: '';
	position: absolute;
	border-radius: 5px;
	top: 0;
	right: 0;
	height: 2px;
	width: 0;
	background: #009688;
	transition: 400ms ease all;
}

.button3:after {
	right: inherit;
	border-radius: 5px;
	top: inherit;
	left: 0;
	bottom: 0;
}

.button3:hover:before, .button3:hover:after {
	width: 100%;
	border-radius: 5px;
	transition: 800ms ease all;
}
.comment {
	background: #009688d1;
	border-radius: 5px;
	margin-bottom: 15px;
	margin-top:15px;
	color: #fff;
	border: none;
	position: relative;
	height: 50px;
	font-size: 18px;;
	font-weight: bold;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
	padding: 0 2em;
	width: 60%;
}

.comment:hover {
	background: #fff;
	color: #009688;
	border-radius: 5px;
}

.comment:before, .comment:after {
	content: '';
	position: absolute;
	border-radius: 5px;
	top: 0;
	right: 0;
	height: 2px;
	width: 0;
	background: #009688;
	transition: 400ms ease all;
}

.comment:after {
	right: inherit;
	border-radius: 5px;
	top: inherit;
	left: 0;
	bottom: 0;
}

.comment:hover:before, .comment:hover:after {
	width: 100%;
	border-radius: 5px;
	transition: 800ms ease all;
}
.comment1 {
	background: #009688d1;
	border-radius: 5px;
	margin-bottom: 15px;
	margin-top:15px;
	color: #fff;
	border: none;
	position: relative;
	height: 50px;
	font-size: 15px;
	font-weight: bold;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
	padding: 0 2em;
	width: 30%;
}

.comment1:hover {
	background: #fff;
	color: #009688;
	border-radius: 5px;
}

.comment1:before, .comment1:after {
	content: '';
	position: absolute;
	border-radius: 5px;
	top: 0;
	right: 0;
	height: 2px;
	width: 0;
	background: #009688;
	transition: 400ms ease all;
}

.comment1:after {
	right: inherit;
	border-radius: 5px;
	top: inherit;
	left: 0;
	bottom: 0;
}

.comment1:hover:before, .comment1:hover:after {
	width: 100%;
	border-radius: 5px;
	transition: 800ms ease all;
}
.comment2 {
	background: #f95959bf;
	border-radius: 5px;
	margin-bottom: 15px;
	margin-top:15px;
	color: #fff;
	border: none;
	position: relative;
	height: 50px;
	font-size: 15px;;
	font-weight: bold;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
	padding: 0 2em;
	width: 30%;
}

.comment2:hover {
	background: #fff;
	color: #f95959bf;
	border-radius: 5px;
}

.comment2:before, .comment2:after {
	content: '';
	position: absolute;
	border-radius: 5px;
	top: 0;
	right: 0;
	height: 2px;
	width: 0;
	background: #f95959bf;
	transition: 400ms ease all;
}

.comment2:after {
	right: inherit;
	border-radius: 5px;
	top: inherit;
	left: 0;
	bottom: 0;
}

.comment2:hover:before, .comment2:hover:after {
	width: 100%;
	border-radius: 5px;
	transition: 800ms ease all;
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
<script type="text/javascript"
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
   $(document).ready(
         function() {
            $("#rec").click(
                  function() {
                     var num = ${board.boardnum}${notice.boardnum}
                     var type = ${board.boardtype}${notice.boardnum}
                     var userid = "${loginUser.userid}"
                     var data = {
                        "num" : num,
                        "type" : type,
                        "userid" : userid
                     }
                     $.ajax({
                        url : "recmd.duck",
                        type : "post",
                        data : data,
                        dataType : "json", // ajax 통신으로 받는 타입
                        success : function(data) {
                           alert(data.msg);
                           $(".recview").val(data.recmd);
                        },
                        error : function(xhr, status, error) { //서버응답 실패
                           alert("서버오류 : " + xhr.status + ", error : "
                                 + error + ", status : " + status);
                        }
                     })
                  });
            
            $("#pro").click(
                  function() {
                     var num = ${board.boardnum}${notice.boardnum}
                     var type = ${board.boardtype}${notice.boardnum}
                     var userid = "${loginUser.userid}" // 세션에 등록된 로그인 유저
                     var data = {
                        "num" : num,
                        "type" : type,
                        "ducktype" : 2,
                        "userid" : userid
                     }
                     $.ajax({
                        url : "pro.duck",
                        type : "post",
                        data : data,
                        dataType : "json", // ajax 통신으로 받는 타입
                        success : function(data) {
                           alert(data.msg);
                           $(".recview").val(data.recmd);
                        },
                        error : function(xhr, status, error) { //서버응답 실패
                           alert("서버오류 : " + xhr.status + ", error : "
                                 + error + ", status : " + status);
                        }
                     })
                  });
            
            $("#duck").click(
                  function() {
                     var num = ${board.boardnum}${notice.boardnum}
                     var type = ${board.boardtype}${notice.boardnum}
                     var userid = "${loginUser.userid}" // 세션에 등록된 로그인 유저
                     var data = {
                        "num" : num,
                        "type" : type,
                        "ducktype" : 1,
                        "userid" : userid
                     }
                     $.ajax({
                        url : "duck.duck",
                        type : "post",
                        data : data,
                        dataType : "json", // ajax 통신으로 받는 타입
                        success : function(data) {
                           alert(data.msg);
                        },
                        error : function(xhr, status, error) { //서버응답 실패
                           alert("서버오류 : " + xhr.status + ", error : "
                                 + error + ", status : " + status);
                        }
                     })
                  })
         })
   //댓글 입력창
   function comment_submit() {
      if (document.f.content.value == '') {
         alert("댓글을 입력하세요");
         document.f.content.focus();
         return;
      }
      document.f.submit();
   }
   //댓글 삭제창
   function delCommentOpen(num) {
      var boardnum = ${param.num} ;
      var msg = confirm("댓글을 삭제 하시겠습니까??");
      if (msg) { //삭제
         $.ajax({
            url : "delcomment.duck",
            type : "post",
            data : {"boardnum" : boardnum,   "num" : num},
            dataType : "json",
            success : function(result) {
               //alert(result.msg)
               if (result.msg == "OK") {
                  $('#comment.content').remove();
                  alert("삭제되었습니다.");
                  location.reload();
               } else {
                  alert("삭제에 실패하였습니다.");
               }
            },
            error : function(xhr, status, error) {
               alert("서버오류:"+xhr.status+",error:"+error+",status:"+status);
            }
         })
      } else { //삭제 취소
         //alert("취소")
         return false;
      }
   }
   //댓글 답변 입력창
   function comment_submit2(num) {
      var reply = $("#replycontent"+num).val();
      //alert(reply);
      var length = $("#replycontent"+num).val().length;
      //alert(length);
      //alert("댓글번호:"+num);
      var type = ${param.type};
      if (length < 1) {
         alert("답변을 입력하세요");
         return;
      }else{
         //alert($("#replycontent").val());
      }
      location.href="reply.duck?num="+num+"&reply="+reply+"&type="+type
   }
   //답글 폼(?)
   function replyCommentOpen(num){
      $("#reply"+num).html(
            '<table id="replytb" class="table14_10" style="width: 90%"><tr>'
               +'<td>└>답변쓰기</td><td><textarea required="required" rows="2" cols="75"'
               +'name="reply" id="replycontent'+num+'" >'+'</textarea>'
               +'<td><button type="button" onclick="location.href='
               +"'javascript:comment_submit2("+num+")'"
               +' "class="comment1"  style="margin-right:5px;">등록</button>'
               +'<button onclick="replycancer('+num+')" class="comment2">취소</button>'
                +'</td></td></tr></table>'
      )
   }
   function replycancer(num){
      $("#reply"+num).html(
            ''
      )
   }
         $("#pro").click(
                  function() {
                     var num = ${board.boardnum}${notice.boardnum}
                     var type = ${board.boardtype}${notice.boardnum}
                     var userid = "${loginUser.userid}" // 세션에 등록된 로그인 유저
                     var data = {
                        "num" : num,
                        "type" : type,
                        "ducktype" : 2,
                        "userid" : userid
                     }
                     $.ajax({
                        url : "pro.duck",
                        type : "post",
                        data : data,
                        dataType : "json", // ajax 통신으로 받는 타입
                        success : function(data) {
                           alert(data.msg);
                        },
                        error : function(xhr, status, error) { //서버응답 실패
                           alert("서버오류 : " + xhr.status + ", error : "
                                 + error + ", status : " + status);
                        }
                     })
                  });
</script>

</head>
<body>
<form action="comment.duck?" name="f" method="post">
<input type="hidden" value="${param.type}" name="type">
<input type="hidden" value="${param.num}" name="num">
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
<i class="fa fa-github fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>
[오픈소스] <br>${board.subject}${notice.subject}</c:if>
<c:if test="${param.type==2 || boardtype==2}">
<i class="fa fa-wechat fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>
[개발자자유게시판] <br>${board.subject}${notice.subject}</c:if>
<c:if test="${param.type==3 || boardtype==3}">
<i class="fa fa-black-tie fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>
[프로젝트 공고모집] <br>${board.subject}${notice.subject}</c:if>
<c:if test="${param.type==5 || boardtype==5}">
<i class="fa fa-jsfiddle fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>
[나만의소스] <br>${board.subject}${notice.subject}</c:if>
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
<c:if test="${board.boardtype==3}">
<div style="margin-bottom:30px;">
      
      <button type="button" class="button3" id="duck" style="margin-right:15px;">
      <i class="fa fa-star fa-fw w3-xlarge w3-margin-right" style="color:#e3e329"></i>스크랩</button>
      <button type="button" class="button3" id="pro" style="margin-right:15px;">
      <i class="fa fa-handshake-o fa-fw w3-xlarge w3-margin-right"></i>즉시신청</button>
      <c:if test="${board.userid == loginUser.userid }">
      <a href="../user/supporterlist.duck?boardnum=${board.boardnum}&userid=${board.userid}"><i class="fa fa-users w3-margin-right w3-margin-left">[지원자목록보기]</i></a>
      <a href="../board/selectdevelop.duck?boardnum=${board.boardnum}&userid=${board.userid}"><i class="fa fa-handshake-o w3-margin-right">[선택한개발자목록]</i></a>
      </c:if>
</div>
</c:if>
<c:if test="${board.boardtype == 1 }">
<div style="margin-bottom:30px;">
     <c:if test="${board.boardtype==1}">
      <button type="button" class="button3" id="rec" style="margin-right:15px;">
      <i class="fa fa-thumbs-o-up fa-fw w3-xlarge w3-margin-right"></i>추천</button>
      <button type="button" class="button3" id="duck" style="margin-right:15px;">
      <i class="fa fa-external-link fa-fw w3-xlarge w3-margin-right"></i>DUCK</button>
      </c:if>
      <c:if test="${board.boardtype==2}">
      <button type="button" class="button3" id="rec" style="margin-right:15px;">
      <i class="fa fa-thumbs-o-up fa-fw w3-xlarge w3-margin-right"></i>추천</button>
      </c:if> 
</div>
</c:if>
<div style="margin-bottom:30px;">
      <a href="update.duck?num=${board.boardnum}${notice.boardnum}&type=${board.boardtype}${notice.boardtype}"><i class="fa fa-rotate-right w3-margin-right">[게시물수정]</i></a>
      <a href="deleteForm.duck?num=${board.boardnum}${notice.boardnum}&type=${board.boardtype}${notice.boardtype}"><i class="fa fa-trash-o w3-margin-right">[게시물삭제]</i></a>
      <c:if test="${loginUser.type==3}">
      		<a href="adminupdateForm.duck?num=${notice.boardnum}${board.boardnum}&type=${notice.boardtype}${board.boardtype}"><i class="fa fa-rotate-right w3-margin-right">[공지수정]</i></a>
      		<a href="admindeleteForm.duck?num=${board.boardnum}${notice.boardnum}&type=${board.boardtype}${notice.boardtype}"><i class="fa fa-trash-o w3-margin-right">[공지삭제]</i></a>
      </c:if>
      <c:if test="${param.type==1 || param.type==3 || param.type==5}">
      <a href="find.duck?type=${param.type}"class="w3-hover" style="color:#000"><i class="fa fa-list w3-margin-right">[게시물목록]</i></a>
      </c:if>
      <c:if test="${board.boardtype!=1 && board.boardtype!=3 && board.boardtype!=5 }">
      <a href="list.duck?type=${board.boardtype}${notice.boardtype}"><i class="fa fa-list w3-margin-right">[게시물목록]</i></a>
      </c:if>
 
</div><!-- 아래 버튼 부분 끝 -->

<div class="w3-container w3-card w3-white w3-margin-bottom"style="max-width:80%;margin: 0 auto;">
<h2 class="w3-text-grey w3-padding-16">
<i class="fa fa-comments-o fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>댓글</h2>
<table class="table14_10" style="width: 100%">
            <jsp:useBean id="day" class="java.util.Date" />
               <c:if test="${commentCount==0 }">
                  <tr>
                     <td colspan="5" align="center">등록된 댓글이 없습니다.</td>
                  </tr>
               </c:if>
               <c:if test="${commentCount > 0}">
                  <tr>
                     <td colspan="3" style="text-align: center;">달린댓글
                        :${commentCount}</td>
                  </tr>
                  <c:forEach items="${comment}" var="c">
                     <tr>
                        <td style="width:15%">${c.userid}님
                        <sub style="font-weight:bold;color:#929292;">
                        <fmt:formatDate value="${day}" pattern="yy/MM/dd" var="today" />
                              <fmt:formatDate value="${c.regdate}" pattern="yy/MM/dd" var="rdate" />
                              <c:if test="${today == rdate }">
                                 <fmt:formatDate value="${c.regdate}" pattern="HH:mm:ss" />
                              </c:if>
                              <c:if test="${today != rdate }">
                                 <fmt:formatDate value="${c.regdate}" pattern="yy/MM/dd" />
                              </c:if>
                        </sub></td>
                        <td style="min-width: 600px; text-align: left; max-width: 600px">
                           <c:if test="${c.refstep == 0}">
                           <div style="width: 100%; height: 100%; margin-left: 10%; padding-right: 20%">
                              ${fn:replace(c.content, cn, br)}</div>
                           </c:if>
                           <c:if test="${c.refstep != 0 }">
                           <div style="width: 100%; height: 100%; margin-left: 10%; padding-right: 20%">
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└>&nbsp;&nbsp;<font style="color:blue">${c.userid}</font> ${fn:replace(c.content, cn, br)}</div>
                           </c:if>
                        </td>
                        <td><c:if test="${c.userid == loginUser.userid}">
                              <button type="button" onclick="replyCommentOpen(${c.num})" class="comment1">답변</button>
                              <button type="button" onclick="delCommentOpen(${c.num})" class="comment2">삭제</button>
                           </c:if>
                            <c:if test="${c.userid != loginUser.userid }">
                              <button type="button" onclick="replyCommentOpen(${c.num})" class="comment">답변</button>
                              <c:if test="${loginUser.userid == 'admin'}">
                                 <button type="button" onclick="delCommentOpen(${c.num})" class="comment2">삭제</button>
                              </c:if>
                           </c:if></td>
                     </tr>
                     <tr id="reply${c.num}" align="right"></tr>
                  </c:forEach>
               </c:if>
            </table>
<div style="margin:10px 0 10px 0">
<table class="table14_10" style="width: 100%">
               <tr>
                  <td>댓글쓰기</td>
                  <td><textarea required="required" rows="2" cols="75"
                        name="content"></textarea></td>
                  <td>
                     <button type="button"
                        onclick="location.href='javascript:comment_submit()' " class="comment">댓글등록!!</button>
                  </td>
               </tr>
            </table>
</div>
            </div>
   </form>
</body>
</html>