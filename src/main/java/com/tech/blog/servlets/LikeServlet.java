package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.blog.dao.LikeDao;
import com.tech.blog.helper.ConnectionProvider;

@WebServlet("/LikeServlet")
public class LikeServlet extends HttpServlet {

	public void service(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
		String operation = request.getParameter("operation");
		int postId = Integer.parseInt(request.getParameter("postId"));
		int likedBy = Integer.parseInt(request.getParameter("likedBy"));
		if (operation.equals("like")) {
			if (ld.insertLike(likedBy, postId)) {
				out.println("done");
			} else {
				out.print("error");
			}
		}

	}

}
