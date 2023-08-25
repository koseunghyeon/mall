<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MALL</title>
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
<div style="border: 1px solid black; height:1500px; width:15%; float:left;">
<input type='button' id='btnAll' value='전체' style="height:5%; width:100%">
<input type='button' id='btnBest' value='인기' style="height:5%; width:100%">
<input type='button' id='btnTop' name='btnCategories' value='상의' style="height:5%; width:100%">
<input type='button' id='btnBottoms' name='btnCategories' value='하의' style="height:5%; width:100%">
<input type='button' id='btnOuter' name='btnCategories' value='아우터' style="height:5%; width:100%">
<input type='button' id='btnHat' name='btnCategories' value='모자' style="height:5%; width:100%">
<input type='button' id='btnShoes' name='btnCategories' value='신발' style="height:5%; width:100%">
<input type='button' id='btnBag' name='btnCategories' value='가방' style="height:5%; width:100%">
<input type='button' id='btnAccessories' name='btnCategories' value='액세서리' style="height:5%; width:100%">
</div>
<div id="dList" style="border: 1px solid black; height:1500px; width:84%; float:left;"></div>
</body>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document)
.ready(function(){
	getList();
})
.on('click','#btnAll',function(){
	getList();
})
.on('click','input[name=btnCategories]',function(){
	$.post('/getCList',{strC:$(this).val()},function(data){
		$('#dList > div').remove();
		for(let i=0; i<data.length; i++){
			let obj = data[i];
			let str="<div id="+obj['p_id']+" class=items ><img src='image/img"+obj['img']+".jpg' style='width:190px; height:200px;'><br>"
			+obj['brand']+"<br>"+obj['p_name']+"<br>"+obj['price']+"원</div>";
			$('#dList').append(str)
		}
	},'json');
	return false;
})
.on('click','#dList > div',function(){
	document.location="/view?p_id="+$(this).attr('id');
	return false;
})
function getList(){
	$.post('/getList',{},function(data){
		$('#dList > div').remove();
		for(let i=0; i<data.length; i++){
			let obj = data[i];
			let str="<div id="+obj['p_id']+" class=items><img src='image/img"+obj['img']+".jpg' style='width:190px; height:200px;'><br>"
			+obj['brand']+"<br>"+obj['p_name']+"<br>"+obj['price']+"원</div>";
			$('#dList').append(str)
		}
	},'json');
	return false;
}
</script>
</html>