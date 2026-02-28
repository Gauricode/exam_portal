package dao;

import java.sql.*;
import model.Admin;

public class AdminDAO {

    public Admin loginAdmin(String email, String password) {
        Admin a = null;

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) {
                System.out.println("Database connection failed");
                return null;
            }

            String sql = "SELECT * FROM admins WHERE email=? AND password=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        a = new Admin(
                                rs.getInt("adminId"),
                                rs.getString("name"),
                                rs.getString("email"),
                                rs.getString("password")
                        );
                    }
                }
            }
            if (con != null) {
                con.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return a;
    }

    public Admin getAdminById(int adminId) {
        Admin a = null;

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return null;

            String sql = "SELECT * FROM admins WHERE adminId=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, adminId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        a = new Admin(
                                rs.getInt("adminId"),
                                rs.getString("name"),
                                rs.getString("email"),
                                rs.getString("password")
                        );
                    }
                }
            }
            if (con != null) {
                con.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return a;
    }
}
