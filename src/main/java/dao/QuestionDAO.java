package dao;

import java.sql.*;
import java.util.*;
import model.Question;

public class QuestionDAO {

    public List<Question> getQuestionsByExamId(int examId) {
        List<Question> questions = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return questions;

            String sql = "SELECT * FROM questions WHERE examId=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, examId);

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Question q = new Question(
                                rs.getInt("questionId"),
                                rs.getInt("examId"),
                                rs.getString("questionText"),
                                rs.getString("optionA"),
                                rs.getString("optionB"),
                                rs.getString("optionC"),
                                rs.getString("optionD"),
                                rs.getString("correctAnswer")
                        );
                        questions.add(q);
                    }
                }
            }
            if (con != null) {
                con.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return questions;
    }

    public boolean addQuestion(Question question) {
        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return false;

            String sql = "INSERT INTO questions (examId, questionText, optionA, optionB, optionC, optionD, correctAnswer) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, question.getExamId());
                ps.setString(2, question.getQuestionText());
                ps.setString(3, question.getOptionA());
                ps.setString(4, question.getOptionB());
                ps.setString(5, question.getOptionC());
                ps.setString(6, question.getOptionD());
                ps.setString(7, question.getCorrectAnswer());

                int result = ps.executeUpdate();
                con.close();
                return result > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteQuestion(int questionId) {
        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return false;

            String sql = "DELETE FROM questions WHERE questionId=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, questionId);

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
