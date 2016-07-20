<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div align="center" style="margin-top: 100px;">
<c:if test="${roleId==1}">
<input type="submit" value="Add User" onclick="window.location.href='/Admin/CreateNewUser'" style="height:100px;width:200px;color:red;" />
</c:if>

<input type="submit" value="View Details" onclick="window.location.href='/Admin/UserDetail'" style="height:100px;width:200px;color:red;"/>
</div>

</body>
</html>