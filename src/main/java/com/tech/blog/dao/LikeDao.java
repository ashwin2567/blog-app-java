package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
	private Connection con;

	public LikeDao(Connection con) {
		this.con = con;
	}

	public boolean insertLike(int userId, int postId) {
		boolean f = false;
		try {
			String query = "insert into postLike(uid,pid) values(?,?)";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setInt(1, userId);
			pst.setInt(2, postId);
			pst.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public int countLikeOnPost(int postId) {
		int p = 0;
		try {
			String query = "select count(*) from postLike where pid = ?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setInt(1, postId);
			ResultSet set = pst.executeQuery();
			while (set.next()) {
				p = (int) (set.getInt(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return p;
	}

	public boolean isLikedByUser(int userId, int postId) {
		boolean f = false;
		try {
			String query = "select * from postLike where uid =?, and pid = ?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setInt(1, userId);
			pst.setInt(2, postId);
			ResultSet set = pst.executeQuery();
			while (set.next()) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean deleteLike(int userId, int postId) {
		boolean f = false;
		try {
			String query = "delete from postLike where uid =?, and pid = ?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setInt(1, userId);
			pst.setInt(2, postId);
			pst.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
}
