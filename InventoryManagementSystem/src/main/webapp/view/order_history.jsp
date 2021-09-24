<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order History</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

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
		        <th>Customer Name</th>
		        <th>Subtotal</th>
		        <th>Paid</th>
		        <th>Due</th>
		        <th>Timestamp</th>
		      </tr>
		    </thead>
		    <tbody id="get_category">
		    
<%@page import="com.example.demo.models.Order"%>
		    <%@page import="java.time.format.DateTimeFormatter"%>
		     <%@page import="java.time.ZonedDateTime"%>
								<%
								Iterable<Order> orders = (Iterable) request.getAttribute("orders");
								
								for (Order order : orders) {
									%>
									
									<tr>
		        <td><% out.println(order.getId()); %></td>
		        <td><% out.println(order.getCustomer_name()); %></td>
		        <td><% out.println(order.getSubtotal()); %></td>
		        <td><% out.println(order.getPaid()); %></td>
		        <td><% out.println(order.getDue()); %></td>
		        <td> <% out.println(order.getTimestamp().format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss a"))); %> </td>
		      </tr>
		      
								<%
								}
%>

		    </tbody>
		  </table>
	</div>

</body>
</html>