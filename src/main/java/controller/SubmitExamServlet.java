package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import dao.ResultDAO;
import dao.ViolationDAO;
import model.Result;
import model.Exam;
import model.Question;
import model.Student;
import model.Violation;

@WebServlet("/SubmitExamServlet")
public class SubmitExamServlet extends HttpServlet {

    // threshold above which we flag the exam/insert a violation
    private static final int SUSPICIOUS_THRESHOLD = 3;

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Student student = (Student) session.getAttribute("student");
        Exam exam = (Exam) session.getAttribute("exam");
        @SuppressWarnings("unchecked")
        List<Question> questions = (List<Question>) session.getAttribute("questions");
        @SuppressWarnings("unchecked")
        Map<Integer, String> answers = (Map<Integer, String>) session.getAttribute("examAnswers");
        Long examEndTime = (Long) session.getAttribute("examEndTime");

        if (answers == null) {
            answers = new HashMap<>();
        }

        int correctAnswers = 0;

        if (student != null && exam != null && questions != null) {
            Integer currentIndexObj = (Integer) session.getAttribute("currentQuestion");
            int currentIndex = currentIndexObj == null ? 0 : currentIndexObj;
            if (currentIndex >= 0 && currentIndex < questions.size()) {
                String latestAnswer = req.getParameter("answer");
                if (latestAnswer != null && !latestAnswer.trim().isEmpty()) {
                    answers.put(questions.get(currentIndex).getQuestionId(), latestAnswer);
                }
            }

            for (Question q : questions) {
                String userAnswer = answers == null ? null : answers.get(q.getQuestionId());
                if (userAnswer == null) {
                    userAnswer = req.getParameter("q" + q.getQuestionId());
                }
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

            boolean isTimedOut = examEndTime != null && System.currentTimeMillis() >= examEndTime;
            String autoSubmitReason = req.getParameter("autoSubmitReason");
            if (isTimedOut || "timeout".equals(autoSubmitReason)) {
                result.setStatus("Timed Out");
            }
            // proctoring data
            String susp = req.getParameter("suspicious");
            int suspiciousCount = 0;
            try {
                suspiciousCount = Integer.parseInt(susp);
            } catch (Exception e) {
                Object existingSuspicious = session.getAttribute("suspiciousCount");
                if (existingSuspicious instanceof Integer) {
                    suspiciousCount = (Integer) existingSuspicious;
                }
            }
            result.setSuspiciousCount(suspiciousCount);

            // if we have a proctoring log we can optionally log details
            String logJson = req.getParameter("proctorLog");
            if ((logJson == null || logJson.trim().isEmpty()) && session.getAttribute("proctorLog") != null) {
                logJson = (String) session.getAttribute("proctorLog");
            }
            if (logJson != null && !logJson.trim().isEmpty()) {
                // store or inspect later (not currently persisted in the data model)
            }

            // create DAO early so it can be reused
            ResultDAO dao = new ResultDAO();

            // if suspicious count exceeds threshold mark as flagged and insert a violation
            if (suspiciousCount >= SUSPICIOUS_THRESHOLD) {
                result.setStatus("Flagged");
                // record a violation entry
                ViolationDAO vdao = new ViolationDAO();
                Violation v = new Violation();
                v.setStudentId(student.getStudentId());
                v.setExamId(exam.getExamId());
                v.setViolationType("Proctoring");
                String desc = "Recorded " + suspiciousCount + " suspicious events";
                if (logJson != null && !logJson.trim().isEmpty()) {
                    desc += "; details=" + logJson;
                }
                v.setDescription(desc);
                v.setViolationDate(LocalDateTime.now().toString());
                vdao.addViolation(v);
            }

            dao.addResult(result);

            // refresh results list in session
            java.util.List<Result> results = dao.getResultsByStudentId(student.getStudentId());
            session.setAttribute("results", results);

            session.removeAttribute("exam");
            session.removeAttribute("questions");
            session.removeAttribute("currentQuestion");
            session.removeAttribute("examAnswers");
            session.removeAttribute("suspiciousCount");
            session.removeAttribute("proctorLog");
            session.removeAttribute("examEndTime");

            res.sendRedirect("student/result.jsp");
        } else {
            res.getWriter().println("Error: Unable to submit exam");
        }
    }
}
