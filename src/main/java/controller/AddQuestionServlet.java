package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import dao.QuestionDAO;
import model.Question;
import model.Admin;

@WebServlet("/AddQuestionServlet")
public class AddQuestionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Admin admin = (Admin) session.getAttribute("admin");

        if (admin == null) {
            res.sendRedirect("admin/adminLogin.jsp");
            return;
        }

        int examId = Integer.parseInt(req.getParameter("examId"));
        String questionText = req.getParameter("questionText");
        String optionA = req.getParameter("optionA");
        String optionB = req.getParameter("optionB");
        String optionC = req.getParameter("optionC");
        String optionD = req.getParameter("optionD");
        String correctAnswer = req.getParameter("correctAnswer");

        Question q = new Question();
        q.setExamId(examId);
        q.setQuestionText(questionText);
        q.setOptionA(optionA);
        q.setOptionB(optionB);
        q.setOptionC(optionC);
        q.setOptionD(optionD);
        q.setCorrectAnswer(correctAnswer);

        QuestionDAO dao = new QuestionDAO();
        boolean success = dao.addQuestion(q);

        if (success) {
            // send a message back so user knows question was added
            res.sendRedirect("admin/addQuestion.jsp?examId=" + examId + "&msg=Question+added+successfully");
        } else {
            res.getWriter().println("Failed to add question");
        }
    }
}
