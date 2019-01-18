<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<script type="text/javascript">
function userevaluation(boardnum,userid){
	var msg = confirm("해당 유저를 평가하시겠습니까?");
	if (msg) { //평가
		 $.ajax({
			url : "userevaluation.duck",
			type : "post",
			data : {"boardnum" : boardnum, "userid" : userid},
			dataType : "json",
			success : function(result) {
				alert(result.msg);
				if(result.ok == "ok") {
				location.href = "mypage_project_finished2.duck?id="+userid+"&boardnum="+boardnum;					
				}else{
					return false;
				}
			},
			error : function(xhr, status, error) {
				alert("서버오류:"+xhr.status+",error:"+error+",status:"+status);
			} 
		})
	} else { //평가취소
		return false;
	}
}
</script>
<div class="w3-container w3-card w3-white w3-round w3-margin">
<table border="1" style="width:100%;">
<tr align="center" valign="middle" bordercolor="#212121">
	<th width="45%" height="26">개발자ID</th>
	<th width="30%" height="26">평가하기</th>
</tr>
<c:forEach var="user" items="${userlist}">
	<tr align="center" valign="middle" bordercolor="#333333"
		onmouseover="this.style.backgroundColor='#5CD1E5'"
		onmouseout="this.style.backgroundColor=''">
		<td align="left">${user.userid}</td>
		<td align="center"><input type="button" value="선택하기" onclick="userevaluation(${boardnum},'${user.userid}')"></td>
	</tr>
</c:forEach>
</table>
<p></p>
</div>