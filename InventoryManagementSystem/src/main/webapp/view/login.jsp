<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>

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
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<div class="card container">
				<div class="card-body m-3 p-3">

					<!-- error -->
					<div class="${classNames}" role="alert">${message}</div>
					<!-- end of error -->

					<form action="login" method="POST">
						<div class="form-group">
							<label for="email">Email</label> <input name="email" type="text"
								class="form-control" id="email" placeholder="email" required>
						</div>
						<div class="form-group">
							<label for="password">Password</label> <input name="password"
								type="password" class="form-control" id="password"
								placeholder="password" required>
						</div>

						<div class="form-group">
							<input type="submit" class="btn btn-primary" value="Login">
						</div>
						<a href="#">Forget password?</a>
					</form>

				</div>
			</div>
		</div>
		<div class="col-md-3"></div>
	</div>

</body>
</html>