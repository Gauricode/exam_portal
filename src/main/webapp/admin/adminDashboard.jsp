<jsp:include page="/header.jsp" />
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    String adminName = ((model.Admin) session.getAttribute("admin")).getName();
%>
<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Admin Dashboard</h2>
    <a href="../LogoutServlet" class="btn btn-outline-secondary">Logout</a>
</div>
<div class="app-card mb-4 dashboard-hero">
    <h4 class="mb-1">Welcome back, <%= adminName %></h4>
    <p class="muted mb-0">Manage students, monitor exam integrity, and maintain question banks from one place.</p>
</div>

<div class="dashboard-grid">
    <a href="../ViewStudentsServlet" class="dashboard-tile">
        <h5>View Students</h5>
        <p>Review registered learners and their profiles.</p>
    </a>
    <a href="../ViewResultsServlet" class="dashboard-tile">
        <h5>View Results</h5>
        <p>Track exam outcomes, scores, and completion trends.</p>
    </a>
    <a href="../ViewViolationsServlet" class="dashboard-tile">
        <h5>View Violations</h5>
        <p>Inspect suspicious activity with structured logs.</p>
    </a>
    <a href="addQuestion.jsp" class="dashboard-tile">
        <h5>Add Question</h5>
        <p>Update your question bank for upcoming tests.</p>
    </a>
    <a href="addExam.jsp" class="dashboard-tile">
        <h5>Create New Exam</h5>
        <p>Set up exam metadata and configure duration.</p>
    </a>
</div>
<jsp:include page="/footer.jsp" />
