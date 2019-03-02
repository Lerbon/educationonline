<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" >
$(function(){
	$(".del").click(function(){
		var flag = window.confirm("确定要删除吗?");
		//让用户确定是否真的要删除
		if(!flag){
			return false;
		}
		//获取当前点击的超链接的值
		var href = this.href;
		//将值赋值给某个表单的action上,并提交表单
		$("form").attr("action",href).submit();
		return false;
	});
});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="" method="POST">
		<input type="hidden" name="_method" value="DELETE"/>
	</form>
	<h1 align="center" style="background-color: yellow">顾客列表</h1>
	<table border="1px" align="center" width="70%"
		style="background-color: pink">
		<tr>
			<th>编号</th>
			<th>姓名</th>
			<th>性别</th>
			<th>邮箱</th>
			<th>年龄</th>
			<th>所属部门</th>
			<th>操作</th>
		</tr>
		<c:set var="basePath" value="${pageContext.request.contextPath }"></c:set>
		<c:forEach items="${custs }" var="cust">
			<tr align="center">
				<td>${cust.id }</td>
				<td>${cust.name }</td>
				<td>${cust.gender }</td>
				<td>${cust.email }</td>
				<td>${cust.age }</td>
				<td>${cust.dept.id }</td>
				<td>
					<a class="del" href="${basePath }/delcust/${cust.id}">删除</a>
					&nbsp;&nbsp;
					<a href="${basePath }/cust/${cust.id}">修改</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	

	<!-- 分页 -->
	<h2 align="center">
		<a href="${basePath }/custs/1">首页</a>
		<c:if test="${info.pageNum>1}">
			<a href="${basePath}/custs/${info.pageNum-1 } ">上一页</a>
		</c:if>
		<c:if test="${info.pageNum<=1 }">上一页</c:if>
		
		<c:forEach items="${info.navigatepageNums }" var="num">
			<c:if test="${info.pageNum==num }">
				<a href="${basePath }/custs/${num}"><font color="red">${num }</font></a>
			</c:if>
			<c:if test="${info.pageNum!=num }">
				<a href="${basePath }/custs/${num}">${num }</a>
			</c:if>
		</c:forEach>
		<c:if test="${info.pageNum < info.pages }">
			<a href="${basePath }/custs/${info.pageNum+1}">下一页</a>
		</c:if>
		<c:if test="${info.pageNum >= info.pages }">
			下一页
		</c:if>
		<a href="${basePath }/custs/${info.pages}">尾页</a>
	</h2>

	<h2 align="center">
		<a href="${basePath }/cust">添加新顾客</a>
	</h2>
</body>
</html>