<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mall</title>
</head>
<link href="css/home.css" rel="stylesheet" />
<link rel="icon" type="image/x-icon" href="image/pmo.jpg">
<body>
<a href="/">
<h1>MALL</h1>
</a>
<div style='text-align:right;'>
	<c:if test="${name==''}">
	<a href="/login">로그인</a>&nbsp;&nbsp;
	<a href="/signup">회원가입</a>
	</c:if>
	<c:if test="${name != ''}">
	${name}님&nbsp;<a href="/logout">로그아웃</a>
	</c:if>
</div>
<div id='brandTitle'>${vget.brand}</div>
<br>
<br>
<p style='font-size:small; color:grey; text-decoration: underline;'>${vget.category} > ${vget.brand}</p>
<div><span style='font-size:x-large; font-weight:bold'>${vget.p_name}</span></div>
<div id='viewImg' style='width:600px; height:700px; border: 1px solid grey; align-items:center; display: flex; justify-content:center; float:left;'></div>
<div style='float:left; margin-left: 50px; width: 500px'>
<p>
Product Info
<span>제품정보</span>
</p>
<p>
브랜드/품번
<span style='margin-left: 50px;'>${vget.brand}/${vget.p_id}</span>
</p>
<p>
조회수
<span style='margin-left: 50px;'>${vget.hit}회</span>
</p>
<p style= "border-top: 1px solid grey;">
Delivery info
<span>배송정보</span>
</p>
<p>
출고 정보
<span style='margin-left: 50px;'>결제 3일 이내 출고</span>
</p>
<p>
배송 정보
<span style='margin-left: 50px;'>국내 배송/입점사 배송/cj대한통운</span>
</p>
<p style= "border-top: 1px solid grey;">
Price info
<span>가격정보</span>
</p>
<p>
판매가
<span style='margin-left: 50px;'>${vget.price}원</span>
</p>
<p style= "border-top: 1px solid grey;">
COLOR
</p>
<p>
<select id="colorSelect">
<option selected="selected">색상 선택</option>
<c:forEach items="${cget}" var="color">
	<option>${color.color}</option>
</c:forEach>
</select>
</p>
<p style= "border-top: 1px solid grey;">
SIZE
</p>
<p>
<select id="sizeSelect">
<option selected="selected">사이즈 선택</option>
<c:forEach items="${sget}" var="size">
	<option>${size.size}</option>
</c:forEach>
</select>
</p>
</div>
<div style="width: 500px; border:1px solid black; position: absolute; left: 660px; top: 770px;">
<p>
<input class='textbox' type=text id=getSelColor style="width:50px;">
<input class='textbox' type=text id=getSelSize style="width:50px;">
</p>
</div>
</body>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document)
.ready(function(){
	let img="<img src='image/img"+${vget.img}+".jpg' style='width:500px; height:680px;'>"
	$('#viewImg').append(img);
})
.on('change','#colorSelect',function(){
	if($("#colorSelect option:selected").text()=="색상 선택"){
		return false;
	};
	alert($("#colorSelect option:selected").text());
	$('#getSelColor').val($("#colorSelect option:selected").text());
})
.on('change','#sizeSelect',function(){
	if($("#sizeSelect option:selected").text()=="사이즈 선택"){
		return false;
	};
	alert($("#sizeSelect option:selected").text());
	$('#getSelSize').val($("#sizeSelect option:selected").text());
})
</script>
</html>