<jsp:include page="/header.jsp" />
<%
    model.Admin admin = (model.Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    java.util.List<model.Student> students = (java.util.List<model.Student>) session.getAttribute("students");
%>
<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>All Students</h2>
    <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>
<% if (students == null || students.isEmpty()) { %>
    <p>No students found.</p>
<% } else { %>
    <div class="app-card">
    <div class="table-responsive">
    <table class="table table-striped align-middle mb-0">
        <thead>
            <tr>
                <th>Student ID</th><th>Name</th><th>Email</th>
            </tr>
        </thead>
        <tbody>
        <% for (model.Student s : students) { %>
            <tr>
                <td><%= s.getStudentId() %></td>
                <td><%= s.getName() %></td>
                <td><%= s.getEmail() %></td>
            </tr>
        <% } %>
        </tbody>
    </table>
    </div>
    </div>
<% } %>
<jsp:include page="/footer.jsp" />
