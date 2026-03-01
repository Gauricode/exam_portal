package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import dao.ResultDAO;
import model.Result;
import model.Exam;
import model.Question;
import model.Student;

@WebServlet("/SubmitExamServlet")
public class SubmitExamServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Student student = (Student) session.getAttribute("student");
        Exam exam = (Exam) session.getAttribute("exam");
        @SuppressWarnings("unchecked")
        List<Question> questions = (List<Question>) session.getAttribute("questions");

        int correctAnswers = 0;

        if (student != null && exam != null && questions != null) {
            for (Question q : questions) {
                String userAnswer = req.getParameter("q" + q.getQuestionId());
                if (userAnswer != null && userAnswer.equals(q.getCorrectAnswer())) {
                    correctAnswers++;
                }
            }

            Result result = new Result();
            result.setStudentId(student.getStudentId());
            result.setExamId(exam.getExamId());
            result.setScore(correctAnswers);
            result.setTotalQuestions(questions.size());
            result.setResultDate(LocalDateTime.now().toString());
            result.setStatus("Completed");

            ResultDAO dao = new ResultDAO();
            dao.addResult(result);

            // refresh results list in session
            java.util.List<Result> results = dao.getResultsByStudentId(student.getStudentId());
            session.setAttribute("results", results);

            session.removeAttribute("exam");
            session.removeAttribute("questions");

            res.sendRedirect("student pages/result.jsp");
        } else {
            res.getWriter().println("Error: Unable to submit exam");
        }
    }
}
