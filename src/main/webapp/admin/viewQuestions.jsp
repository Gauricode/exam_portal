<jsp:include page="/header.jsp" />
<%
    model.Admin admin = (model.Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    java.util.List<model.Question> questions = (java.util.List<model.Question>) session.getAttribute("questions");
    Integer examId = (Integer) session.getAttribute("examId");
%>
<div class="page-header">
    <div>
        <h2 class="mb-1">Questions for Exam ID: <%= examId %></h2>
        <p class="page-subtitle">Inspect all configured questions and answer keys.</p>
    </div>
    <div class="page-actions">
        <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</div>
<div class="app-card">
<% if (questions == null || questions.isEmpty()) { %>
    <div class="empty-state">No questions found for this exam.</div>
<% } else { %>
    <div class="table-panel">
    <div class="table-responsive">
    <table class="table table-striped align-middle mb-0">
        <thead>
            <tr>
                <th>ID</th><th>Text</th><th>A</th><th>B</th><th>C</th><th>D</th><th>Answer</th>
            </tr>
        </thead>
        <tbody>
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
        </tbody>
    </table>
    </div>
    </div>
<% } %>
</div>
<jsp:include page="/footer.jsp" />
