<%@ page import="java.util.*, model.Exam" %>

<%
    List<Exam> exams = (List<Exam>) request.getAttribute("examList");
%>

<% if (exams != null) {
       for (Exam e : exams) { %>

<tr>
    <td><%= e.getTitle() %></td>
    <td><%= e.getDuration() %> mins</td>
    <td>
        <a href="<%= request.getContextPath() %>/startExam?id=<%= e.getId() %>" class="btn">
            Start
        </a>
    </td>
</tr>

<%   }
   } %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="navbar">
    <h2>Online Examination System</h2>
    <a href="logout">Logout</a>
</div>

<div class="container">
    <h3>Welcome, <%= studentName %></h3>

    <div class="cards">
        <div class="card">
            <h4>Total Exams</h4>
            <p>${totalExams}</p>
        </div>

        <div class="card">
            <h4>Completed</h4>
            <p>${completed}</p>
        </div>

        <div class="card">
            <h4>Pending</h4>
            <p>${pending}</p>
        </div>

        <div class="card">
            <h4>Average Score</h4>
            <p>
<%
    Double avg = (Double) request.getAttribute("average");
    if (avg == null) avg = 0.0;
    out.print(String.format("%.2f", avg) + "%");
%>
</p>
        </div>
    </div>

    <h3>Your Examinations</h3>

    <table>
        <tr>
            <th>Exam Title</th>
            <th>Duration</th>
            <th>Action</th>
        </tr>

        <% if (exams != null) {
            for (Exam e : exams) { %>
            <tr>
                <td><%= e.getTitle() %></td>
                <td><%= e.getDuration() %> mins</td>
                <td>
                    <a href="startExam?id=<%= e.getId() %>" class="btn">Start</a>
                </td>
            </tr>
        <% } } %>
    </table>

</div>

</body>
</html>