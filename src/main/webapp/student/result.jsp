<jsp:include page="/header.jsp" />
<%
    model.Student student = (model.Student) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    dao.ResultDAO dao = new dao.ResultDAO();
    java.util.List<model.Result> results = dao.getResultsByStudentId(student.getStudentId());
    session.setAttribute("results", results);

    java.util.Map<Integer, String> examNameMap = new java.util.HashMap<Integer, String>();
    java.util.List<model.Exam> allExams = new dao.ExamDAO().getAllExams();
    for (model.Exam e : allExams) {
        examNameMap.put(e.getExamId(), e.getExamName());
    }
%>
<div class="page-header">
    <div>
        <h2 class="mb-1">My Results</h2>
        <p class="page-subtitle">Review your performance and status across attempts.</p>
    </div>
    <div class="page-actions">
        <a href="studentDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</div>
<% if (results == null || results.isEmpty()) { %>
    <div class="empty-state">No results to display yet.</div>
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
        <div class="col-md-3"><div class="summary-card warn"><div class="label">Flagged</div><div class="value"><%= flaggedCount %></div></div></div>
        <div class="col-md-3"><div class="summary-card danger"><div class="label">Timed Out</div><div class="value"><%= timedOutCount %></div></div></div>
        <div class="col-md-3"><div class="summary-card info"><div class="label">Avg %</div><div class="value"><%= String.format("%.2f", averagePercent) %>%</div></div></div>
    </div>

    <div class="table-panel">
    <div class="table-responsive">
    <table class="table table-striped align-middle mb-0">
        <thead>
            <tr>
                <th>Exam</th><th>Score</th><th>Total</th><th>Percentage</th><th>Date</th><th>Status</th><th>Suspicious</th>
            </tr>
        </thead>
        <tbody>
        <% for (model.Result r : results) { 
               String rowClass = "";
               if ("Flagged".equals(r.getStatus())) { rowClass = "table-danger"; }
               else if ("Timed Out".equals(r.getStatus())) { rowClass = "table-warning"; }
               double percent = r.getTotalQuestions() == 0 ? 0 : (r.getScore() * 100.0) / r.getTotalQuestions();
             String displayDate = r.getResultDate() == null ? "-" : r.getResultDate().replace("T", " ");
               String statusBadge = "badge bg-success";
               if ("Flagged".equals(r.getStatus())) { statusBadge = "badge bg-danger"; }
               else if ("Timed Out".equals(r.getStatus())) { statusBadge = "badge bg-warning text-dark"; }
        %>
            <tr class="<%= rowClass %>">
                <td><strong><%= examNameMap.getOrDefault(r.getExamId(), "Exam #" + r.getExamId()) %></strong><br><small class="text-muted">ID: <%= r.getExamId() %></small></td>
                <td><%= r.getScore() %></td>
                <td><%= r.getTotalQuestions() %></td>
                <td><%= String.format("%.2f", percent) %>%</td>
                <td><%= displayDate %></td>
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

