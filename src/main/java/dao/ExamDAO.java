package dao;

import java.sql.*;
import java.util.*;
import model.Exam;

public class ExamDAO {

    public List<Exam> getAllExams() {
        List<Exam> exams = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return exams;

            String sql = "SELECT * FROM exams";
            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Exam e = new Exam(
                            rs.getInt("examId"),
                            rs.getString("examName"),
                            rs.getString("description"),
                            rs.getInt("duration"),
                            rs.getInt("totalQuestions")
                    );
                    exams.add(e);
                }
            }
            if (con != null) {
                con.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return exams;
    }

    public Exam getExamById(int examId) {
        Exam e = null;

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return null;

            String sql = "SELECT * FROM exams WHERE examId=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, examId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        e = new Exam(
                                rs.getInt("examId"),
                                rs.getString("examName"),
                                rs.getString("description"),
                                rs.getInt("duration"),
                                rs.getInt("totalQuestions")
                        );
                    }
                }
            }
            if (con != null) {
                con.close();
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return e;
    }

    public boolean addExam(Exam exam) {
        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return false;

            String sql = "INSERT INTO exams (examName, description, duration, totalQuestions) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, exam.getExamName());
                ps.setString(2, exam.getDescription());
                ps.setInt(3, exam.getDuration());
                ps.setInt(4, exam.getTotalQuestions());

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
