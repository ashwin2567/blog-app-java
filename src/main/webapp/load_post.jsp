<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">
	<%
	PostDao pd = new PostDao(ConnectionProvider.getConnection());
	int cid = Integer.parseInt(request.getParameter("cid"));
	ArrayList<Post> post = null;
	if (cid == 0) {
		post = pd.getAllPosts();
	} else {
		post = pd.getPostbyCatId(cid);
	}

	if (post.size() == 0) {
		response.getWriter().println("<h3 class='display-3 text-center'>No post in this category.</h3>");
		return;
	}

	for (Post p : post) {
	%>
	<div class="col-md-6 mt-2">
		<div class="card">
			<img src="blog_pics/<%=p.getpPic()%>" class="card-img-top"
				alt="Card cap image">
			<div class="card-body">
				<b><%=p.getpTitle()%></b>
				<p><%=p.getpContent()%></p>
			</div>
			<div class="card-footer primary-background text-white text-center">

				<a href="#" class="btn btn-outline-light btn-sm"><i
					class="fa fa-thumbs-o-up"><span> 10</span></i></a> 
				<a href="show_blog.jsp?post_id=<%=p.getPid()%>"	class="btn btn-outline-light btn-sm">Read More</a> 
				<a href="#"	class="btn btn-outline-light btn-sm"><i
					class="fa fa-commenting-o"><span> 20</span></i></a>
			</div>
		</div>
	</div>


	<%
}
%>
</div>