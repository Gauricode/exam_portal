package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

import dao.DBConnection;
import dao.ExamDAO;
import model.Exam;

public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("email");

            Connection con = DBConnection.getConnection();

            // Total exams
            List<Exam> exams = ExamDAO.getAllExams();
            request.setAttribute("examList", exams);
            request.setAttribute("totalExams", exams.size());

            // Completed exams
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT COUNT(DISTINCT exam_id) FROM results WHERE user_email=?"
            );
            ps1.setString(1, email);
            ResultSet rs1 = ps1.executeQuery();
            rs1.next();
            int completed = rs1.getInt(1);
            request.setAttribute("completed", completed);

            // Pending exams
            int pending = exams.size() - completed;
            request.setAttribute("pending", pending);

            // Average score
            PreparedStatement ps2 = con.prepareStatement(
                "SELECT AVG(percentage) FROM results WHERE user_email=?"
            );
            ps2.setString(1, email);
            ResultSet rs2 = ps2.executeQuery();
            rs2.next();
            double avg = rs2.getDouble(1);
            request.setAttribute("average", avg);

            request.getRequestDispatcher("student-dashboard.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}