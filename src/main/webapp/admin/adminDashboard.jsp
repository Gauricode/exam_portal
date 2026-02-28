<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<h2>Admin Dashboard</h2>
<p>Welcome, <%= ((model.Admin) session.getAttribute("admin")).getName() %>!</p>
<ul>
    <li><a href="../ViewStudentsServlet">View Students</a></li>
    <li><a href="../ViewResultsServlet">View Results</a></li>
    <li><a href="addQuestion.jsp">Add Question to Exam</a></li>
</ul>
