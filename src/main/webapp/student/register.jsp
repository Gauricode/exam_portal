<jsp:include page="/header.jsp" />
<div class="auth-shell">
    <div class="app-card auth-card">
        <h2 class="mb-1 text-center">Student Registration</h2>
        <p class="auth-subtitle text-center">Create your account to access exams securely.</p>
        <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
            <div class="mb-3">
                <label>Name</label>
                <input type="text" name="name" required />
            </div>
            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" required />
            </div>
            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password" required />
            </div>
            <button type="submit" class="btn btn-success custom w-100">Register</button>
        </form>
        <p class="text-center mt-3 mb-0"><a href="${pageContext.request.contextPath}/student/login.jsp">Already have an account? Login</a></p>
    </div>
</div>
<jsp:include page="/footer.jsp" />

