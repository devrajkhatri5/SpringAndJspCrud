<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
	
</script>
</head>
<body>

	<form action="/AddUser" method="post">
		<div align="center" style="margin-top: 100px;">
		<h1 style="color:grey">Add New User</h1>
			<table>
				<tr>
					<td>UserID:</td>
					<td><input type="text" type="text" name="login.Id"></td>
				</tr>
				<tr>
					<td>UserName:</td>
					<td><input type="text" type="text" name="userName"></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><input id="password" type="text" type="text"
						name="login.password"></td>
				</tr>
				<tr>
					<td>Confirmpassword:</td>
					<td><input id="confirmpasssword" type="text"
						name="confirmPassword">
						<p id="errorMessage"></p></td>
				</tr>
			<tr>
			<td>Sex:</td>
			<td>
			<input type="radio" name="sex" value="Male">Male
			<input type="radio" name="sex" value="Female">Female
			
			</td>
			
			</tr>
				<tr>
					<td>MobileNumber:</td>
					<td><input type="text" type="text" name="mobileNumber"></td>
				</tr>
				<tr>
					<td>Date of Birth</td>
					<td><input type="text" type="text" name="dateOfBirth"></td>
				</tr>
				<tr>
					<td>Assign Role:</td>
					<td><select name="userRole.roleId">
							<option>---select role--</option>
							<c:forEach items="${roles}" var="item">
								<option value="${item.key}">${item.value}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td>State :</td>
					<td><select name="state.stateId" id="state">
							<option>---select state--</option>
							<c:forEach items="${states}" var="item">
								<option value="${item.key}">${item.value}</option>
							</c:forEach>
					</select></td>
				</tr>

				<tr>

					<td>Select District:</td>
					<td><select name="district.districtId" id="district">

					</select></td>
				</tr>
				<tr>
					<td><input type="submit" value="create user"></td>
				</tr>

			</table>

		</div>
	</form>


	<script type="text/javascript">
	
 		
//  			$('#confirmpasssword').keyup()(function() {

//  				var password = $('#password').val();
//  				var confirmpassword = $('#confirmpasssword').val();
//  				if (password != confirmpassword) {
//  					alert("password mismatch");
//  				}
//  			});
 		
		$('#state').change(
				function() {
					var stateID = $('#state').val();

					$.ajax({
						url : "ajaxforDistrictList",
						type : "POST",
						dataType : "json",
						data : ({
							stateID : stateID
						}),
						success : function(data) {
							$('#district').empty();
							$('#district').append(
									$("<option></option>").attr("value", '')
											.text('Please Select'));
							$.each(data, function(key, value) {
								$('#district').append(
										$("<option></option>").attr("value",
												key).text(value));
							});

						},
						error : function() {
							alert("Unable to populate dropdownlist");

						}

					});

				});
	</script>


</body>


</html>




