<%
    if (session.getAttribute("student") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<h2>Student Dashboard</h2>
<p>Welcome, <%= ((model.Student) session.getAttribute("student")).getName() %>!</p>
<a href="../LogoutServlet">Logout</a><br><br>

<h3>Available Exams</h3>
<%
    dao.ExamDAO examDAO = new dao.ExamDAO();
    java.util.List<model.Exam> exams = examDAO.getAllExams();
%>
<% if (exams == null || exams.isEmpty()) { %>
    <p>No exams available.</p>
<% } else { %>
    <form action="../StartExamServlet" method="post">
        <select name="examId">
            <% for (model.Exam exam : exams) { %>
                <option value="<%= exam.getExamId() %>"><%= exam.getExamName() %> - <%= exam.getDescription() %></option>
            <% } %>
        </select>
        <button type="submit">Start Exam</button>
    </form>
<% } %>

<br>
<a href="../ResultServlet">View My Results</a>
