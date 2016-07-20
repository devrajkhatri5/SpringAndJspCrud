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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
.modal {
    display:    none;
    position:   fixed;
    z-index:    1000;
    top:        0;
    left:       0;
    height:     100%;
    width:      100%;
    background: rgba( 255, 255, 255, .8 ) 
                url('http://i.stack.imgur.com/FhHRx.gif') 
                50% 50% 
                no-repeat;
}


body.loading {
    overflow: hidden;   
}


body.loading .modal {
    display: block;
</style>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

	<link href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet"/>
	<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript">
	
	</script>
	

<title>Insert title here</title>
</head>
<body>
	<div id="userInfoTable" style="margin-top: 100px; margin-left: 20px; margin-right: 20px;">
		<h1 style="color: grey; text-align: center;">UserDetail:</h1>
<%-- 		<jsp:useBean id="pagedListHolder" scope="request" --%>
<%-- 			type="org.springframework.beans.support.PagedListHolder" /> --%>
<%-- 		<c:url value="/Admin/UserDetail" var="pagedLink"> --%>

<%-- 			<c:param name="p" value="~"></c:param> --%>
<%-- 		</c:url> --%>

		<table border="1px;" id="mytable">
		
		<thead>
		
			<tr>
			
				<th style="text-align: center;">UserID</th>

				<th style="text-align: center;">UserName</th>
				<th style="text-align: center;">Gender</th>
				<th style="text-align: center;">UserRole</th>
				<th style="text-align: center;">StateName</th>
				<th style="text-align: center;">DistrictName</th>
				<c:if test="${roleId=='1'}">
				<th style="text-align:center">Action</th>
				</c:if>
			</tr>
			</thead>



			
			<tbody>
			<c:forEach items="${userList}" var="user">
				<tr >
					<td class="userID"><c:out value="${user.login.getId()}"></c:out></td>
					<td class="userName"><c:out value="${user.userName}" /></td>
					<td class="sex"><c:out value="${user.sex}" /></td>
					<td class="userRole"><c:out
							value="${user.userRole.getUserRole()}" /></td>
					<td class="state"><c:out value="${user.state.getStateName()}" /></td>
					<td class="district"><c:out
							value="${user.district.getDistrictName()}" /></td>
							<c:if test="${roleId=='1'}">
					<td><input type="button" value="edit" class="btnEdit"
						onclick="onEditClick(this)" /> <input type="submit"
						value="update" class="update-btn" onclick="onUpdateClick(this,<c:out value="${user.login.getID()}"></c:out>)" /> <input type="submit"
						value="cancel" class="cancel-btn" onclick="onCancelClick(this)" />
						<input type="button" value="Delete" class="btnDelete"
						onclick="deleteUser('<c:out value="${user.login.getID()}"></c:out>',this )" />
					</td>
					</c:if>
				</tr>
				</c:forEach>
				</tbody>
			

		</table>
<%-- 		<tg:paging pagedListHolder="${pagedListHolder}" --%>
<%-- 			pagedLink="${pagedLink}" /> --%>
	</div>
	<div class="modal"><!-- Place at bottom of page --></div>
</body>

<script type="text/javascript">




	$(document).ready(function() {
		$(".update-btn").hide();
		$(".cancel-btn").hide();
		$(".btnEdit").show();
		$(".btnDelete").show();

	});
	$(document).ready(function(){
		
		
		$('#mytable').dataTable({
				"bSort": false});
		});
	
function onUpdateClick(object,ID)
{ 

	var UserID=$(object).closest("tr").find('.userID').find('input').val();
	var UserName=$(object).closest("tr").find('.userName').find('input').val();
	var sex=$(object).closest("tr").find('.sex').find('select').val();
	var state=$(object).closest("tr").find('.state').find('select').val();
	var district=$(object).closest("tr").find('.district').find('select').val();
	var role=$(object).closest("tr").find('.userRole').find('select').val();
	if(UserID==null||UserID==''||UserName==null||UserName=='')
		{
		
		alert("UserID as Well as UserName Cannot be Empty")
		window.location.reload()
		}
	else 
		{
		$.ajax({
			url : "/Admin/UpdateUser",
			type : "POST",
			dataType : "json",
			data : ({
				ID:ID,
				UserID : UserID,
				UserName:UserName,
				sex:sex,
				role:role,
				state:state,
				district:district	
			}),
			success : function(response) {
				
				alert("data updated Sucessfully")
				$(object).closest("tr").children("td").each(function() {
					
					if($(this).is(":last-child")){
						
						$(this).closest("tr").find(".btnEdit").show();
						$(this).closest("tr").find(".btnDelete").show();
						$(this).closest("tr").find(".update-btn").hide();
						$(this).closest("tr").find(".cancel-btn").hide()
						
					}
					else{
					if($(this).attr("class")=="state")
						{
						$(this).html("");
						$(this).append(state);
						}

					else if($(this).attr("class")=="district")
						{
						$(this).html("");
						$(this).append(district);
						}
					else if($(this).attr("class")=="sex")
					{
					$(this).html("");
					$(this).append(sex);
					}
					else if($(this).attr("class")=="userRole")
						{
						$(this).html("");
						$(this).append(role);
						}
					else if($(this).attr("class")=="userName")
					{
					$(this).html("");
					$(this).append(UserName);
					}
					else if($(this).attr("class")=="userID")
					{
					$(this).html("");
					$(this).append(UserID);
					}
					
					
			}
					
				});
			
			},
			error : function(xhr, err) {
				
				alert("Unable to update");

			}

		});

		
		}
	
}
	function deleteUser(userId,object) {
		var UserID = userId;
		var answer = confirm('Are You Sure want to delete')
		if (answer) {
			$.ajax({
				url : "/Admin/ajaxForDeleteUser",
				type : "post",
				data : ({
					UserID : userId
				}),
				dataType : "json",
				success : function(data) {
					if (data==true) {
						
						alert("sucessfully deleted!!!")
						
					//$("#userInfoTable").load(window.location+"#userInfoTable");
					} else {
						alert("Unable to delete")
					}
				},
				complete:function()
				{
					$(object).closest("tr").remove();
				}
				
				

			});
			

		} else {
			alert("Your record is safe.")

		}
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
								var input = $("<input type='text'name='login.Id' value='"+userID+"'/>");
								$(this).closest('.userID').append(input);
                                	}
                                else if($(this).attr("class")=="userName")
                                	{
								var userName = $(this).closest('.userName')
										.html();
								$(this).closest('.userName').html("");
								var input = $("<input type='text' name='userName' value='"+userName+"'/>");
								$(this).closest('.userName').html(input);
                                	}
                                else if($(this).attr("class")=="sex")
                                	{
								var sex = $(this).closest('.sex').html();
								var gender;
								if (sex ='Male') {
									gender='Female';
								}else if (sex ='Female') {
									gender='Male';
								}
								$(this).closest('.sex').html("");
								var input = $("<select name='sex'><option  value=Male >Male</option><option value=Female>Female</option></select>");
										
								$(this).closest('.sex').html(input);
                                	}
                                else if($(this).attr("class")=="userRole")
                                	{
                                	var userRole = $(this).closest('.userRole')
									.html();
								$(this).closest('.userRole').html("");
								var input = $("<select name='userRole.roleId' ></select>");
								$(this).closest('.userRole').html(input);
								input.append($("<option selected='selected'></option>")
										.attr("value", userRole).text(userRole));
								 appendDropDownListForUserRole(userRole, input);
                                	}
                                else if($(this).attr("class")=="state")
                                	{
								var stateName = $(this).closest('.state').html();
								$(this).closest('.state').html("");
								var input = $("<select name='state.stateId'onchange='valueChange(this)'></select>");
								$(this).closest('.state').html(input);
								input.append($("<option selected='selected'></option>").attr("value", stateName)
										.text(stateName));
								appendDropDownListForState(input, stateName);
                                	}
                                else if($(this).attr("class")=="district")
                                	{
                                	var stateName = $(this).closest("tr").find('.state option:selected').text();
   								var district = $(this).closest('.district')	.html();
  								$(this).closest('.district').html("");
  								 var input = $("<select name='district.districtId''></select>");
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
	function onCancelClick(object) {
		$(object).closest("tr").children("td").each(function() {
			
			if($(this).is(":last-child")){
				
				$(this).closest("tr").find(".btnEdit").show();
				$(this).closest("tr").find(".btnDelete").show();
				$(this).closest("tr").find(".update-btn").hide();
				$(this).closest("tr").find(".cancel-btn").hide()
				
			}
			else{
			if($(this).attr("class")=="state")
				{
				var text = $(this).find('select').val();
				$(this).html("");
				$(this).append(text);
				}

			else if($(this).attr("class")=="district")
				{
				var text = $(this).find('select').val();
				$(this).html("");
				$(this).append(text);
				}
			else if($(this).attr("class")=="sex")
			{
			var text = $(this).find('select').val();
			$(this).html("");
			$(this).append(text);
			}
			else if($(this).attr("class")=="userRole")
				{
				var text = $(this).find('select').val();
				$(this).html("");
				$(this).append(text);
				}
			else{
			var text = $(this).find('input').val();
			$(this).html("");
			$(this).append(text);
			}
	}
			
		});
	}
	
	function valueChange(object)
	{
		
		 var stateName=$(object).val();
		 	$(object).closest("tr").find('.district')
	 		              .empty();
		 	$(object).closest("tr").find('.district')
	             .append($("<select name='state.stateId'></select>"));
		 $.ajax({
				url : "/Admin/ajaxforDropDownListForDistrict",
	 				type : "POST",
		 			data : ({
	 	 				stateName :stateName 
	 	 			}),
		 			dataType : "json",
		 			success : function(data) {
		 			
	                   
	 	 				$.each(data, function(key, value) {
 		 		               $(object).closest("tr").find('.district').find('select')
 		 		             .append($("<option></option>").attr("value", value)
 	 	 								.text(value));
		 	 	 						 	 							 							 					
	 	 			});
	 	 				
		 			}
	 	 		});
	}

function appendDropDownlistForDistrict(district, input, stateName) {
 	 		$.ajax({
			url : "/Admin/ajaxforDropDownListForDistrict",
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

			url : "/Admin/ajaxForUserRole",
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

			url : "/Admin/ajaxForStateList",
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
	
	$body = $("body");

	$(document).on({
	    ajaxStart: function() { $body.addClass("loading");    },
	     ajaxStop: function() { $body.removeClass("loading"); }    
	});

</script>
</html>