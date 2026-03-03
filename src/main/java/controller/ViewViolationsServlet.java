package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import dao.ViolationDAO;
import model.Violation;
import model.Admin;

@WebServlet("/ViewViolationsServlet")
public class ViewViolationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            res.sendRedirect("admin/adminLogin.jsp");
            return;
        }

        ViolationDAO dao = new ViolationDAO();
        List<Violation> violations = dao.getAllViolations();

        session.setAttribute("violations", violations);
        res.sendRedirect("admin/viewViolations.jsp");
    }
}
