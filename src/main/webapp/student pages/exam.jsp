<%
    model.Student student = (model.Student) session.getAttribute("student");
    model.Exam exam = (model.Exam) session.getAttribute("exam");
    java.util.List<model.Question> questions = (java.util.List<model.Question>) session.getAttribute("questions");

    if (student == null || exam == null || questions == null) {
        response.sendRedirect("studentDashboard.jsp");
        return;
    }
%>

<h2>Exam: <%= exam.getExamName() %></h2>
<form action="../SubmitExamServlet" method="post">
    <% for (model.Question q : questions) { %>
        <div>
            <p><b>Question <%= q.getQuestionId() %>:</b> <%= q.getQuestionText() %></p>
            <input type="radio" name="q<%= q.getQuestionId() %>" value="A"> <%= q.getOptionA() %><br>
            <input type="radio" name="q<%= q.getQuestionId() %>" value="B"> <%= q.getOptionB() %><br>
            <input type="radio" name="q<%= q.getQuestionId() %>" value="C"> <%= q.getOptionC() %><br>
            <input type="radio" name="q<%= q.getQuestionId() %>" value="D"> <%= q.getOptionD() %><br>
        </div>
        <hr>
    <% } %>
    <button type="submit">Submit Exam</button>
</form>
