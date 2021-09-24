<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Categories</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>

	<!-- header -->
	<jsp:include page="common/header.jsp"></jsp:include>
	<!-- end of header -->

	<br>

	<div class="container">
		<table class="table">
			<thead>
				<tr>
					<th>ID</th>
					<th>Category</th>
					<th>Timestamp</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody id="get_category">

				<%@page import="com.example.demo.models.Category"%>
				<%@page import="java.time.format.DateTimeFormatter"%>
				<%@page import="java.time.ZonedDateTime"%>
				<%
								Iterable<Category> categories = (Iterable) request.getAttribute("categories");
								
								for (Category category : categories) {
									%>

				<tr>
					<td>
						<% out.println(category.getId()); %>
					</td>
					<td>
						<% out.println(category.getName()); %>
					</td>
					<td>
						<%
		        out.println(category.getTimestamp().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss a"))); 
		        %>
					</td>
					<td>
					<button type="button" id="<% out.print(category.getId()); %>" class="deleteBtn btn btn-danger btn-sm">Delete</button>
					</td>
				</tr>

				<%
								}
%>


			</tbody>
		</table>
	</div>

<script>
$(document).ready(function() {
	// crating new click event for save button
	$(".deleteBtn").click(function() {
		var id = +this.id;
		$.ajax({
			url: "delete_category",
			type: "post",
			data: {
				id : id,
			},
			success : function(data){
				location.reload();
			},
			 error: function (request, status, error) {
			        alert(request.responseText);
			    }
		});
	});
});
</script>

</body>
</html>