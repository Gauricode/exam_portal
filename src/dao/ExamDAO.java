package dao;

import java.sql.*;
import java.util.*;
import model.Exam;

public class ExamDAO {

    public static List<Exam> getAllExams() throws Exception {

        List<Exam> list = new ArrayList<>();

        Connection con = DBConnection.getConnection();
        String query = "SELECT * FROM exams";
        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            list.add(new Exam(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getInt("duration")
            ));
        }

        return list;
    }
}
