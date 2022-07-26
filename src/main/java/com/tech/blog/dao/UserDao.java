package com.tech.blog.dao;
import java.sql.*;

import com.tech.blog.entities.User;
public class UserDao {
	private Connection con;
	
	public UserDao(Connection con) {
		this.con = con;
	}
	
	public boolean addUSer(User user)
	{
		boolean f = false;
		try {			
			String query="insert into user(name, email, password, gender, about) values(?,?,?,?,?)";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			
			pstmt.executeUpdate();
			f = true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return f;
	}
	
	public boolean updateUser(User user)
	{
		boolean f = false;
		try {
			String query = "update user set name=?, email=?, password=?, gender=?, about=?, profile=? where id = ?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			pstmt.setString(6, user.getProfile());
			pstmt.setInt(7, user.getId());
			
			pstmt.executeUpdate();
			f = true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return f;
	}
	
	public boolean getUserByEmail(String email) {
		boolean result = false;
		try {
			String query = "select * from user where email=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			ResultSet set = pstmt.executeQuery();
			result = set.next();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public User getUserByEmailPassword(String email, String password)
	{
		User user = null;
		try {
			String query = "select * from user where email=? and password=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			
			ResultSet set = pstmt.executeQuery();
			if(set.next()) {
				user = new User();
				user.setName(set.getString("name"));
				user.setId(set.getInt("id"));
				user.setGender(set.getString("gender"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setAbout(set.getString("about"));
				user.setDateTime(set.getTimestamp("rdate"));
				user.setProfile(set.getString("profile"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}
	
	public User getUserByUserId(int userId) {
		User user = null;
		try {
			String query="select * from user where id=?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setInt(1, userId);
			ResultSet set = pst.executeQuery();
			while(set.next()) {
				user = new User();
				user.setName(set.getString("name"));
				user.setId(set.getInt("id"));
				user.setGender(set.getString("gender"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setAbout(set.getString("about"));
				user.setDateTime(set.getTimestamp("rdate"));
				user.setProfile(set.getString("profile"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}

}
