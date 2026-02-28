<!DOCTYPE html>
<html>
<head>
    <title>Exam Result</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="container">
    <h2>Exam Completed 🎉</h2>

    <div class="card">
        <h3>Your Score</h3>
        <p><b>${score}</b> / ${total}</p>
        <p>Percentage: <b>${percentage}%</b></p>
    </div>

    <br>
   <a href="<%= request.getContextPath() %>/dashboard" class="btn">
    Back to Dashboard
</a>
</div>

</body>
</html>