<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%@ include file="/WEB-INF/view/style/mypage_table_css.jsp" %>
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
<div style="width:100%">
<table border="1" style="width:100%;" class="table">
<tr align="center">
	<th width="50%" class="th" style="font-weight:bold;text-align:center;">개발자ID</th>
	<th width="50%" class="th" style="font-weight:bold;">평가하기</th>
</tr>
<c:forEach var="user" items="${userlist}">
	<tr align="center" 
		onmouseover="this.style.backgroundColor='#0096884f'"
		onmouseout="this.style.backgroundColor=''">
		<td align="center" class="th" style="font-size:20px;font-weight:bold;color:#0f171be8;">${user.userid}</td>
		<td align="center" class="th"><input type="button" value="선택하기" onclick="userevaluation(${boardnum},'${user.userid}')" class="button"></td>
	</tr>
</c:forEach>
</table>
<p></p>
</div>