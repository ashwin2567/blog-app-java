<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error!!!</title>
<!-- css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="css/style.css" rel="stylesheet" type="text/css">

</style>
</head>
<body>
	<div class="container text-center">
		<img src="img/system.png" class="img-fluid mt-2" height="20px">
		<h6 class="display-8">Sorry. Something went wrong.</h6>
		<%= exception %>
		<br>
		<a href="index.jsp" class="btn primary-background btn-lg text-white mt-2">Home</a>
	</div>
</body>
</html>