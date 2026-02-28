<%
    model.Admin admin = (model.Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    java.util.List<model.Question> questions = (java.util.List<model.Question>) session.getAttribute("questions");
    Integer examId = (Integer) session.getAttribute("examId");
%>

<h2>Questions for Exam ID: <%= examId %></h2>
<a href="adminDashboard.jsp">Back to Dashboard</a><br><br>

<% if (questions == null || questions.isEmpty()) { %>
    <p>No questions found.</p>
<% } else { %>
    <table border="1">
        <tr>
            <th>ID</th><th>Text</th><th>A</th><th>B</th><th>C</th><th>D</th><th>Answer</th>
        </tr>
        <% for (model.Question q : questions) { %>
            <tr>
                <td><%= q.getQuestionId() %></td>
                <td><%= q.getQuestionText() %></td>
                <td><%= q.getOptionA() %></td>
                <td><%= q.getOptionB() %></td>
                <td><%= q.getOptionC() %></td>
                <td><%= q.getOptionD() %></td>
                <td><%= q.getCorrectAnswer() %></td>
            </tr>
        <% } %>
    </table>
<% } %>
