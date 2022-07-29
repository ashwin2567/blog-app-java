package com.tech.blog.servlets;

import java.io.IOException;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

@WebServlet("/LoginServelt")
@MultipartConfig
public class LoginServlet extends HttpServlet {

	public void service(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String useremail = request.getParameter("user_email");
		String userpassword = request.getParameter("user_password");

		UserDao dao = new UserDao(ConnectionProvider.getConnection());

		User u = dao.getUserByEmailPassword(useremail, userpassword);

		if (u == null) {
//			login error
			response.getWriter().println("Invalid credentials.");
		}
		else {
			System.out.println(u.getName());
//			we will store user to session to keep him logged in throughout.--session end with browser
//			For more complicated data we may use cookies
			HttpSession session = request.getSession();
			session.setAttribute("currentuser", u);
			response.sendRedirect("profile.jsp");			
		}
	}

}
