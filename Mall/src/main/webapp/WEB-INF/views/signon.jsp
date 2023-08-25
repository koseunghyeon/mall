<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SIGN UP</title>
</head>
<link rel="icon" type="image/x-icon" href="image/pmo.jpg">
<body>
<table id=tblSignon align=center>
<tr>
	<td>id</td><td><input type=text id=userid name=userid></td>
</tr>
<tr>
	<td>password</td><td><input type=password id=passcode name=passcode></td>
</tr>
<tr>
	<td>password check</td><td><input type=password id=passcode1 name=passcode1></td>
</tr>
<tr>
	<td>name</td><td><input type=text id=name name=name></td>
</tr>
<tr>
	<td>mobile</td><td><input type=number id=mobile name=mobile>'-'제외</td>
</tr>
<tr>
	<td>address</td><td><input type=text id=address name=address></td>
</tr>
<tr>
	<td>email</td><td><input type=text id=email1 name=email1>@<input type=text id=email2 name=email2></td>
</tr>
<tr>
	<td colspan=2 align=center>
		<input type=button id=btnSend value='SignUp'>
		<input type=button id=cancel  value='cancel'>
	</td>
</tr>
</table>
</body>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document)
.on('click','#btnSend',function(){
 	if($('#userid').val()==null || $('#userid').val()==""){
		alert("아이디를 입력하세요.");
		return false;
	}else if($('#passcode').val()==null || $('#passcode').val()==""){
		alert("비밀번호를 입력하세요.");
		return false;
	}else if($('#passcode').val()!=$('#passcode1').val()){
		alert("비밀번호가 같지 않습니다.");
		return false;
	}else if($('#name').val()==null || $('#name').val()==""){
		alert("이름을 입력하세요.");
		return false;
	}else if($('#mobile').val()==null || $('#mobile').val()==""){
		alert("전화번호를 입력하세요.");
		return false;
	}else if($('#address').val()==null || $('#address').val()==""){
		alert("주소를 입력하세요.");
		return false;
	}else if($('#email1').val()==null || $('#email1').val()==""){
		alert("이메일을 입력하세요.");
		return false;
	}else if($('#email2').val()==null || $('#email2').val()==""){
		alert("이메일을 입력하세요.");
		return false;
	}
	$.post('/register',{userid:$('#userid').val(), pwd:$('#passcode').val(),
						name:$('#name').val(),mobile:$('#mobile').val(),
						address:$('#address').val(),
						email:$('#email1').val()+"@"+$('#email2').val(),},
			function(data){
		if(data.substr(0,1)=="/"){
			document.location=data;
		}else{
			alert(data);
		}
	},'text');
	 return false;
})
.on('click','#cancel',function(){
	document.location="/"
	return true;
})
</script>
</html>