
package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
            res.sendRedirect("student/studentDashboard.jsp");
        } else {
            res.getWriter().println("Invalid Email or Password");
        }
    }
}
