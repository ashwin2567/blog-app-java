package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;

public class PostDao {
	private Connection con;
	
	public PostDao(Connection con)
	{
		this.con = con;
	}
	
	public ArrayList<Category> getAllCategories()
	{
		ArrayList<Category> result = new ArrayList<>();
		try {
			String query = "select * from categories";
			Statement st = con.createStatement();
			ResultSet set = st.executeQuery(query);
			while(set.next()) {
				Category ct = new Category(set.getInt("cid"),set.getString("cname"),set.getString("cdesc"));
				result.add(ct);
			}			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean savePost(Post p) {
		boolean f = false;
		try {
			String query = "insert into post(pTitle, pContent, pCode, pPic, catId, userId) values(?,?,?,?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, p.getpTitle());
			pstmt.setString(2, p.getpContent());
			pstmt.setString(3, p.getpCode());
			pstmt.setString(4, p.getpPic());
			pstmt.setInt(5, p.getCatId());
			pstmt.setInt(6, p.getUserId());
			
			pstmt.executeUpdate();
			f = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return f;
	}
}







