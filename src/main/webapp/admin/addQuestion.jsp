<%
    model.Admin admin = (model.Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    dao.ExamDAO examDAO = new dao.ExamDAO();
    java.util.List<model.Exam> exams = examDAO.getAllExams();

    String examIdParam = request.getParameter("examId");
    String message = request.getParameter("msg");
%>

<h2>Add Question</h2>
<a href="adminDashboard.jsp">Back to Dashboard</a><br><br>

<form action="../AddQuestionServlet" method="post">
    Exam:
    <select name="examId" required>
        <% for (model.Exam e : exams) { %>
            <option value="<%= e.getExamId() %>" <%= (examIdParam != null && examIdParam.equals(String.valueOf(e.getExamId()))) ? "selected" : "" %>>
                <%= e.getExamName() %>
            </option>
        <% } %>
    </select><br><br>

    Question Text:<br>
    <textarea name="questionText" required rows="3" cols="60"></textarea><br><br>

    Option A: <input type="text" name="optionA" required><br>
    Option B: <input type="text" name="optionB" required><br>
    Option C: <input type="text" name="optionC" required><br>
    Option D: <input type="text" name="optionD" required><br><br>

    Correct Answer:
    <select name="correctAnswer" required>
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
        <option value="D">D</option>
    </select><br><br>

    <button type="submit">Add Question</button>
</form>

<% if (message != null) { %>
    <p><strong><%= message %></strong></p>
<% } %>

<br>
<% if (examIdParam != null) { %>
    <a href="ViewQuestionsServlet?examId=<%= examIdParam %>">View Questions for selected exam</a>
<% } %>
