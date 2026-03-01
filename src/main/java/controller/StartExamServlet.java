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
import dao.ExamDAO;
import model.Question;
import model.Exam;
import model.Student;

@WebServlet("/StartExamServlet")
public class StartExamServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        model.Student student = (model.Student) session.getAttribute("student");
        if (student == null) {
            res.sendRedirect("student pages/login.jsp");
            return;
        }

        int examId = Integer.parseInt(req.getParameter("examId"));

        ExamDAO examDAO = new ExamDAO();
        QuestionDAO questionDAO = new QuestionDAO();

        Exam exam = examDAO.getExamById(examId);
        List<Question> questions = questionDAO.getQuestionsByExamId(examId);

        session.setAttribute("exam", exam);
        session.setAttribute("questions", questions);
        session.setAttribute("currentQuestion", 0);

        res.sendRedirect("student pages/exam.jsp");
    }
}
