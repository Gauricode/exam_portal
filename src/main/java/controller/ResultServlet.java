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
import model.Student;

@WebServlet("/ResultServlet")
public class ResultServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Student student = (Student) session.getAttribute("student");

        if (student == null) {
            res.sendRedirect("student pages/login.jsp");
            return;
        }

        ResultDAO dao = new ResultDAO();
        List<Result> results = dao.getResultsByStudentId(student.getStudentId());

        session.setAttribute("results", results);
        res.sendRedirect("student pages/result.jsp");
    }
}
