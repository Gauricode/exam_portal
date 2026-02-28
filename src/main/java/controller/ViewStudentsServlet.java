package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Admin;

@WebServlet("/ViewStudentsServlet")
public class ViewStudentsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Admin admin = (Admin) session.getAttribute("admin");

        if (admin == null) {
            res.sendRedirect("admin/adminLogin.jsp");
            return;
        }

        // load students list for admin
        dao.StudentDAO dao = new dao.StudentDAO();
        java.util.List<model.Student> students = dao.getAllStudents();
        session.setAttribute("students", students);
        res.sendRedirect("admin/viewStudents.jsp");
    }
}
