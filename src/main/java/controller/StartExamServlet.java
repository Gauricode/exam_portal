package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import dao.QuestionDAO;
import dao.ExamDAO;
import model.Question;
import model.Exam;

@WebServlet("/StartExamServlet")
public class StartExamServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        model.Student student = (model.Student) session.getAttribute("student");
        if (student == null) {
            res.sendRedirect("student/login.jsp");
            return;
        }

        String examIdRaw = req.getParameter("examId");
        int examId;
        try {
            examId = Integer.parseInt(examIdRaw);
        } catch (Exception e) {
            res.sendRedirect("student/studentDashboard.jsp");
            return;
        }

        ExamDAO examDAO = new ExamDAO();
        QuestionDAO questionDAO = new QuestionDAO();

        Exam exam = examDAO.getExamById(examId);
        List<Question> questions = questionDAO.getQuestionsByExamId(examId);

        if (exam == null || questions == null || questions.isEmpty()) {
            res.sendRedirect("student/studentDashboard.jsp");
            return;
        }

        int durationMinutes = exam.getDuration() > 0 ? exam.getDuration() : 30;
        long examEndTime = System.currentTimeMillis() + (durationMinutes * 60L * 1000L);

        session.setAttribute("exam", exam);
        session.setAttribute("questions", questions);
        session.setAttribute("currentQuestion", 0);
        session.setAttribute("examAnswers", new HashMap<Integer, String>());
        session.setAttribute("suspiciousCount", 0);
        session.setAttribute("proctorLog", "[]");
        session.setAttribute("examEndTime", examEndTime);

        res.sendRedirect("student/exam.jsp");
    }
}
