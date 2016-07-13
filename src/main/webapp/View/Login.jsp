<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@page import="com.spring.model.UserRole"%> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
.error {
	color: black;
	font-weight: bold;
}
</style>
</head>
<body>

	<form Method="POST" action="/Login">
		<div align="center" style="margin-top: 100px;">
			<h1>Login Form:</h1>
			<table>
				<tr>
					<td>UserID:</td>
					<td><input type="text" name="Id" /></td>
				<tr>
					<td>Password:</td>
					<td><input type="password" name="Password" /></td>
				<tr>
				<tr>
					<td>Select Role:</td>
					<td><select name="userRole.roleId">
					<option>---select role--</option>
							<c:forEach items="${roles}" var="item">
								<option value="${item.key}">${item.value}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>


					<td><input type="submit" value="Submit" /></td>

				</tr>





			</table>
		</div>

	</form>
</body>
</html>