<jsp:include page="/header.jsp" />
<%
    if (session.getAttribute("student") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String studentName = ((model.Student) session.getAttribute("student")).getName();
%>
<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Student Dashboard</h2>
    <a href="../LogoutServlet" class="btn btn-outline-secondary">Logout</a>
</div>
<div class="app-card mb-4 dashboard-hero">
    <h4 class="mb-1">Welcome, <%= studentName %></h4>
    <p class="muted mb-0">Select an exam, complete it carefully, and view your latest results.</p>
</div>

<div class="app-card">
<h3 class="mb-3">Available Exams</h3>
<%
    dao.ExamDAO examDAO = new dao.ExamDAO();
    java.util.List<model.Exam> exams = examDAO.getAllExams();

    java.util.Map<Integer, String> examNameMap = new java.util.HashMap<Integer, String>();
    if (exams != null) {
        for (model.Exam e : exams) {
            examNameMap.put(e.getExamId(), e.getExamName());
        }
    }

    dao.ResultDAO resultDAO = new dao.ResultDAO();
    java.util.List<model.Result> recentResults = resultDAO.getResultsByStudentId(((model.Student) session.getAttribute("student")).getStudentId());
%>
<% if (exams == null || exams.isEmpty()) { %>
    <p class="muted mb-0">No exams available right now.</p>
<% } else { %>
    <form action="../StartExamServlet" method="post" class="row g-3 align-items-end">
        <div class="col-md-8">
            <label class="form-label">Choose Exam</label>
            <select name="examId" class="form-select" required>
                <% for (model.Exam exam : exams) { %>
                    <option value="<%= exam.getExamId() %>"><%= exam.getExamName() %> - <%= exam.getDescription() %></option>
                <% } %>
            </select>
        </div>
        <div class="col-md-4">
            <button type="submit" class="btn btn-primary custom w-100">Start Exam</button>
        </div>
    </form>
<% } %>
</div>

<div class="app-card mt-3">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">Recent Results</h3>
        <a href="../ResultServlet" class="btn btn-outline-primary">View All Results</a>
    </div>

    <% if (recentResults == null || recentResults.isEmpty()) { %>
        <div class="empty-state">You have not attempted any exams yet.</div>
    <% } else { %>
        <div class="table-panel">
            <div class="table-responsive">
                <table class="table table-striped align-middle mb-0">
                    <thead>
                        <tr>
                            <th>Exam</th><th>Score</th><th>Total</th><th>Status</th><th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        int rowCount = 0;
                        for (model.Result r : recentResults) {
                            if (rowCount >= 5) break;
                            String statusBadge = "badge bg-success";
                            if ("Flagged".equals(r.getStatus())) statusBadge = "badge bg-danger";
                            else if ("Timed Out".equals(r.getStatus())) statusBadge = "badge bg-warning text-dark";
                            String displayDate = r.getResultDate() == null ? "-" : r.getResultDate().replace("T", " ");
                            rowCount++;
                    %>
                        <tr>
                            <td><%= examNameMap.getOrDefault(r.getExamId(), "Exam #" + r.getExamId()) %></td>
                            <td><%= r.getScore() %></td>
                            <td><%= r.getTotalQuestions() %></td>
                            <td><span class="<%= statusBadge %>"><%= r.getStatus() %></span></td>
                            <td><%= displayDate %></td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    <% } %>
</div>
<jsp:include page="/footer.jsp" />

