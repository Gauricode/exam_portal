package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import dao.StudentDAO;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        System.out.println("Registration attempt - Name: " + name + ", Email: " + email);
        
        StudentDAO dao = new StudentDAO();
        boolean success = dao.registerStudent(name, email, password);

        System.out.println("Registration result: " + success);

        if (success) {
            res.sendRedirect(req.getContextPath() + "/student/login.jsp");
        } else {
            res.getWriter().println("Registration failed. Please try again.<br>");
            res.getWriter().println("Debug: Check database connection and table structure.");
        }
    }
}
