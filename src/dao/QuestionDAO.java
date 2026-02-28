package dao;

import java.sql.*;
import java.util.*;
import model.Question;

public class QuestionDAO {

    public static List<Question> getQuestionsByExamId(int examId) throws Exception {

        List<Question> list = new ArrayList<>();

        Connection con = DBConnection.getConnection();

        String query = "SELECT * FROM questions WHERE exam_id=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, examId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            list.add(new Question(
                    rs.getInt("id"),
                    rs.getString("question"),
                    rs.getString("option1"),
                    rs.getString("option2"),
                    rs.getString("option3"),
                    rs.getString("option4")
            ));
        }

        return list;
    }
}   