package dao;
import java.sql.*;
import model.Student;

public class StudentDAO {

    public Student loginStudent(String email, String password) {
        Student s = null;

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) {
                System.out.println("Database connection failed");
                return null;
            }

            String sql = "SELECT * FROM students WHERE email=? AND password=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        s = new Student(
                                rs.getInt("studentId"),
                                rs.getString("name"),
                                rs.getString("email")
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

        return s;
    }

    public boolean registerStudent(String name, String email, String password) {
        try {
            System.out.println("Attempting to register student: " + email);
            
            Connection con = DBConnection.getConnection();
            if (con == null) {
                System.out.println("Database connection failed");
                return false;
            }
            
            System.out.println("Database connection successful");

            String sql = "INSERT INTO students (name, email, password) VALUES (?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password);

                System.out.println("Executing SQL: " + sql);
                int result = ps.executeUpdate();
                System.out.println("Rows affected: " + result);
                
                con.close();
                return result > 0;
            }

        } catch (Exception e) {
            System.out.println("Error in registration: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    // helper for admin
    public java.util.List<Student> getAllStudents() {
        java.util.List<Student> students = new java.util.ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return students;

            String sql = "SELECT * FROM students";
            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Student s = new Student(
                            rs.getInt("studentId"),
                            rs.getString("name"),
                            rs.getString("email")
                    );
                    students.add(s);
                }
            }
            if (con != null) {
                con.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return students;
    }
}
