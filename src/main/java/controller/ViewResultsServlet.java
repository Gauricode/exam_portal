package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import dao.ResultDAO;
import model.Result;
import model.Admin;

@WebServlet("/ViewResultsServlet")
public class ViewResultsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Admin admin = (Admin) session.getAttribute("admin");

        if (admin == null) {
            res.sendRedirect("admin/adminLogin.jsp");
            return;
        }

        ResultDAO dao = new ResultDAO();
        List<Result> results = dao.getAllResults();

        session.setAttribute("results", results);
        res.sendRedirect("admin/viewResults.jsp");
    }
}
