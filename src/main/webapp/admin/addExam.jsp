<jsp:include page="/header.jsp" />
<%
    model.Admin admin = (model.Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    String message = request.getParameter("msg");
%>
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h2 class="mb-1">Add Exam</h2>
        <p class="page-subtitle">Create a new exam with duration and question count settings.</p>
    </div>
    <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>

<div class="app-card">
    <form action="${pageContext.request.contextPath}/AddExamServlet" method="post">
        <div class="mb-3">
            <label>Exam Name</label>
            <input type="text" name="examName" required />
        </div>
        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" rows="3"></textarea>
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label>Duration (minutes)</label>
                <input type="number" name="duration" min="1" required />
            </div>
            <div class="col-md-6 mb-3">
                <label>Total Questions</label>
                <input type="number" name="totalQuestions" min="1" required />
            </div>
        </div>
        <button type="submit" class="btn btn-primary custom w-100">Create Exam</button>
    </form>

    <% if (message != null) { %>
        <div class="mt-3 alert alert-info"><%= message %></div>
    <% } %>
</div>

<jsp:include page="/footer.jsp" />
