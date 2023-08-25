<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
</head>
<link rel="icon" type="image/x-icon" href="image/pmo.jpg">
<body>
<table align=center>
<tr><td>로그인아이디</td><td><input type=text name=loginid id=userid></td></tr>
<tr><td>비밀번호</td><td><input type=password name=pwd id=pwd></td></tr>
<tr><td align=center colspan=2>
	<input type=button id=btnSubmit value='로그인'>&nbsp;
	<a href='/'>홈으로</a>
</td></tr>
</table>
</body>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document)
.on('click','#btnSubmit',function(){
	$.post('/signon',{userid:$('#userid').val(), pwd:$('#pwd').val()},
			function(data){
				if(data=="계정을 확인하세요."){
					document.location="/login"
					alert(data)
				}else{
					document.location="/"
				}
	},'text');
	return false;
})
</script>
</html>