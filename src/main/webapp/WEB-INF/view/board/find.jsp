<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>  
<%@include file="/WEB-INF/view/jspHeader.jsp" %>
<%@include file="/WEB-INF/view/style/user_main.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>게시판 대략적인 폼</title>

<spring:url value="/resources/css/jquery.treemenu.css" var="treecss" />

<link href="${treecss}" rel="stylesheet" type="text/css"/>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


 
<style>
html,body,h1,h2,h3,h4,h5,h6 {font-family: "Roboto", sans-serif}
.w3-bar .w3-button {
  padding: 12px;
  margin:5px 15px 5px 15px;
}
</style>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
</head>
<body class="w3-light-grey"id="home">

<div class="w3-top">

 <div class="w3-bar w3-card" id="myNavbar" style="background-color:rgba(255, 255, 255, 0.7);height:50%">
    <!-- 상단 아이콘-->
    <div class="w3-hide-small">
    <a href="../user/main.duck" class="w3-left w3-bar-item w3-button w3-wide"> Quick Coduck
    <img src="../workpic/QuickCoduck.jpg" class="w3-circle" style="height:23px;width:23px" alt="Avatar"></a>
    </div>
    <div class="w3-right w3-hide-small">
      <a href="../board/find.duck" class="w3-bar-item w3-button"><i class="fa fa-info"></i> 이용방법</a>
      <c:if test="${sessionScope.loginUser.type == '1'}">
      <a href="../board/list.duck?type=1" class="w3-bar-item w3-button"><i class="fa fa-search"></i> opensource 찾기</a>
      </c:if>
      <c:if test="${sessionScope.loginUser.type == '2'}">
      <a href="../board/list.duck?type=3" class="w3-bar-item w3-button"><i class="fa fa-search"></i> 프로젝트 찾기</a>
      </c:if>
      <a href="../board/list.duck?type=2" class="w3-bar-item w3-button"><i class="fa fa-newspaper-o"></i> 자유게시판</a>
      <a href="../user/mypage_test.duck?id=${sessionScope.loginUser.userid}" class="w3-bar-item w3-button"><i class="fa fa-user"></i> Mypage</a>
      <c:if test="${empty sessionScope.loginUser}">
      <a href="#contact" class="w3-bar-item w3-button"onclick="document.getElementById('signup').style.display='block'"><i class="fa fa-envelope"></i>로그인/회원가입</a>
      </c:if>
      <c:if test="${!empty sessionScope.loginUser}">
      <a href="../user/logout.duck" class="w3-bar-item w3-button"><i class="fa fa-unlock-alt"></i> 로그아웃</a>
      </c:if>
    </div>
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium" onclick="w3_open()">
      <i class="fa fa-bars"></i>
    </a>
  </div>
</div>
<div class="w3-opacity"><br>
<div class="w3-clear"></div>
<<<<<<< HEAD
<header class="w3-center w3-margin-bottom">
<c:if test="${param.type==1}">
  <h1><b>오픈소스 </b></h1>
 </c:if>
 <c:if test="${param.type==3}">
  <h1><b>프로젝트 공고 </b></h1>
 </c:if>
=======
<header class="w3-center w3-margin-bottom" style="margin-top:60px;">
  <h1><b>프로젝트 찾기/opensource 찾기</b></h1>
>>>>>>> branch 'doorong' of https://github.com/jhhj424/QuickCoduck.git
  <p><b>Quick Coduck</b></p>
</header>
</div>
<!-- Page Container -->
<div class="w3-content w3-margin-top" style="max-width:1400px;">

  <!-- The Grid -->
  <div class="w3-row-padding" style="margin-bottom:50px">
  
    <!-- Left Column -->
    <div class="w3-third"style="padding-right:50px;padding-left:50px;">
    
      <div class="w3-white w3-text-grey w3-card-4">
        <div class="w3-container"style="padding-left:10px;">
          <br>
          <p class="w3-large"><b><i class="fa fa-asterisk fa-fw w3-margin-right w3-text-teal"></i>Skills</b></p>
						<ul class="tree">
									<li><a>Development<input type="checkbox" id="checkall_develop" name="usetech"  value=""></a>
										<ul>
											<li><a>C<input type="checkbox" name="usetech" value="C" class="usetech_develop"></a></li>
											<li><a>C++<input type="checkbox" name="usetech" value="C++" class="usetech_develop"></a></li>
											<li><a>Java<input type="checkbox" name="usetech" value="Java" class="usetech_develop"></a></li>
											<li><a>JSP<input type="checkbox" name="usetech" value="JSP" class="usetech_develop"></a></li>
											<li><a>Python<input type="checkbox" name="usetech" value="Python" class="usetech_develop"></a></li>
											<li><a>Ajax<input type="checkbox" name="usetech" value="Ajax" class="usetech_develop"></a></li>
											<li><a>jQuery<input type="checkbox" name="usetech" value="jQuery" class="usetech_develop"></a></li>
											<li><a>Ruby<input type="checkbox" name="usetech" value="Ruby" class="usetech_develop"></a></li>
											<li><a>Android<input type="checkbox" name="usetech" value="Android" class="usetech_develop"></a></li>
											<li><a>Unity<input type="checkbox" name="usetech" value="Unity" class="usetech_develop"></a></li>
										</ul></li>

									<li><a>Design<input type="checkbox" id="checkall_design" name="usetech"  value=""></a>
										<ul>
											<li><a>HTMl<input type="checkbox" name="usetech" value="HTMl" class="usetech_design"></a></li>
											<li><a>CSS<input type="checkbox" name="usetech" value="CSS" class="usetech_design"></a></li>
											<li><a>BootStrap<input type="checkbox" name="usetech" value="BootStrap" class="usetech_design"></a></li>
											<li><a>DreamWeaver<input type="checkbox" name="usetech" value="DreamWeaver" class="usetech_design"></a></li>
											<li><a>PhotoShop<input type="checkbox" name="usetech" value="PhotoShop" class="usetech_design"></a></li>
											<li><a>XML<input type="checkbox" name="usetech" value="XML" class="usetech_design"></a></li>
											<li><a>Sketch<input type="checkbox" name="usetech" value="Sketch" class="usetech_design"></a></li>
											<li><a>JavaScript<input type="checkbox" name="usetech" value="JavaScript" class="usetech_design"></a></li>
											<li><a>Unity3d<input type="checkbox" name="usetech" value="Unity3d" class="usetech_design"></a></li>
											<li><a>iOS<input type="checkbox" name="usetech" value="iOS" class="usetech_design"></a></li>
										</ul></li>

								</ul>
        
						
					</div>
      </div><br>

      
<script>
$(document).ready(function(){
    $("#checkall_develop").click(function(){
        if($("#checkall_develop").prop("checked")){
            $(".usetech_develop").prop("checked",true);
        }else{
            $(".usetech_develop").prop("checked",false);
        }
    });
    $("#checkall_design").click(function(){
        if($("#checkall_design").prop("checked")){
            $(".usetech_design").prop("checked",true);
        }else{
            $(".usetech_design").prop("checked",false);
        }
    });
})
$(document).ready(function(){
		var chk = ""
		var data = ""
		var userid = "${loginUser.userid}" // 세션에 등록된 로그인 유저
		var pageNum = $("input[name=pageNum]").val(); //pageNum값
		var type = ${param.type}; //게시판type
	$(".tree").click(function() {
		// 이미 체크박스 선택한 상태에서 체크박스 다시 선택시에 데이터 초기화하고 현재선택되있는값들로 변경
		$("input[name=usetech]:checked").each(function() {
			chk += $(this).val()+"./";
		});
		data = {
				"chk" : chk,
				"pageNum": pageNum,
				"type": type
		}
		chk = ""
		$.ajax({
			url : "ajax_content.duck",
			type : "post",
			data : data,
			dataType : "html", // ajax 통신으로 받는 타입
			success : function(data) {
	            $("#ajax_content").html(data);
			},
			error : function(xhr, status, error) { //서버응답 실패
				alert("서버오류 : " + xhr.status + ", error : "
						+ error + ", status : " + status);
			}
		})
	});
		//테스트에이작
		$("#test1").click(function(){ 
			var data = {
					"pageNum": pageNum,
					"type": type
			}
			$.ajax({
				url : "ajax_content.duck",
				type : "post",
				data : data,
				dataType : "html", // ajax 통신으로 받는 타입
				success : function(result) {
					alert("서버통신완료:"+result);
		            $("#ajax_content").html(result);
				},
				error : function(xhr, status, error) { //서버응답 실패
					alert("서버오류 : " + xhr.status + ", error : "
							+ error + ", status : " + status);
				}
			})
			})	
})

</script>
<script type="text/javascript">
function list(pageNum) {
	var type = document.searchform.type.value;
	if (type == null || type.length == 0) {
		document.searchform.searchContent.value = "";
		document.searchform.pageNum.value = "1";
		location.href = "find.duck?pageNum=" + pageNum
				+ "&type=${param.type}";
	} else {
		document.searchform.pageNum.value = pageNum;
		document.searchform.submit();
		return true;
	}
	return false;
}
</script>

				<!-- End Left Column -->
    </div>

    <!-- Right Column -->
    <div class="w3-twothird">
    
      <div class="w3-container w3-card w3-white w3-margin-bottom">
      <c:if test="${param.type==1}">      
        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-suitcase fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>오픈소스</h2>
       </c:if>
       <c:if test="${param.type==3}">      
        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-suitcase fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>프로젝트 공고</h2>
       </c:if>
        <!-- <div class="w3-container">
          <h5 class="w3-opacity"><b>Front End Developer / w3schools.com</b></h5>
          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>Jan 2015 - <span class="w3-tag w3-teal w3-round">Current</span></h6>
          <p>Lorem ipsum dolor sit amet. Praesentium magnam consectetur vel in deserunt aspernatur est reprehenderit sunt hic. Nulla tempora soluta ea et odio, unde doloremque repellendus iure, iste.</p>
          <hr>
        </div> -->
        <div class="w3-container">
		<div class="w3-ul w3-card-4">
			<div class="table14_10" style="width: 100%">
				<div>
					<div align="center">
						<form action="find.duck?type=${param.type}" method="post"
							name="searchform" onsubmit="return list(1)">
							게시글 검색
							<input type="hidden" name="pageNum" value="1"> <select
								name="type" id="type">
								<option value=" ">선택하세요</option>
								<option value="subject">제목</option>
								<option value="userid">글쓴이</option>
								<option value="content">내용</option>
							</select>&nbsp;
							<script type="text/javascript">
								if (${param.type!= ''}) {
									document.getElementById("type").value=${param.type};
								}
							</script>
							<input type="text" name="searchContent"
								value="${param.searchContent}"> <input type="submit"
								value="검색"><input type="button" id="test1"
								value="테스트">
						</form>
					</div>
				</div>
				<c:if test="${listcount > 0}">
					<%-- 게시물이 있는경우 --%>
					<%-- <div align="center">
							<div>오픈소스게시판 // 글개수:${listcount}</div>						
					</div> --%>
					<div id="ajax_content">
					<c:forEach  var="board" items="${boardlist}">
						<div align="center" onmouseover="this.style.backgroundColor='#5CD1E5'"
							onmouseout="this.style.backgroundColor=''" style="border: 1px solid; border-color: grey; margin-bottom: 3px;">
							<%-- <div height="23">${boardcnt}</div> --%>
							<c:set var="boardcnt" value="${boardcnt - 1}" />
							<div align="left"><c:if test="${! empty board.fileurl}">
									<a href="../file/${board.fileurl}">@</a>
								</c:if> <c:if test="${empty board.fileurl}">&nbsp;&nbsp;&nbsp;</c:if> 
									<h3><a style="text-decoration:none;" href="detail.duck?num=${board.boardnum}&type=${board.boardtype}">&nbsp;&nbsp;&nbsp;${board.subject}<c:if test="${board.boardtype==1}"> [추천 : ${board.recmd}]</c:if></a></h3>
							</div>
							<div align="right">날짜:${board.regdate}&nbsp;&nbsp;</div>
							<div align="right">조회수:${board.readcnt}&nbsp;&nbsp;</div>
						</div>
					</c:forEach>
					</div>
					<div align="center" height="26">
						<div><c:if test="${pageNum > 1}">
								<a href="javascript:list(${pageNum -1})">[이전]</a>
							</c:if> <c:if test="${pageNum <= 1}">[이전]</c:if> <c:forEach var="a"
								begin="${startpage}" end="${endpage}">
								<c:if test="${a==pageNum}">[${a}]</c:if>
								<c:if test="${a!=pageNum}">
									<a href="javascript:list(${a})">[${a}]</a>
								</c:if>
							</c:forEach> <c:if test="${pageNum < maxpage}">
								<a href="javascript:list(${pageNum +1})">[다음]</a>
							</c:if> <c:if test="${pageNum >= maxpage}">[다음]</c:if></div>
					</div>
				</c:if>
				<c:if test="${listcount == 0}">
					<div>
						<div>등록된 게시물이 없습니다.</div>
					</div>
				</c:if>
				<div>
					<div align="right"><a
						href="write.duck?type=${param.type}">[글쓰기]</a></div>
				</div>
			</div>
			<a href="../user/logout.duck">로그아웃</a><a
				href="../board/find.duck?type=1">이용방법[게시판테스트중]</a> <a
				href="../board/list.duck?type=1">오픈소스게시판</a> <a
				href="../board/list.duck?type=2">개발자자유게시판</a> <a
				href="../board/list.duck?type=3">프로젝트공고모집게시판</a>
		</div>
	</div>
      </div>

    <!-- End Right Column -->
    </div>
    
  <!-- End Grid -->
  </div>
  
  <!-- End Page Container -->
</div>

<!-- Footer -->
<footer class="w3-center w3-black w3-padding-32">
  <div class="w3-xlarge w3-section">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i><br>
  </div>
  <p>Quick Coduck<a href="#home"class="w3-hover-text-green">  <i class="fa fa-arrow-up w3-margin-right">Up to top</i></a></p>
</footer>


</body>
</html>