<%
    model.Admin admin = (model.Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    java.util.List<model.Result> results = (java.util.List<model.Result>) session.getAttribute("results");
%>

<h2>All Results</h2>
<a href="adminDashboard.jsp">Back to Dashboard</a><br><br>

<% if (results == null || results.isEmpty()) { %>
    <p>No results found.</p>
<% } else { %>
    <table border="1">
        <tr>
            <th>Result ID</th><th>Student ID</th><th>Exam ID</th><th>Score</th><th>Total</th><th>Date</th><th>Status</th>
        </tr>
        <% for (model.Result r : results) { %>
            <tr>
                <td><%= r.getResultId() %></td>
                <td><%= r.getStudentId() %></td>
                <td><%= r.getExamId() %></td>
                <td><%= r.getScore() %></td>
                <td><%= r.getTotalQuestions() %></td>
                <td><%= r.getResultDate() %></td>
                <td><%= r.getStatus() %></td>
            </tr>
        <% } %>
    </table>
<% } %>
