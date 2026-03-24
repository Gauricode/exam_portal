package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import dao.ExamDAO;
import model.Exam;
import model.Admin;

@WebServlet("/AddExamServlet")
public class AddExamServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Admin admin = (Admin) session.getAttribute("admin");

        if (admin == null) {
            res.sendRedirect("admin/adminLogin.jsp");
            return;
        }

        String name = req.getParameter("examName");
        String description = req.getParameter("description");
        int duration = 0;
        int totalQuestions = 0;
        try {
            duration = Integer.parseInt(req.getParameter("duration"));
        } catch (Exception ignored) {}
        try {
            totalQuestions = Integer.parseInt(req.getParameter("totalQuestions"));
        } catch (Exception ignored) {}

        Exam exam = new Exam();
        exam.setExamName(name);
        exam.setDescription(description);
        exam.setDuration(duration);
        exam.setTotalQuestions(totalQuestions);

        ExamDAO dao = new ExamDAO();
        // validate duplicate exam name
        if (name == null || name.trim().isEmpty()) {
            res.sendRedirect("admin/addExam.jsp?err=Name+is+required");
            return;
        }

        if (dao.existsByName(name.trim())) {
            res.sendRedirect("admin/addExam.jsp?err=Exam+name+already+exists");
            return;
        }

        boolean ok = dao.addExam(exam);

        if (ok) {
            res.sendRedirect("admin/adminDashboard.jsp?msg=Exam+added+successfully");
        } else {
            res.getWriter().println("Failed to add exam");
        }
    }
}
