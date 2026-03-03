package controller;

import model.Question;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/NavigateExamServlet")
public class NavigateExamServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        List<Question> questions = (List<Question>) session.getAttribute("questions");
        Long examEndTime = (Long) session.getAttribute("examEndTime");

        if (questions == null || questions.isEmpty()) {
            res.sendRedirect("student/studentDashboard.jsp");
            return;
        }

        if (examEndTime != null && System.currentTimeMillis() >= examEndTime) {
            req.getRequestDispatcher("/SubmitExamServlet").forward(req, res);
            return;
        }

        Integer currentIndexObj = (Integer) session.getAttribute("currentQuestion");
        int currentIndex = currentIndexObj == null ? 0 : currentIndexObj;

        Map<Integer, String> answers = (Map<Integer, String>) session.getAttribute("examAnswers");
        if (answers == null) {
            answers = new HashMap<>();
        }

        if (currentIndex >= 0 && currentIndex < questions.size()) {
            Question currentQuestion = questions.get(currentIndex);
            String selectedAnswer = req.getParameter("answer");
            if (selectedAnswer != null && !selectedAnswer.trim().isEmpty()) {
                answers.put(currentQuestion.getQuestionId(), selectedAnswer);
            }
        }

        String suspiciousRaw = req.getParameter("suspicious");
        int suspiciousCount = 0;
        try {
            suspiciousCount = Integer.parseInt(suspiciousRaw);
        } catch (Exception e) {
            Object existing = session.getAttribute("suspiciousCount");
            if (existing instanceof Integer) {
                suspiciousCount = (Integer) existing;
            }
        }
        session.setAttribute("suspiciousCount", suspiciousCount);

        String proctorLog = req.getParameter("proctorLog");
        if (proctorLog != null && !proctorLog.trim().isEmpty()) {
            session.setAttribute("proctorLog", proctorLog);
        }

        String action = req.getParameter("action");
        if ("previous".equals(action)) {
            currentIndex = Math.max(0, currentIndex - 1);
        } else if ("jump".equals(action)) {
            String targetIndexRaw = req.getParameter("targetIndex");
            int targetIndex = currentIndex;
            try {
                targetIndex = Integer.parseInt(targetIndexRaw);
            } catch (Exception e) {
                targetIndex = currentIndex;
            }
            currentIndex = Math.max(0, Math.min(questions.size() - 1, targetIndex));
        } else {
            currentIndex = Math.min(questions.size() - 1, currentIndex + 1);
        }

        session.setAttribute("examAnswers", answers);
        session.setAttribute("currentQuestion", currentIndex);

        res.sendRedirect("student/exam.jsp");
    }
}
