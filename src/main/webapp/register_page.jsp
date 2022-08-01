<%@page import="com.tech.blog.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User user = (User) session.getAttribute("currentuser");
if (user != null) {
	response.sendRedirect("profile.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration</title>


<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
	crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet" type="text/css">

</head>
<body>
	<!-- navbar -->

	<%@include file="normal_navbar.jsp"%>
	<main class="primary-background  banner-background"
		style="padding-bottom: 100px">
		<div class="container">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-header primary-background text-center text-white">
						<span class="fa fa-user-plus fa-3x"></span><br>Register Here
					</div>
					<div class="card-body">
						<form id="reg-form" action="RegisterServlet" method="POST">
							<div class="mb-3">
								<label for="user_name" class="form-label">Username</label> <input
									name="user_name" required type="text" class="form-control"
									id="user_name">
								<div id="emailHelp" class="form-text"></div>
							</div>
							<div class="mb-3">
								<label for="exampleInputEmail1" class="form-label">Email
									address</label> <input name="user_email" required type="email"
									class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp">
								<div id="emailHelp" class="form-text">We'll never share
									your email with anyone else.</div>
							</div>
							<div class="mb-3">
								<label for="exampleInputPassword1" class="form-label">Password</label>
								<input name="user_password" required type="password"
									class="form-control" id="exampleInputPassword1">
							</div>
							<div class="mb-3">
								<label for="gender">Gender</label> <br> <input type="radio"
									id="gender" name="gender" required value="male">Male <input
									type="radio" id="gender" name="gender" value="female">Female
							</div>
							<div class="form-group">
								<textarea name="about" class="form-control" id="" cols=""
									rows="5" placeholder="Enter Something about yourself."></textarea>


							</div>
							<div class="mb-3 form-check">
								<input name="check" type="checkbox" class="form-check-input"
									id="exampleCheck1"> <label class="form-check-label"
									for="exampleCheck1">I agree to terms and conditions.</label>
							</div>
							<div class="container text-center" id="loader"
								style="display: none;">
								<span class="fa fa-refresh fa-spin fa-4x"></span>
								<h4>Please Wait...</h4>
							</div>
							<br>
							<button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>



	<!--javascript  -->

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js"
		integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa"
		crossorigin="anonymous"></script>



	<script src="js/myjs.js" type="text/javascript"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"
		integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>
	$(document).ready(function(){
		console.log("loaded...")
		$('#reg-form').on('submit', function(event){
			event.preventDefault();
			
			let form = new FormData(this);
			$("#submit-btn").hide();
			$("#loader").show();
		
			$.ajax({
				url:"RegisterServlet",
				type: 'POST',
				data: form,
				success: function(data, textStatus, jqXHR){
					console.log(data)
					$("#submit-btn").show();
					$("#loader").hide();
					if(data.trim()==='done'){
					swal("Registration is successfull. Kindly login to continue.")
					.then((value) => {
					  window.location = "login_page.jsp"
					});}
					else{
						swal(data);
					}
				},
				error: function(jqXHR, textStatus, errorThrown){
					cosnole.log(jqXHR)
					$("#submit-btn").show();
					$("#loader").hide();
					swal("Something went wrong. Try again.")
				},
				processData: false,
				contentType: false
			});
		});
		
	});
	</script>
</body>
</html>