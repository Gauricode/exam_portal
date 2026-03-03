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

<div class="mt-3">
    <a href="../ResultServlet" class="btn btn-outline-primary">View My Results</a>
</div>
<jsp:include page="/footer.jsp" />

