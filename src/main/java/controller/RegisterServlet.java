package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import dao.StudentDAO;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        StudentDAO dao = new StudentDAO();
        boolean success = dao.registerStudent(name, email, password);

        if (success) {
            res.sendRedirect("student pages/login.jsp");
        } else {
            res.getWriter().println("Registration failed. Please try again.");
        }
    }
}
