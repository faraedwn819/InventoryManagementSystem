<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Products</title>

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
		        <th>Name</th>
		        <th>Category</th>
		        <th>price</th>
		        <th>Quantity</th>
		        <th>Production Date</th>
		        <th>Timestamp</th>
		        <th>Action</th>
		      </tr>
		    </thead>
		    <tbody id="get_category">
		    
<%@page import="com.example.demo.models.Product"%>
		    <%@page import="java.time.format.DateTimeFormatter"%>
		     <%@page import="java.time.ZonedDateTime"%>
								<%
								Iterable<Product> products = (Iterable) request.getAttribute("products");
								
								for (Product product : products) {
									%>
									
									<tr>
		        <td><% out.println(product.getId()); %></td>
		        <td><% out.println(product.getName()); %></td>
		        <td><% out.println(product.getCategory().getName()); %></td>
		        <td><% out.println(product.getPrice()); %></td>
		        <td><% out.println(product.getQuantity()); %></td>
		        <td> <% out.println(product.getProduct_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))); %> </td>
		        <td> <% out.println(product.getTimestamp().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))); %> </td>
		        <td>
		        	<button type="button" id="<% out.print(product.getId()); %>" class="deleteBtn btn btn-danger btn-sm">Delete</button>
		        </td>
		      </tr>
		      
								<%
								}
%>

		    </tbody>
		  </table>
	</div>

</body>

<script>
$(document).ready(function() {
	// crating new click event for save button
	$(".deleteBtn").click(function() {
		var id = +this.id;
		$.ajax({
			url: "delete_product",
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

</html>