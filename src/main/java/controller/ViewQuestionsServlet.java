package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import dao.QuestionDAO;
import model.Question;
import model.Admin;

@WebServlet("/ViewQuestionsServlet")
public class ViewQuestionsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Admin admin = (Admin) session.getAttribute("admin");

        if (admin == null) {
            res.sendRedirect("admin/adminLogin.jsp");
            return;
        }

        int examId = Integer.parseInt(req.getParameter("examId"));
        QuestionDAO dao = new QuestionDAO();
        List<Question> questions = dao.getQuestionsByExamId(examId);

        session.setAttribute("questions", questions);
        session.setAttribute("examId", examId);
        res.sendRedirect("admin/viewQuestions.jsp");
    }
}
