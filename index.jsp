<!DOCTYPE html>
<html>
<head>
    <title>Online Proctored Examination System</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body class="login-body">

<div class="login-container">

    <div class="login-card">
        <h2>Online Examination System</h2>
        <p class="subtitle">Secure Student Login</p>

        <form action="<%= request.getContextPath() %>/login" method="post">

            <div class="input-group">
                <label>Email</label>
                <input type="text" name="email" required>
            </div>

            <div class="input-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>

            <button type="submit" class="login-btn">Login</button>

        </form>
    </div>

</div>

</body>
</html>