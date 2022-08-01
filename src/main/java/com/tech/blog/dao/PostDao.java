package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.tech.blog.entities.Category;

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
}





