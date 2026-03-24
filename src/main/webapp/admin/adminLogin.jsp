<jsp:include page="/header.jsp" />
<div class="auth-shell">
    <div class="app-card auth-card">
        <h2 class="mb-1 text-center">Admin Login</h2>
        <p class="auth-subtitle text-center">Access administrative tools and oversight panels.</p>
        <form action="${pageContext.request.contextPath}/AdminLoginServlet" method="post">
            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" required />
            </div>
            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password" required />
            </div>
            <button type="submit" class="btn btn-primary custom w-100">Login</button>
        </form>
    </div>
</div>
<jsp:include page="/footer.jsp" />
