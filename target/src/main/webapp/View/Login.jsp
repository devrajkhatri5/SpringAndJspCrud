<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@page import="com.spring.model.UserRole"%> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

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


	<form Method="POST" action="Login" onsubmit="return validateForm()">
		<div align="center" style="margin-top: 100px;">
			<h1>Login Form:</h1>
			<table>
				<tr>
					<td>UserID:</td>
					<td><input type="text" name="Id"  id="Id"/></td>
				<tr>
					<td>Password:</td>
					<td><input type="password" name="Password" id="password"/></td>
				<tr>
				<tr>
					<td>Select Role:</td>
					<td><select name="userRole.roleId" id="userRole">
					<option value=''>--please select role---</option>
					</select></td>
				</tr>
				<tr>


					<td><input type="submit" value="Submit" /></td>

				</tr>
   <c:if test="${message!=null}">
   <div style="color:red;">
   
    ${message}</div>
</c:if>




			</table>
		</div>

	</form>
	
<script type="text/javascript">
function validateForm()
{
	var Id=document.getElementById("Id").value;
	var password=document.getElementById("password").value;
	var userRole=document.getElementById("userRole").value;
	if(Id==null || Id=="")
		{
		alert("UserID Cannot be NUll")
		return false;
		}
		
		
	else if (password==null || password=="") 
		{
		
	alert("Password cannot be null")
	return false;
	
		}
	else if(userRole=='')
		{
		alert("Please select Role")
		return false;
		}
	
}

	
$(document).ready(function(){	
	$.ajax({

		url : "/Admin/ajaxForUserRole",
		type : "GET",
		dataType : "json",
		success : function(data) {
			$.each(data, function(key, value) {
				$('#userRole').append($("<option></option>")
							.attr("value", key).text(value));
			});
			},
			error:function() {
			
				alert("Unable to populate dropdownlist please contact Admin");
			}
			
			});
		
});


</script>

</body>

</html>

