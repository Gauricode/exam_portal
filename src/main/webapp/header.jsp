<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Online Exam</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand brand" href="${pageContext.request.contextPath}/">OnlineExam</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav"
                        aria-controls="mainNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link custom" href="${pageContext.request.contextPath}/student/login.jsp">Student</a></li>
                <li class="nav-item"><a class="nav-link custom" href="${pageContext.request.contextPath}/admin/adminLogin.jsp">Admin</a></li>
                <li class="nav-item"><a class="nav-link custom" href="${pageContext.request.contextPath}/student/register.jsp">Register</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
