<%
    model.Admin admin = (model.Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    java.util.List<model.Student> students = (java.util.List<model.Student>) session.getAttribute("students");
%>

<h2>All Students</h2>
<a href="adminDashboard.jsp">Back to Dashboard</a><br><br>

<% if (students == null || students.isEmpty()) { %>
    <p>No students found.</p>
<% } else { %>
    <table border="1">
        <tr>
            <th>Student ID</th><th>Name</th><th>Email</th>
        </tr>
        <% for (model.Student s : students) { %>
            <tr>
                <td><%= s.getStudentId() %></td>
                <td><%= s.getName() %></td>
                <td><%= s.getEmail() %></td>
            </tr>
        <% } %>
    </table>
<% } %>
