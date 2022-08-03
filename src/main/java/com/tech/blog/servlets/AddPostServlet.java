package com.tech.blog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

@MultipartConfig
@WebServlet("/AddPostServlet")
public class AddPostServlet extends HttpServlet {
	public void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		PrintWriter out = response.getWriter();
		int catId = Integer.parseInt(request.getParameter("cid"));
		String pTitle = request.getParameter("pTitle");
		String pContent = request.getParameter("pContent");
		String pCode = request.getParameter("pCode");
		Part part = request.getPart("pPic");
		String pPicName = part.getSubmittedFileName();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentuser");
		int userId = user.getId();
		Post post = new Post(pTitle, pContent, pCode, pPicName, null, catId, userId);
		PostDao pdao = new PostDao(ConnectionProvider.getConnection());
		if (pdao.savePost(post)) {
			String pathOldFile = request.getRealPath("/") + "blog_pics" + File.separator + pPicName;
			Helper.saveFile(part.getInputStream(), pathOldFile);
			out.println("done");
		} else {
			out.println("error");
		}

	}
}
