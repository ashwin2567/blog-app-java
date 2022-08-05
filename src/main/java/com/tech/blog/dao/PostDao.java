package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;

public class PostDao {
	private Connection con;

	public PostDao(Connection con) {
		this.con = con;
	}

	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> result = new ArrayList<>();
		try {
			String query = "select * from categories";
			Statement st = con.createStatement();
			ResultSet set = st.executeQuery(query);
			while (set.next()) {
				Category ct = new Category(set.getInt("cid"), set.getString("cname"), set.getString("cdesc"));
				result.add(ct);
			}
		} catch (Exception e) {
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
		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public ArrayList<Post> getAllPosts() {
		ArrayList<Post> postList = new ArrayList<>();
		try {
			String query = "select * from post order by pid desc";
			Statement st = con.createStatement();
			ResultSet set = st.executeQuery(query);
			while (set.next()) {
				Post p = new Post(set.getInt("pid"), set.getString("pTitle"), set.getString("pContent"),
						set.getString("pCode"), set.getString("pPic"), set.getTimestamp("pDate"), set.getInt("catId"),
						set.getInt("userId"));
				postList.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return postList;
	}

	public ArrayList<Post> getPostbyCatId(int catId){
		ArrayList<Post> postList = new ArrayList<>();
		try {
			String query = "select * from post where catId=?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setInt(1, catId);
			ResultSet set = pst.executeQuery();
			while(set.next()) {
				Post p = new Post(set.getInt("pid"), set.getString("pTitle"), set.getString("pContent"),
						set.getString("pCode"), set.getString("pPic"), set.getTimestamp("pDate"), set.getInt("catId"),
						set.getInt("userId"));
				postList.add(p);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return postList;
	}
	public Post getPostById(int postId) {
		Post post = null;
		try {
			String query = "select * from post where pid = ?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setInt(1, postId);
			ResultSet set = pst.executeQuery();
			if(set.next()) {
			post = new Post(set.getInt("pid"), set.getString("pTitle"), set.getString("pContent"),
					set.getString("pCode"), set.getString("pPic"), set.getTimestamp("pDate"), set.getInt("catId"),
					set.getInt("userId"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return post;
	}
}
