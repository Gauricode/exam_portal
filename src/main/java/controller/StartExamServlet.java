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
