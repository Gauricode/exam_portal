package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import dao.AdminDAO;
import model.Admin;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        AdminDAO dao = new AdminDAO();
        Admin a = dao.loginAdmin(email, password);

        if (a != null) {
            HttpSession session = req.getSession();
            session.setAttribute("admin", a);
            res.sendRedirect("admin/adminDashboard.jsp");
        } else {
            res.getWriter().println("Invalid Email or Password");
        }
    }
}
