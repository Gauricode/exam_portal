package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import dao.DBConnection;
import dao.ExamDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Exam;


public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    out.println("<h1>Servlet Reached</h1>");

    try {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        out.println("<p>Email: " + email + "</p>");
        out.println("<p>Password: " + password + "</p>");

        Connection con = DBConnection.getConnection();

        out.println("<p>Database Connected</p>");

        String query = "SELECT * FROM users WHERE email=? AND password=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            HttpSession session = request.getSession();
            session.setAttribute("name", rs.getString("name"));
            session.setAttribute("role", rs.getString("role"));
            session.setAttribute("email", rs.getString("email"));
            if (rs.getString("role").equals("student")) {

                List<Exam> exams = ExamDAO.getAllExams();
                request.setAttribute("examList", exams);
                request.getRequestDispatcher("student-dashboard.jsp").forward(request, response);

} else {
    response.sendRedirect("admin-dashboard.jsp");
}
        } else {
            out.println("<h2>Invalid Email or Password</h2>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    }
    }
}
