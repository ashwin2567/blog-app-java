package com.tech.blog.servlets;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tech.blog.entities.Message;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	
	public void service(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HttpSession session = request.getSession();
		session.removeAttribute("currentuser");
		Message m = new Message();
		m.setContent("Logged out successfully.");
		m.setType("logout success");
		m.setCssClass("alert alert-success");
		session.setAttribute("msg", m);
		response.sendRedirect("login_page.jsp");
	}

}
