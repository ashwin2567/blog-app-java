package com.tech.blog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

@WebServlet("/EditServlet")
@MultipartConfig
public class EditServlet extends HttpServlet {
	public void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		PrintWriter out = response.getWriter();
		UserDao userDao = new UserDao(ConnectionProvider.getConnection());
		/* get user from session */
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentuser");
		
		// String userEmail = request.getParameter("user_email");
		String userPassword = request.getParameter("user_password");
		String userName = request.getParameter("user_name");
		String userAbout = request.getParameter("user_about");
		userAbout = userAbout.trim();
		
		Part part = request.getPart("image");
		String imageName = part.getSubmittedFileName();
		if(imageName == "") {
			imageName = user.getProfile();
		}
		else {
			String oldPath = request.getRealPath("/pics") + File.separator + user.getProfile();
			Helper.deleteFile(oldPath);
		}
		

		// user.setEmail(userEmail);
		user.setAbout(userAbout);
		user.setName(userName);
		user.setPassword(userPassword);
		user.setProfile(imageName);

		if (userDao.updateUser(user)) {
			String path = request.getRealPath("/pics") + File.separator + imageName;	
			if (Helper.saveFile(part.getInputStream(), path)) {
				out.println("Updated Succesfully.");
				Message msg = new Message();
				msg.setContent("Profile Updated.");
				msg.setType("success");
				msg.setCssClass("alert-success");
				
				response.sendRedirect("profile.jsp");
				session.setAttribute("msg", msg);
			}
			else {
				Message msg = new Message();
				msg.setContent("Something went wrong.");
				msg.setType("error");
				msg.setCssClass("alert-error");
				response.sendRedirect("profile.jsp");
				session.setAttribute("msg", msg);
			}
		}

		else {
			out.println("Not Updated.");
			Message msg = new Message();
			msg.setContent("Something went wrong.");
			msg.setType("error");
			msg.setCssClass("alert-error");
			response.sendRedirect("profile.jsp");
			session.setAttribute("msg", msg);
		}
	}

}