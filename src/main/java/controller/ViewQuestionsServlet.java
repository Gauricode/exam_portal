package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
