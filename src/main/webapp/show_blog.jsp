<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="Error_page.jsp"%>
<%
User user = (User) session.getAttribute("currentuser");
if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>

<%
int postId = Integer.parseInt(request.getParameter("post_id"));
PostDao pdao = new PostDao(ConnectionProvider.getConnection());
Post p = pdao.getPostById(postId);
UserDao ud = new UserDao(ConnectionProvider.getConnection());
User u = ud.getUserByUserId(p.getUserId()); // The user who posted the blog.
LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
int noOfLikes = ld.countLikeOnPost(p.getPid());

%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Techblog | <%=p.getpTitle()%></title>
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
<style>
body {
	background: url(pics/wallpaper.jpg);
	background-size: cover;
	background-attachment: fixed;
}
</style>
<div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v14.0"></script>
</head>
<body>

	<!-- navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<div class="container-fluid">
			<a class="navbar-brand" href="index.jsp"><span
				class="fa fa-asterisk"></span>Techblog</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="profile.jsp"><span
							class="fa fa-bell-o"></span>All Posts</a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="true"> <span
							class="fa fa-check-square-o"></span>Dropdown
					</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">Action</a></li>
							<li><a class="dropdown-item" href="#">Another action</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">Something else
									here</a></li>
						</ul></li>

					<li class="nav-item"><a class="nav-link" href="#"
						data-bs-toggle="modal" data-bs-target="#add-post-modal"><span
							class="fa fa-edit"></span>Create Post</a></li>

				</ul>
				<ul class="navbar-nav mr-right">
					<li class="nav-item"><a class="nav-link" href="#"
						data-bs-toggle="modal" data-bs-target="#profile-Modal"><span
							class="fa fa-user-circle"></span><%=user.getName()%></a></li>

					<li class="nav-item"><a class="nav-link" href="LogoutServlet"><span
							class="fa fa-sign-out"></span>Logout</a></li>

				</ul>
			</div>
		</div>
	</nav>

	<!-- end of navbar -->


	<!-- main body of show blog -->
	<div class="container">
		<div class="row my-4">
			<div class="col-md-8 offset-md-2">
				<div class="card">
					<div class="card-header primary-background text-white">
						<h4><%=p.getpTitle()%></h4>
					</div>
					<div class="card-body">
						<p><%=p.getpContent()%></p>
						<br> <img src="blog_pics/<%=p.getpPic()%>"
							class="card-img-top my-2" alt="Card cap image"> <br>
						<div class="row my-3 row-user">
							<div class="col-md-8">
								<p class="post-user-info">
									Posted By: <a href="#"><%=u.getName()%></a>
								</p>
							</div>
							<div class="col-md-4">
								<p class="post-date"><%=DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
							</div>
						</div>
						<pre><%=p.getpCode()%></pre>
					</div>
					<div class="card-footer primary-background text-white text-center">

						<a href="#" onclick="doLike(<%=p.getPid() %>,<%=user.getId() %>)" class="btn btn-outline-light btn-sm"><i
							class="fa fa-thumbs-o-up"><span class="like-counter">  <%=noOfLikes %></span></i></a> <a href="#"
							class="btn btn-outline-light btn-sm"><i
							class="fa fa-commenting-o"><span> 20</span></i></a>
							
					</div>
					<div class="card-footer">
					<div class="fb-comments" data-href="http://localhost:8081/Techblog/show_blog.jsp?post_id=<%=p.getPid() %>" data-width="5" data-numposts="5"></div>
					</div>
					
				</div>

			</div>


		</div>

	</div>

	<!-- end of main body -->

	<!-- profile modal -->
	<!-- Modal -->
	<div class="modal fade" id="profile-Modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title" id="exampleModalLabel">Techblog</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="/Techblog/pics/<%=user.getProfile()%>" class="img-fluid"
							style="border-radius: 50%; max-width: 200px">
						<h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>
						<div id="profile-detail">
							<table class="table">

								<tbody>
									<tr>
										<th scope="row">Id</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender</th>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<th scope="row">Status</th>
										<td><%=user.getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registration Date</th>
										<td><%=user.getDateTime()%></td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- profile edit -->
						<div id="profile-edit" style="display: none">
							<!-- <h3 class="mt-2">Please Edit Carefully</h3> -->
							<form action="EditServlet" method="POST"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<th scope="row">Id</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email</th>
										<td>
											<%-- input type="email" name="user_email"
											class="form-control" value="<%=user.getEmail()%>"> --%> <%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Username</th>
										<td><input type="text" name="user_name"
											class="form-control" value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<th scope="row">Password</th>
										<td><input type="password" name="user_password"
											class="form-control" value="<%=user.getPassword()%>"></td>
									</tr>
									<tr>
										<th scope="row">Gender</th>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
									<tr>
										<th scope="row">About</th>
										<td><textarea rows="3" class="form-control"
												name=user_about>
										<%=user.getAbout()%></textarea>
									</tr>
									<tr>
										<th scope="row">Profile picture</th>
										<td><input type="file" name="image" class="form-control"></td>
									</tr>
								</table>
								<div class="container">
									<button type="submit" class="btn btn-outline-primary">Save</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button id="profile-close-btn" type="button"
						class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					<button id="edit-profile-btn" type="button" class="btn btn-primary">Edit
						Profile</button>
				</div>
			</div>
		</div>
	</div>

	<!-- end of profile modal -->

	<!-- add post modal -->

	<div class="modal fade" id="add-post-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Provide Post
						Details</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<div class="modal-body">
					<form id="add-post-form" action="AddPostServlet" method="POST">
						<div class="form-group mb-2">
							<select class="form-control" name="cid" required>
								<option selected disabled>-----Select Category:-----</option>
								<%
								PostDao pd = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list = pd.getAllCategories();
								for (Category c : list) {
								%>
								<option value=<%=c.getCid()%>><%=c.getCname()%></option>
								<%
								}
								%>

							</select>
						</div>
						<div class="form-group mb-2">
							<input type="text" name="pTitle" required
								placeholder="Title of the post" class="form-control" />
						</div>
						<div class="form-group mb-2">
							<textarea class="form-control" name="pContent"
								style="height: 150px" placeholder="Enter your content"></textarea>
						</div>
						<div class="form-group mb-2">
							<textarea class="form-control" name="pCode" style="height: 100px"
								placeholder="Enter your program(if any)"></textarea>
						</div>
						<div class="form-group mb-4">
							<label>Select your picture</label> <input type="file" name="pPic"
								class="form-control">
						</div>
						<div class="container text-center">
							<button type="submit" class="btn btn-outline-primary">Post</button>

						</div>
					</form>


				</div>

			</div>
		</div>
	</div>



	<!-- end of add post modal -->

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
		$(document).ready(function() {
			let editStatus = false;
			$('#edit-profile-btn').click(function() {
				if (editStatus == false) {
					$('#profile-detail').hide();
					$('#profile-edit').show();
					editStatus = true;
					$(this).text("Back");
				} else {
					$('#profile-detail').show();
					$('#profile-edit').hide();
					editStatus = false;
					$(this).text("Edit Profile");
				}
			});

			$(".modal").on("hidden.bs.modal", function() {
				$(this).find('form').trigger('reset');
				$('#profile-detail').show();
				$('#profile-edit').hide();
				editStatus = false;
				$('#edit-profile-btn').text("Edit Profile");
			});

		});
	</script>
	<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v14.0"></script>
	

	<!-- add post js -->
	<script>
		$(document)
				.ready(
						function(e) {
							$("#add-post-form")
									.on(
											"submit",
											function(event) {
												event.preventDefault();
												let form = new FormData(this);

												$
														.ajax({
															url : "AddPostServlet",
															type : 'POST',
															data : form,
															success : function(
																	data,
																	textStatus,
																	jqXHR) {
																if (data.trim() == 'done') {
																	swal(
																			"Good job!",
																			"Post saved successfully.",
																			"success");
																	$(
																			'#add-post-modal')
																			.modal(
																					'hide')
																	$(
																			'#add-post-form')
																			.trigger(
																					'reset');
																} else {
																	swal(
																			"Error!",
																			"Something went wrong!",
																			"error");
																}
															},
															error : function(
																	jqXHR,
																	textStatus,
																	errorThrown) {
																swal(
																		"Error!",
																		"Something went wrong!",
																		"error");
															},
															processData : false,
															contentType : false
														});
											});
							$("#add-post-modal").on("hidden.bs.modal",
									function() {
										$('#add-post-form').trigger('reset');
									});

						});
	</script>
</body>
</html>