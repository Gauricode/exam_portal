<%
    model.Student student = (model.Student) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    java.util.List<model.Result> results = (java.util.List<model.Result>) session.getAttribute("results");
    if (results == null) {
        dao.ResultDAO dao = new dao.ResultDAO();
        results = dao.getResultsByStudentId(student.getStudentId());
        session.setAttribute("results", results);
    }
%>

<h2>My Results</h2>
<a href="studentDashboard.jsp">Back to Dashboard</a><br><br>

<% if (results == null || results.isEmpty()) { %>
    <p>No results to display.</p>
<% } else { %>
    <table border="1">
        <tr>
            <th>Exam ID</th><th>Score</th><th>Total</th><th>Date</th><th>Status</th>
        </tr>
        <% for (model.Result r : results) { %>
            <tr>
                <td><%= r.getExamId() %></td>
                <td><%= r.getScore() %></td>
                <td><%= r.getTotalQuestions() %></td>
                <td><%= r.getResultDate() %></td>
                <td><%= r.getStatus() %></td>
            </tr>
        <% } %>
    </table>
<% } %>
