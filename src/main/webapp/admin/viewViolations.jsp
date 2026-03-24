<jsp:include page="/header.jsp" />
<%
    model.Admin admin = (model.Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    java.util.List<model.Violation> violations = (java.util.List<model.Violation>) session.getAttribute("violations");

    java.util.Map<Integer, String> studentNameMap = new java.util.HashMap<Integer, String>();
    java.util.List<model.Student> allStudents = new dao.StudentDAO().getAllStudents();
    for (model.Student s : allStudents) {
        studentNameMap.put(s.getStudentId(), s.getName());
    }

    java.util.Map<Integer, String> examNameMap = new java.util.HashMap<Integer, String>();
    java.util.List<model.Exam> allExams = new dao.ExamDAO().getAllExams();
    for (model.Exam e : allExams) {
        examNameMap.put(e.getExamId(), e.getExamName());
    }
%>
<div class="page-header">
    <div>
        <h2 class="mb-1">Proctoring Violations</h2>
        <p class="page-subtitle">Review behavior logs and investigate suspicious attempts.</p>
    </div>
    <div class="page-actions">
        <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</div>
<% if (violations == null || violations.isEmpty()) { %>
    <div class="empty-state">No violations recorded.</div>
<% } else { %>
    <%
        int totalViolations = violations.size();
        java.util.Set<Integer> uniqueStudents = new java.util.HashSet<Integer>();
        java.util.Set<Integer> uniqueExams = new java.util.HashSet<Integer>();
        for (model.Violation v : violations) {
            uniqueStudents.add(v.getStudentId());
            uniqueExams.add(v.getExamId());
        }
    %>
    <div class="row g-2 mb-3">
        <div class="col-md-4"><div class="summary-card danger"><div class="label">Total Violations</div><div class="value"><%= totalViolations %></div></div></div>
        <div class="col-md-4"><div class="summary-card warn"><div class="label">Students Involved</div><div class="value"><%= uniqueStudents.size() %></div></div></div>
        <div class="col-md-4"><div class="summary-card info"><div class="label">Exams Affected</div><div class="value"><%= uniqueExams.size() %></div></div></div>
    </div>

    <div class="table-panel">
    <div class="table-responsive">
    <table class="table table-striped align-middle mb-0">
        <thead>
            <tr>
                <th>ID</th><th>Student</th><th>Exam</th><th>Type</th><th>Summary</th><th>Date</th><th>Details</th>
            </tr>
        </thead>
        <tbody>
        <% for (model.Violation v : violations) {
               String rawDescription = v.getDescription() == null ? "" : v.getDescription();
               String summary = rawDescription;
               String details = "";
               int detailsIndex = rawDescription.indexOf("; details=");
               if (detailsIndex >= 0) {
                   summary = rawDescription.substring(0, detailsIndex);
                   details = rawDescription.substring(detailsIndex + 10);
               }
               String normalizedDetails = details
                       .replace("},{", "},\n{")
                       .replace("\",\"", "\",\n\"")
                       .replace("[{", "[\n{")
                       .replace("}]", "}\n]");
               String displayDate = v.getViolationDate() == null ? "-" : v.getViolationDate().replace("T", " ");
        %>
            <tr>
                <td><%= v.getViolationId() %></td>
                <td><strong><%= studentNameMap.getOrDefault(v.getStudentId(), "Student #" + v.getStudentId()) %></strong><br><small class="text-muted">ID: <%= v.getStudentId() %></small></td>
                <td><strong><%= examNameMap.getOrDefault(v.getExamId(), "Exam #" + v.getExamId()) %></strong><br><small class="text-muted">ID: <%= v.getExamId() %></small></td>
                <td><span class="badge bg-danger"><%= v.getViolationType() %></span></td>
                <td class="violation-summary"><%= summary %></td>
                <td><%= displayDate %></td>
                <td>
                    <% if (details != null && !details.trim().isEmpty()) { %>
                        <details>
                            <summary>View events</summary>
                            <pre class="violation-details"><%= normalizedDetails %></pre>
                        </details>
                    <% } else { %>
                        <span class="text-muted">-</span>
                    <% } %>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
    </div>
    </div>
<% } %>
<jsp:include page="/footer.jsp" />
