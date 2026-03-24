<jsp:include page="/header.jsp" />
<%
    model.Admin admin = (model.Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    java.util.List<model.Result> results = (java.util.List<model.Result>) session.getAttribute("results");

    java.util.Map<Integer, String> examNameMap = new java.util.HashMap<Integer, String>();
    java.util.List<model.Exam> allExams = new dao.ExamDAO().getAllExams();
    for (model.Exam e : allExams) {
        examNameMap.put(e.getExamId(), e.getExamName());
    }
%>
<div class="page-header">
    <div>
        <h2 class="mb-1">All Results</h2>
        <p class="page-subtitle">Monitor outcomes, suspicious activity, and completion health.</p>
    </div>
    <div class="page-actions">
        <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</div>
<% if (results == null || results.isEmpty()) { %>
    <div class="empty-state">No results found yet.</div>
<% } else { %>
    <%
        int totalAttempts = results.size();
        int flaggedCount = 0;
        int timedOutCount = 0;
        int totalScore = 0;
        int totalQuestions = 0;
        for (model.Result r : results) {
            if ("Flagged".equals(r.getStatus())) flaggedCount++;
            if ("Timed Out".equals(r.getStatus())) timedOutCount++;
            totalScore += r.getScore();
            totalQuestions += r.getTotalQuestions();
        }
        double averagePercent = totalQuestions == 0 ? 0 : (totalScore * 100.0) / totalQuestions;
    %>
    <div class="row g-2 mb-3">
        <div class="col-md-3"><div class="summary-card neutral"><div class="label">Attempts</div><div class="value"><%= totalAttempts %></div></div></div>
        <div class="col-md-3"><div class="summary-card danger"><div class="label">Flagged</div><div class="value"><%= flaggedCount %></div></div></div>
        <div class="col-md-3"><div class="summary-card warn"><div class="label">Timed Out</div><div class="value"><%= timedOutCount %></div></div></div>
        <div class="col-md-3"><div class="summary-card info"><div class="label">Avg %</div><div class="value"><%= String.format("%.2f", averagePercent) %>%</div></div></div>
    </div>

    <div class="table-panel">
    <div class="table-responsive">
    <table class="table table-striped align-middle mb-0">
        <thead>
            <tr>
                <th>Result ID</th><th>Student ID</th><th>Exam</th><th>Score</th><th>Total</th><th>Percentage</th><th>Date</th><th>Status</th><th>Suspicious</th>
            </tr>
        </thead>
        <tbody>
        <% for (model.Result r : results) {
               String rowClass = "";
               if ("Flagged".equals(r.getStatus())) { rowClass = "table-danger"; }
               else if ("Timed Out".equals(r.getStatus())) { rowClass = "table-warning"; }
               double percent = r.getTotalQuestions() == 0 ? 0 : (r.getScore() * 100.0) / r.getTotalQuestions();
               String statusBadge = "badge bg-success";
               if ("Flagged".equals(r.getStatus())) { statusBadge = "badge bg-danger"; }
               else if ("Timed Out".equals(r.getStatus())) { statusBadge = "badge bg-warning text-dark"; }
        %>
            <tr class="<%= rowClass %>">
                <td><%= r.getResultId() %></td>
                <td><%= r.getStudentId() %></td>
                <td><strong><%= examNameMap.getOrDefault(r.getExamId(), "Exam #" + r.getExamId()) %></strong><br><small class="text-muted">ID: <%= r.getExamId() %></small></td>
                <td><%= r.getScore() %></td>
                <td><%= r.getTotalQuestions() %></td>
                <td><%= String.format("%.2f", percent) %>%</td>
                <td><%= r.getResultDate() %></td>
                <td><span class="<%= statusBadge %>"><%= r.getStatus() %></span></td>
                <td><%= r.getSuspiciousCount() %></td>
            </tr>
        <% } %>
        </tbody>
    </table>
    </div>
    </div>
<% } %>
<jsp:include page="/footer.jsp" />
