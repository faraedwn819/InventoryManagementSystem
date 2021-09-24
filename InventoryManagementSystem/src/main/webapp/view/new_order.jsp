<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>New Order</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"
	integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"
	integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"
	integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script>
function selectOption(e){
	var arr = $(e).find('option:selected').val().split("||");
	var catId = arr[0];
	var quantity = arr[1];
	var price = arr[2];
	
	$(e).parent().siblings().each(function( index ) {
		
		// total quantity
		if(index==1){
			$( this ).children().each(function( index2 ) {
				if(index2==0){
					$( this ).val(quantity);
				}
				});
		}
		
		// quantity
		if(index==2){
			$( this ).children().each(function( index2 ) {
				if(index2==0){
					$( this ).val("1");
				}
				});
		}
		
		// price
		if(index==3){
			$( this ).children().each(function( index2 ) {
				if(index2==0){
					$( this ).val(price);
				}
				});
		}
		
		// total
		if(index==4){
			$( this ).text(price);
		}
	});
	
	
	//$( this ).css({"color": "red", "border": "2px solid red"});
	//alert(price);
	calculateSubTotal();
	}
	
function changeTotal(e){
	var price = 0;
	var totalQuantity = 0;
	$( e ).parent().siblings().each(function( index ) {
		
		// get total quantity
		if(index == 2){
			$( this ).children().each(function( index2 ) {
				if(index2 ==0){
					totalQuantity = $(this).val();
					if(parseInt(totalQuantity) < e.value){
						$(e).val(totalQuantity);
						alert("your quantity number must be less than total quantuty!");
					}
					
				}
			}
			);
		}
		
		// get price
		if(index == 3){
			$( this ).children().each(function( index2 ) {
				if(index2 ==0){
					price = $(this).val();
				}
			}
			);
		}
	
		// print total
		if(index == 4){
			$( this ).text((e.value*price)+"");
		}
	});
	
	calculateSubTotal();
}

// calculate sub total
function calculateSubTotal(){
	var subTotal = 0;
	$(".totalPrice").each(function( index ) {
		if($(this).text()){
			subTotal += parseInt($(this).text());
		}
	});
	
	$("#sub_total").val(subTotal);
	$("#paid").val(0);
	$("#due").val(subTotal);
}

// calculate due
function calculateDue(e){
	$("#due").val( $("#sub_total").val() - e.value );
}
	
 	$(document).ready(function(){

 		$("#add").click(function(){
 			var lastRow = $("#invoice_item").children("tr:last").html();
 			$("#invoice_item").append('<tr>'+lastRow+'</tr>');
 			
 			// remove total
 			$("#invoice_item").children("tr:last").children("td:last").text("");
 			
 			// increment
 			var boldElement = $("#invoice_item").children("tr:last").children("td:first").children("b:first");
 			boldElement.text(parseInt(boldElement.text())+1);
 			
 			calculateSubTotal();
 		})

 		$("#remove").click(function(){
 			
 			if($("#invoice_item").children().length > 1){
 				$("#invoice_item").children("tr:last").remove();
 			}
 			calculateSubTotal();
 		});
 		
 	});
 	
 	</script>
</head>
<body>
	<div class="overlay">
		<div class="loader"></div>
	</div>

	<!-- header -->
	<jsp:include page="common/header.jsp"></jsp:include>
	<!-- end of header -->

	<br />

	<div class="container">
		<div class="row">
			<div class="col-md-10 mx-auto">
				<div class="card" style="box-shadow: 0 0 25px 0 lightgrey;">
					<div class="card-header">
						<h4>New Order</h4>
					</div>
					<div class="card-body">
						<form id="get_order_data" action="new_order" method="POST">
							<div class="form-group row">
								<label class="col-sm-3 col-form-label" align="right">Order
									Date</label>
								<div class="col-sm-6">
									<%@page import="java.time.format.DateTimeFormatter"%>
									<%@page import="java.time.ZonedDateTime"%>
									<input type="text" id="order_date" name="order_date" readonly
										class="form-control form-control-sm"
										value="<%
				  						out.println(ZonedDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
								  %>">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3 col-form-label" align="right">Customer
									Name*</label>
								<div class="col-sm-6">
									<input type="text" id="cust_name" name="cust_name"
										class="form-control form-control-sm"
										placeholder="Enter Customer Name" required />
								</div>
							</div>


							<div class="card" style="box-shadow: 0 0 15px 0 lightgrey;">
								<div class="card-body">
									<h3>Make a order list</h3>
									<table align="center" style="width: 800px;">
										<thead>
											<tr>
												<th>#</th>
												<th style="text-align: center;">Item Name</th>
												<th style="text-align: center;">Total Quantity</th>
												<th style="text-align: center;">Quantity</th>
												<th style="text-align: center;">Price</th>
												<th>Total</th>
											</tr>
										</thead>
										<tbody id="invoice_item">

											<tr>
												<td><b id="number">1</b></td>
												<td><select name="pid[]"
													class="form-control form-control-sm" required onchange="selectOption(this)">

														<option value="">Choose Product</option>

														<%@page import="com.example.demo.models.Product"%>
														<%@page import="java.time.format.DateTimeFormatter"%>
														<%@page import="java.time.ZonedDateTime"%>
														<%
								Iterable<Product> products = (Iterable) request.getAttribute("products");
								
								for (Product product : products) {
									%>

														<option value="<% out.print(product.getId() +"||"+ product.getQuantity() + "||"+ product.getPrice()); %>">
															<% out.println(product.getName()); %>
														</option>

														<%
								}
%>

												</select></td>
												<td><input name="tqty[]" readonly type="text"
													class="form-control form-control-sm"></td>
												<td><input name="qty[]" type="text"
													class="form-control form-control-sm" required onkeyup="changeTotal(this)" value=""></td>
												<td><input name="price[]" type="text"
													class="form-control form-control-sm" readonly></td>
												<td class="totalPrice"></td>
											</tr>

										</tbody>
									</table>

									<center style="padding: 10px;">
										<button id="add" style="width: 150px;" class="btn btn-success">Add</button>
										<button id="remove" style="width: 150px;"
											class="btn btn-danger">Remove</button>
									</center>
								</div>
							</div>

							<p></p>
							<div class="form-group row">
								<label for="sub_total" class="col-sm-3 col-form-label"
									align="right">Sub Total</label>
								<div class="col-sm-6">
									<input type="text" readonly name="sub_total"
										class="form-control form-control-sm" id="sub_total" required />
								</div>
							</div>
							<div class="form-group row">
								<label for="paid" class="col-sm-3 col-form-label" align="right">Paid</label>
								<div class="col-sm-6">
									<input type="text" name="paid"
										class="form-control form-control-sm" id="paid" required onkeyup="calculateDue(this)">
								</div>
							</div>
							<div class="form-group row">
								<label for="due" class="col-sm-3 col-form-label" align="right">Due</label>
								<div class="col-sm-6">
									<input type="text" readonly name="due"
										class="form-control form-control-sm" id="due" required />
								</div>
							</div>

							<center>
								<input type="submit" id="order_form" style="width: 150px;"
									class="btn btn-info" value="Order">
							</center>


						</form>

					</div>
				</div>
			</div>
		</div>
	</div>



</body>
</html>