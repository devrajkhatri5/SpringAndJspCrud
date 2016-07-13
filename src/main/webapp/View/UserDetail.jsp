<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form"%>
<%@page import="com.spring.model.UserDetail"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.btnEdit {
	color: #FFFFFF;
	background:#8A2BE2;
	font-weight: bold;
	width: 100%;
}

.btnDelete {
	color: #FFFFFF;
	background: Red;
	font-weight: bold;
	width: 100%;
}

table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	padding: 8px;
	border-bottom: 1px solid #ddd;
	text-align: center;
}

tr:nth-child(even) {
	background-color: #f2f2f2
}

tr:hover {
	background-color: #f5f5f5
}
</style>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div id="userInfoTable" style="margin-top: 100px; margin-left: 20px; margin-right: 20px;">
		<h1 style="color: grey; text-align: center;">UserDetail:</h1>
		<jsp:useBean id="pagedListHolder" scope="request"
			type="org.springframework.beans.support.PagedListHolder" />
		<c:url value="/UserDetail" var="pagedLink">

			<c:param name="p" value="~"></c:param>
		</c:url>

		<table border="1px;" >
			<tr>
				<th style="text-align: center;">UserID</th>

				<th style="text-align: center;">UserName</th>
				<th style="text-align: center;">Gender</th>
				<th style="text-align: center;">DateOfBirth</th>
				<th style="text-align: center;">UserRole</th>
				<th style="text-align: center;">StateName</th>
				<th style="text-align: center;">DistrictName</th>
				<th style="text-align:center">Action</th>
			</tr>

			<c:forEach items="${pagedListHolder.pageList}" var="user">

				<tr>
					<td class="userID"><c:out value="${user.login.getId()}"></c:out></td>
					<td class="userName"><c:out value="${user.userName}" /></td>
					<td class="sex"><c:out value="${user.sex}" /></td>
					<td class="dateOfBirth"><c:out value="${user.dateOfBirth}" /></td>
					<td class="userRole"><c:out
							value="${user.userRole.getUserRole()}" /></td>
					<td class="state"><c:out value="${user.state.getStateName()}" /></td>
					<td class="district"><c:out
							value="${user.district.getDistrictName()}" /></td>
					<td><input type="button" value="edit" class="btnEdit"
						onclick="onEditClick(this)" /> <input type="submit"
						value="update" class="update-btn" /> <input type="submit"
						value="cancel" class="cancel-btn" onclick="onCancelClick(this)" />
						<input type="button" value="Delete" class="btnDelete"
						onclick="deleteUser('<c:out value="${user.login.getID()}"></c:out>' )" />
					</td>




				</tr>
			</c:forEach>

		</table>
		<tg:paging pagedListHolder="${pagedListHolder}"
			pagedLink="${pagedLink}" />
	</div>
</body>

<script type="text/javascript">
	$(document).ready(function() {
		$(".update-btn").hide();
		$(".cancel-btn").hide();
		$(".btnEdit").show();
		$(".btnDelete").show();

	});

	function deleteUser(userId) {
		var UserID = userId;
		var answer = confirm('Are You Sure want to delete?')
		if (answer) {
			$.ajax({
				url : "ajaxForDeleteUser",
				type : "post",
				data : ({
					UserID : userId
				}),
				dataType : "json",
				success : function(data) {
					if (data==true) {
						alert("sucessfully deleted!!!")
					$("#userInfoTable").load(window.location+"#userInfoTable")
					} else {
						alert("Unable to delete")
					}
				}

			});

		} else {
			alert("Your record is safe.")

		}
	}

	function onCancelClick(object) {
		$(object).closest("tr").children("td").each(function() {

			var userID = $(this).find('.userID').val();
			$(this).closest('.userID').html("");
			$(this).closest('.userID').append(userID);
			var userName = $(this).find('.userName').val();
			$(this).closest('.userName').html("");
			$(this).closest('.userName').append(userName);
			var sex = $(this).find('.sex').val();
			$(this).closest('.sex').html("");
			$(this).closest('.sex').append(sex);
			var userRole = $(this).find(".userRole").val();
			$(this).closest('.userRole').html("");
			$(this).closest('.userRole').append(userRole);
			var stateName = $(this).find(".state").val();
			$(this).closest('.state').html("");
			$(this).closest('.state').append(stateName);
			var dateOfBirth = $(this).find(".dateOfBirth").val();
			$(this).closest('.dateOfBirth').html("");
			$(this).closest('.dateOfBirth').append(dateOfBirth);
			var districtName = $(this).find(".district").val();
			$(this).find('.district').html("");
			$(this).find('.district').append(districtName);
			$(this).closest("tr").find(".btnEdit").show();
			$(this).closest("tr").find(".btnDelete").show();
			$(this).closest("tr").find(".update-btn").hide();
			$(this).closest("tr").find(".cancel-btn").hide();
		});
	}

	function onEditClick(object) {
		$(object)
				.closest("tr")
				.children('td')
				.each(
						function() {
					
							if ($(this).is(":last-child")) {
							} else {
                                if($(this).attr("class")=="userID")
                                	{	
								var userID = $(this).closest('.userID').html();
								$(this).closest('.userID').html("");
								var input = $("<input type='text' class='userID' name='login.Id' value='"+userID+"'/>");
								$(this).closest('.userID').append(input);
                                	}
                                else if($(this).attr("class")=="userName")
                                	{
								var userName = $(this).closest('.userName')
										.html();
								$(this).closest('.userName').html("");
								var input = $("<input type='text' class='userName' name='userName' value='"+userName+"'/>");
								$(this).closest('.userName').html(input);
                                	}
                                else if($(this).attr("class")=="sex")
                                	{
								var sex = $(this).closest('.sex').html();
								var gender;
								if (sex == "Male") {
									gender = "Female";
								} else if (sex == "Female") {
									gender = "Male";
								}
								$(this).closest('.sex').html("");
								var input = $("<input type='radio' class='sex' name='sex' value='"+sex+"' checked/>"
										+ sex
										+ "</br><input type='radio' class='sex' name='sex'/>'"
										+ gender + "'");
								$(this).closest('.sex').html(input);
                                	}
                                else if($(this).attr("class")=="dateOfBirth")
                                	{
                                	
								var dateOfBirth = $(this).closest(
										'.dateOfBirth').html();
								$(this).closest('.dateOfBirth').html("");
								var input = $("<input type='text' class='dateOfBirth' name='dateOfBirth' value='"+dateOfBirth+"'/>");
								$(this).closest('.dateOfBirth').html(input);
								
                                	}
                                else if($(this).attr("class")=="userRole")
                                	{
                                	var userRole = $(this).closest('.userRole')
									.html();
								$(this).closest('.userRole').html("");
								var input = $("<select name='userRole.roleId' class='userRole'></select>");
								$(this).closest('.userRole').html(input);
								input.append($("<option selected='selected'></option>")
										.attr("value", userRole).text(userRole));
								 appendDropDownListForUserRole(userRole, input);
                                	}
                                else if($(this).attr("class")=="state")
                                	{
								var stateName = $(this).closest('.state').html();
								$(this).closest('.state').html("");
								var input = $("<select name='state.stateId' class='state' onchange='valueChange(this)'></select>");
								$(this).closest('.state').html(input);
								input.append($("<option selected='selected'></option>").attr("value", stateName)
										.text(stateName));
								appendDropDownListForState(input, stateName);
                                	}
                                else if($(this).attr("class")=="district")
                                	{
                                	var stateName = $(this).closest("tr").find('.state option:selected').text();
                                	alert(stateName)
   								var district = $(this).closest('.district')	.html();
  								$(this).closest('.district').html("");
  								 var input = $("<select name='district.districtId' class='district'></select>");
  								 $(this).closest('.district').html(input);
  								 input.append($("<option selected='selected'></option>").attr("value", district)
 									.text(district));
  								appendDropDownlistForDistrict(district,input,
  										stateName);
                                	}

								$(this).closest("tr").find(".btnEdit").hide();
								$(this).closest("tr").find(".btnDelete").hide();
								$(this).closest("tr").find(".update-btn")
										.show();
								$(this).closest("tr").find(".cancel-btn")
										.show();
								
							}

						});

	}
	
	function valueChange(object)
	{
		
		 var stateName=$(object).val();
		 	$(object).closest("tr").find('.district')
	 		              .empty();
		 	$(object).closest("tr").find('.district')
	             .append($("<select class='.district'></select>"));
		 $.ajax({
				url : "ajaxforDropDownListForDistrict",
	 				type : "POST",
		 			data : ({
	 	 				stateName :stateName 
	 	 			}),
		 			dataType : "json",
		 			success : function(data) {
		 			
	                   
	 	 				$.each(data, function(key, value) {
 		 		               $(object).closest("tr").find('.district')
 		 		             .append($("<option></option>").attr("value", key)
 	 	 								.text(value));
		 	 	 					
	 	 					
	 	 					
	 	 						//$(this).closest("tr").find('.district').append($("<option></option>").attr("value", key)
	 	 								//.text(value));
	 	 					
		 					
		 					
	 	 			});
	 	 				
		 			}
		 
		 
	 	 		});
		
		
	}


 	 	function appendDropDownlistForDistrict(district, input, stateName) {
 	 		$.ajax({
			url : "ajaxforDropDownListForDistrict",
 				type : "POST",
	 			data : ({
 	 				stateName :stateName 
 	 			}),
	 			dataType : "json",
	 			success : function(data) {
                   
 	 				$.each(data, function(key, value) {
	 					
 	 					if (value == district) {
                    
	 					}
 	 					else {
 	 						input.append($("<option></option>").attr("value", key)
 	 								.text(value));
 	 					}
	 					
	 					
 	 			});
	 			}
 	 		});

 		}
	function appendDropDownListForUserRole(userRole, input) {
		$.ajax({

			url : "ajaxForUserRole",
			type : "GET",
			dataType : "json",
			success : function(data) {

				$.each(data, function(key, value) {
					if (value == userRole) {

					} else {
						input.append($("<option></option>")
								.attr("value", value).text(value));
					}
					
				});
			}
		});

	}

	function appendDropDownListForState(input, stateName) {
		$.ajax({

			url : "ajaxForStateList",
			type : "GET",
			dataType : "json",
			success : function(data) {

				$.each(data, function(key, value) {
					if (value == stateName) {

					}
					else{
					input.append($("<option></option>").attr("value", value)
							.text(value));
					}
				});
			}
		});

	}
</script>
</html>