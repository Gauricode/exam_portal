<%@ page import="java.util.*, model.Question" %>

<%
    List<Question> questions = (List<Question>) request.getAttribute("questions");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Live Exam</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="container">
    <h2>Live Exam</h2>

    <form action="<%= request.getContextPath() %>/submitExam" method="post">

    <% if (questions != null && !questions.isEmpty()) { 
           int i = 1;
           for (Question q : questions) { %>

            <div class="card">
                <p><b>Q<%= i++ %>: <%= q.getQuestion() %></b></p>

                <input type="radio" name="q<%= q.getId() %>" value="1"> <%= q.getOption1() %><br>
                <input type="radio" name="q<%= q.getId() %>" value="2"> <%= q.getOption2() %><br>
                <input type="radio" name="q<%= q.getId() %>" value="3"> <%= q.getOption3() %><br>
                <input type="radio" name="q<%= q.getId() %>" value="4"> <%= q.getOption4() %><br>
            </div>

    <%     } 
       } else { %>

        <p>No questions found.</p>

    <% } %>

    <br>
    <button type="submit" class="btn">Submit Exam</button>

    </form>
</div>

</body>
</html>