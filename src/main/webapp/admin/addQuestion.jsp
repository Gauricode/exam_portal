<jsp:include page="/header.jsp" />
<%
    model.Admin admin = (model.Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    dao.ExamDAO examDAO = new dao.ExamDAO();
    java.util.List<model.Exam> exams = examDAO.getAllExams();

    String examIdParam = request.getParameter("examId");
    String message = request.getParameter("msg");
%>
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h2 class="mb-1">Add Question</h2>
        <p class="page-subtitle">Attach a well-structured MCQ to the selected exam.</p>
    </div>
    <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>
<div class="app-card">
<form action="../AddQuestionServlet" method="post">
    <div class="mb-3">
        <label class="form-label">Exam</label>
        <select name="examId" class="form-select" required>
            <% for (model.Exam e : exams) { %>
                <option value="<%= e.getExamId() %>" <%= (examIdParam != null && examIdParam.equals(String.valueOf(e.getExamId()))) ? "selected" : "" %>>
                    <%= e.getExamName() %>
                </option>
            <% } %>
        </select>
    </div>
    <div class="mb-3">
        <label class="form-label">Question Text</label>
        <textarea name="questionText" class="form-control" required rows="3"></textarea>
    </div>
    <div class="row">
        <div class="col-md-6 mb-3">
            <label class="form-label">Option A</label>
            <input type="text" class="form-control" name="optionA" required>
        </div>
        <div class="col-md-6 mb-3">
            <label class="form-label">Option B</label>
            <input type="text" class="form-control" name="optionB" required>
        </div>
        <div class="col-md-6 mb-3">
            <label class="form-label">Option C</label>
            <input type="text" class="form-control" name="optionC" required>
        </div>
        <div class="col-md-6 mb-3">
            <label class="form-label">Option D</label>
            <input type="text" class="form-control" name="optionD" required>
        </div>
    </div>
    <div class="mb-3">
        <label class="form-label">Correct Answer</label>
        <select name="correctAnswer" class="form-select" required>
            <option value="A">A</option>
            <option value="B">B</option>
            <option value="C">C</option>
            <option value="D">D</option>
        </select>
    </div>
    <button type="submit" class="btn btn-success custom w-100">Add Question</button>
</form>
<% if (message != null) { %>
    <div class="alert alert-info mt-3"><%= message %></div>
<% } %>
<% if (examIdParam != null) { %>
    <a href="ViewQuestionsServlet?examId=<%= examIdParam %>" class="btn btn-link mt-3">View Questions for selected exam</a>
<% } %>
</div>
<jsp:include page="/footer.jsp" />
