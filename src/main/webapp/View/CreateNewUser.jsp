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

	<form Method="POST" action="AddUser" onsubmit="return validateForm()">
		<div align="center" style="margin-top: 100px;">
			<h1 style="color: grey">Add New User</h1>
			<table>
			<tr>
			<td>${msg}</td></tr>
				<tr>
				
					<td>UserID:</td>
					<td><input type="text" type="text" name="login.Id" id="userID"></td>
				</tr>
				<tr>
					<td>UserName:</td>
					<td><input type="text" type="text" name="userName"
						id="userName"></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><input id="password" type="text" type="text"
						name="login.password" id="password"></td>
				</tr>

				<tr>
					<td>Sex:</td>
					<td><select name='sex' id="sex">
							<option value=''>----please select---</option>
							<option value='Male'>Male</option>
							<option value='Female'>Female</option>
					</select></td>

				</tr>
			
				
				<tr>
					<td>Assign Role:</td>
					<td><select name="userRole.roleId" id="userRole">
							<option value=''>---select role--</option>
					</select></td>
				</tr>
				<tr>
					<td>State :</td>
					<td><select name="state.stateId" id="state">
							<option value=''>---select state--</option>

					</select></td>
				</tr>

				<tr>

					<td>Select District:</td>
					<td><select name="district.districtId" id="district">

					</select></td>
				</tr>
				<tr>
					<td><input type="submit" value="submit"/></td>
				</tr>

			</table>

		</div>
	</form>
	<script type="text/javascript">
		function validateForm() {
			var Id = document.getElementById("userID").value;
			var userName=document.getElementById("userName").value;
			var password = document.getElementById("password").value;
			var sex = document.getElementById("sex").value;
			
			var userRole = document.getElementById("userRole").value;
			var state = document.getElementById("state").value;
			var district = document.getElementById("district").value;
			
			
			if (Id == null || Id == "" ||userName==null ||userName=="" || password == null || password == ""||userRole == ''||state==''||sex == ''|| district == '')
			{
				alert('All Field Should be Filled before  Submitting');
				return false;
			} 
			

		}

		$('#state').change(
				function() {
					var stateID = $('#state').val();

					$.ajax({
						url : "/Admin/ajaxforDistrictList",
						type : "POST",
						dataType : "json",
						data : ({
							stateID : stateID
						}),
						success : function(response) {
							$('#district').empty();
							$('#district').append(
									$("<option></option>").attr("value", '')
											.text('Please Select'));
							$.each(response, function(key, value) {
								$('#district').append(
										$("<option></option>").attr("value",
												key).text(value));
							});

						},
						error : function(xhr, err) {
							alert(err)
							alert(xhr)
							alert("Unable to populate dropdownlist");

						}

					});

				});
		$(document)
				.ready(
						function() {

							$
									.ajax({

										url : "/Admin/ajaxForUserRole",
										type : "GET",
										dataType : "json",
										success : function(data) {
											$.each(data, function(key, value) {
												$('#userRole').append(
														$("<option></option>")
																.attr("value",
																		key)
																.text(value));
											});
										},
										error : function() {

											alert("Unable to populate dropdownlist please contact Admin");
										}

									});

						});
		
		
	$(document).ready(function(){
		$.ajax({
	

			url : "/Admin/ajaxForStateList",
			type : "GET",
			dataType : "json",
			success : function(data) {

				$.each(data, function(key, value) {

					$('#state').append(
							$("<option></option>").attr("value", key).text(
									value));

				});
			},
			error : function() {

				alert("Unable to populate dropdownlist please contact Admin");
			}

		});
	});
	</script>
</body>


</html>




