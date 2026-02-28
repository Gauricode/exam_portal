package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import dao.QuestionDAO;
import model.Question;

public class StartExamServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int examId = Integer.parseInt(request.getParameter("id"));

            List<Question> questions = QuestionDAO.getQuestionsByExamId(examId);

            request.setAttribute("questions", questions);
            request.getRequestDispatcher("exam.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}