package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import dao.DBConnection;

public class SubmitExamServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String userEmail = (String) request.getSession().getAttribute("email");
            int examId = 1; // for now fixed (later dynamic)

            Connection con = DBConnection.getConnection();

            String query = "SELECT id, correct_option FROM questions WHERE exam_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, examId);
            ResultSet rs = ps.executeQuery();

            int score = 0;
            int total = 0;

            while (rs.next()) {
                total++;
                int qId = rs.getInt("id");
                int correct = rs.getInt("correct_option");

                String answer = request.getParameter("q" + qId);

                if (answer != null && Integer.parseInt(answer) == correct) {
                    score++;
                }
            }

            double percentage = (score * 100.0) / total;

            String insert = "INSERT INTO results (user_email, exam_id, score, total, percentage) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps2 = con.prepareStatement(insert);
            ps2.setString(1, userEmail);
            ps2.setInt(2, examId);
            ps2.setInt(3, score);
            ps2.setInt(4, total);
            ps2.setDouble(5, percentage);
            ps2.executeUpdate();

            request.setAttribute("score", score);
            request.setAttribute("total", total);
            request.setAttribute("percentage", percentage);

            request.getRequestDispatcher("result.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}