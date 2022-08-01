package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		UserDao dao = new UserDao(ConnectionProvider.getConnection());
		String check = request.getParameter("check");
		if (check == null) {
			out.println("Please check the terms and conditions.");
		} else {
			String name = request.getParameter("user_name");
			String email = request.getParameter("user_email");
			String password = request.getParameter("user_password");
			String gender = request.getParameter("gender");
			String about = request.getParameter("about");
			
			
			if(dao.getUserByEmail(email)) {
				out.println("Email already in use. Kindly use another email.");
				return;
			}
			
			//create user object
			User user = new User(name, email, password, gender, about, null);
			//creat user dao object
			
			
			if(dao.addUSer(user)) {
				out.println("done");
			}
			else {
				out.println("Error");
			}
			
		}
	}

}
