<jsp:include page="/header.jsp" />
<div class="auth-shell">
    <div class="app-card auth-card">
        <h2 class="mb-1 text-center">Student Login</h2>
        <p class="auth-subtitle text-center">Sign in to start your exam and track results.</p>
        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <div class="mb-3">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required />
            </div>
            <div class="mb-3">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required />
            </div>
            <button type="submit" class="btn btn-primary custom w-100">Login</button>
        </form>
        <p class="text-center mt-3 mb-0"><a href="${pageContext.request.contextPath}/student/register.jsp">Don't have an account? Register</a></p>
    </div>
</div>
<jsp:include page="/footer.jsp" />

