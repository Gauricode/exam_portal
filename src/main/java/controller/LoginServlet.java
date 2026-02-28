package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import dao.StudentDAO;
import model.Student;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        StudentDAO dao = new StudentDAO();
        Student s = dao.loginStudent(email, password);

        if (s != null) {
            HttpSession session = req.getSession();
            session.setAttribute("student", s);
            // folder name contains a space
            res.sendRedirect("student pages/studentDashboard.jsp");
        } else {
            res.getWriter().println("Invalid Email or Password");
        }
    }
}
