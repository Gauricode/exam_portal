package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
