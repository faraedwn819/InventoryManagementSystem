<!-- Modal -->
<div class="modal fade" id="form_products" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Add new product</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="product_form" action="save_product" method="POST">
					<div class="form-row">
						<div class="form-group col-md-6">

							<label>Product Name</label> <input type="text"
								class="form-control" name="product_name" id="product_name"
								placeholder="Enter Product name" required>
						</div>
						<div class="form-group col-md-6">
							<label>Category</label> <select class="form-control"
								id="product_category_id" name="product_category_id" required>

								<%@page import="com.example.demo.models.Category"%>
								<%
								Iterable<Category> categories = (Iterable) request.getAttribute("categories");
								
								for (Category category : categories) {
									%>
								<option value="<% out.println(category.getId()); %>">
									<% out.println(category.getName()); %>
								</option>
								<%
								}
%>

							</select>
						</div>
					</div>
					<div class="form-group">
						<label>Product Date</label> <input type="date"
							class="form-control" id="product_date" name="product_date"
							placeholder="Enter product date" required />
					</div>
					<div class="form-group">
						<label>Price</label> <input type="text" class="form-control"
							id="product_price" name="product_price" placeholder="Enter price"
							required />
					</div>
					<div class="form-group">
						<label>Quantity</label> <input type="text" class="form-control"
							id="product_qty" name="product_qty" placeholder="Enter Quantity"
							required />
					</div>
					<button type="submit" class="btn btn-success">Add Product</button>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>