package dao;

import java.sql.*;
import java.util.*;
import model.Violation;

public class ViolationDAO {

    public List<Violation> getViolationsByStudentId(int studentId) {
        List<Violation> violations = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return violations;

            String sql = "SELECT * FROM violations WHERE studentId=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, studentId);

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Violation v = new Violation(
                                rs.getInt("violationId"),
                                rs.getInt("studentId"),
                                rs.getInt("examId"),
                                rs.getString("violationType"),
                                rs.getString("description"),
                                rs.getString("violationDate")
                        );
                        violations.add(v);
                    }
                }
            }
            if (con != null) {
                con.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return violations;
    }

    public List<Violation> getAllViolations() {
        List<Violation> violations = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return violations;

            String sql = "SELECT * FROM violations";
            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Violation v = new Violation(
                            rs.getInt("violationId"),
                            rs.getInt("studentId"),
                            rs.getInt("examId"),
                            rs.getString("violationType"),
                            rs.getString("description"),
                            rs.getString("violationDate")
                    );
                    violations.add(v);
                }
            }
            if (con != null) {
                con.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return violations;
    }

    public boolean addViolation(Violation violation) {
        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return false;

            String sql = "INSERT INTO violations (studentId, examId, violationType, description, violationDate) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, violation.getStudentId());
                ps.setInt(2, violation.getExamId());
                ps.setString(3, violation.getViolationType());
                ps.setString(4, violation.getDescription());
                ps.setString(5, violation.getViolationDate());

                int result = ps.executeUpdate();
                con.close();
                return result > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
