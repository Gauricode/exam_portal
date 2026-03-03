<jsp:include page="/header.jsp" />
<%
        model.Student student = (model.Student) session.getAttribute("student");
        model.Exam exam = (model.Exam) session.getAttribute("exam");
        java.util.List<model.Question> questions = (java.util.List<model.Question>) session.getAttribute("questions");
        Integer currentQuestionObj = (Integer) session.getAttribute("currentQuestion");
        java.util.Map<Integer, String> examAnswers = (java.util.Map<Integer, String>) session.getAttribute("examAnswers");
        Long examEndTimeObj = (Long) session.getAttribute("examEndTime");

        if (student == null || exam == null || questions == null) {
                response.sendRedirect("studentDashboard.jsp");
                return;
        }

        int currentQuestion = currentQuestionObj == null ? 0 : currentQuestionObj;
        if (currentQuestion < 0) currentQuestion = 0;
        if (currentQuestion >= questions.size()) currentQuestion = questions.size() - 1;

        model.Question q = questions.get(currentQuestion);
        String selectedAnswer = examAnswers == null ? null : examAnswers.get(q.getQuestionId());
        int answeredCount = examAnswers == null ? 0 : examAnswers.size();
        long examEndTime = examEndTimeObj == null ? (System.currentTimeMillis() + (exam.getDuration() > 0 ? exam.getDuration() : 30) * 60L * 1000L) : examEndTimeObj;
%>
<div class="exam-container exam-page-shell">
        <div class="d-flex justify-content-between align-items-center mb-3 exam-head-wrap">
            <div class="exam-head-left">
                <h2 class="mb-1 exam-title">Exam: <%= exam.getExamName() %></h2>
                <p class="muted mb-1">Student: <strong><%= student.getName() %></strong></p>
                <p class="muted mb-0 exam-meta">Question <%= currentQuestion + 1 %> of <%= questions.size() %> • Answered: <span id="answeredCount"><%= answeredCount %></span> / <%= questions.size() %></p>
            </div>
            <div class="timer exam-timer">Time Left: <span id="timeLeft">--:--</span></div>
        </div>

        <form action="../NavigateExamServlet" method="post" id="examForm">
            <div class="question">
                <p class="question-title"><strong>Question <%= currentQuestion + 1 %>:</strong> <%= q.getQuestionText() %></p>
                <div class="options">
                    <label class="option-item"><input type="radio" name="answer" value="A" <%= "A".equals(selectedAnswer) ? "checked" : "" %>> <span><strong>A.</strong> <%= q.getOptionA() %></span></label>
                    <label class="option-item"><input type="radio" name="answer" value="B" <%= "B".equals(selectedAnswer) ? "checked" : "" %>> <span><strong>B.</strong> <%= q.getOptionB() %></span></label>
                    <label class="option-item"><input type="radio" name="answer" value="C" <%= "C".equals(selectedAnswer) ? "checked" : "" %>> <span><strong>C.</strong> <%= q.getOptionC() %></span></label>
                    <label class="option-item"><input type="radio" name="answer" value="D" <%= "D".equals(selectedAnswer) ? "checked" : "" %>> <span><strong>D.</strong> <%= q.getOptionD() %></span></label>
                </div>
            </div>
            <hr />

            <!-- hidden fields for proctoring counter and log -->
            <input type="hidden" name="suspicious" id="suspicious" value="0">
            <input type="hidden" name="proctorLog" id="proctorLog" value="[]">
            <input type="hidden" name="autoSubmitReason" id="autoSubmitReason" value="">
            <input type="hidden" name="targetIndex" id="targetIndex" value="<%= currentQuestion %>">
            <input type="hidden" id="serverExamEndTime" value="<%= examEndTime %>">
            <input type="hidden" id="initialAnsweredCount" value="<%= answeredCount %>">
            <input type="hidden" id="hadSavedCurrent" value="<%= selectedAnswer != null %>">
            <input type="hidden" id="totalQuestionsCount" value="<%= questions.size() %>">

            <div class="mb-2 d-flex align-items-center gap-3 flex-wrap small exam-legend">
                <span class="d-inline-flex align-items-center">
                    <span class="rounded-circle bg-primary d-inline-block me-1" style="width:10px;height:10px;"></span>Current
                </span>
                <span class="d-inline-flex align-items-center">
                    <span class="rounded-circle bg-success d-inline-block me-1" style="width:10px;height:10px;"></span>Answered
                </span>
                <span class="d-inline-flex align-items-center">
                    <span class="rounded-circle bg-secondary d-inline-block me-1" style="width:10px;height:10px;"></span>Unanswered
                </span>
            </div>

            <div class="mb-3 question-nav-wrap">
                <% for (int i = 0; i < questions.size(); i++) { %>
                    <%
                        int navQuestionId = questions.get(i).getQuestionId();
                        boolean isAnswered = examAnswers != null && examAnswers.get(navQuestionId) != null;
                        if (i == currentQuestion && selectedAnswer != null) {
                            isAnswered = true;
                        }
                        String navBtnClass;
                        if (i == currentQuestion) {
                            navBtnClass = "btn-primary";
                        } else if (isAnswered) {
                            navBtnClass = "btn-success";
                        } else {
                            navBtnClass = "btn-outline-secondary";
                        }
                    %>
                    <button
                        type="submit"
                        name="action"
                        value="jump"
                        data-target="<%= i %>"
                        class="btn question-nav-btn <%= navBtnClass %>"
                        onclick="setTargetIndexFromButton(this)"
                    ><%= i + 1 %></button>
                <% } %>
            </div>
            <div class="spacer"></div>

            <div class="exam-action-row">
                <div>
                    <% if (currentQuestion > 0) { %>
                        <button type="submit" name="action" value="previous" class="btn btn-secondary custom exam-action-btn">Previous</button>
                    <% } %>
                </div>
                <div class="exam-action-right">
                    <% if (currentQuestion < questions.size() - 1) { %>
                        <button type="submit" name="action" value="next" class="btn btn-primary custom exam-action-btn">Next</button>
                    <% } else { %>
                        <button type="submit" formaction="../SubmitExamServlet" class="btn btn-success custom exam-action-btn">Submit Exam</button>
                    <% } %>
                </div>
            </div>
        </form>
</div>

<script>

let suspiciousCount = 0;
let proctorLog = [];
const examForm = document.getElementById("examForm");
const storagePrefix = "exam_<%= exam.getExamId() %>_<%= student.getStudentId() %>";
const suspiciousKey = storagePrefix + "_suspicious";
const logKey = storagePrefix + "_proctor_log";
const endTimeKey = storagePrefix + "_end_time";
const answeredCountEl = document.getElementById("answeredCount");
let isAutoSubmitting = false;
const serverExamEndTime = parseInt(document.getElementById("serverExamEndTime").value, 10);
const initialAnsweredCount = parseInt(document.getElementById("initialAnsweredCount").value, 10) || 0;
const hadSavedCurrent = document.getElementById("hadSavedCurrent").value === "true";
const totalQuestionsCount = parseInt(document.getElementById("totalQuestionsCount").value, 10) || 0;
let hiddenEventOpen = false;
let hiddenEventCount = 0;

function setTargetIndexFromButton(buttonEl) {
    document.getElementById("targetIndex").value = buttonEl.getAttribute("data-target");
}

function syncHiddenFields() {
    document.getElementById("suspicious").value = suspiciousCount;
    document.getElementById("proctorLog").value = JSON.stringify(proctorLog);
}

const storedEndTime = sessionStorage.getItem(endTimeKey);
if (storedEndTime === null || parseInt(storedEndTime, 10) !== serverExamEndTime) {
    sessionStorage.setItem(endTimeKey, String(serverExamEndTime));
    sessionStorage.removeItem(suspiciousKey);
    sessionStorage.removeItem(logKey);
}

const storedSuspicious = sessionStorage.getItem(suspiciousKey);
const storedProctorLog = sessionStorage.getItem(logKey);

if (storedSuspicious !== null) {
    const parsedSuspicious = parseInt(storedSuspicious, 10);
    if (!isNaN(parsedSuspicious)) {
        suspiciousCount = parsedSuspicious;
    }
}

if (storedProctorLog) {
    try {
        const parsedLog = JSON.parse(storedProctorLog);
        if (Array.isArray(parsedLog)) {
            proctorLog = parsedLog;
        }
    } catch (e) {
        proctorLog = [];
    }
}

syncHiddenFields();

function getLocalSelectedAnswer() {
    const selected = document.querySelector('input[name="answer"]:checked');
    return selected ? selected.value : null;
}

function getEffectiveAnsweredCount() {
    const baseCount = initialAnsweredCount;
    const hadSaved = hadSavedCurrent;
    const hasNow = getLocalSelectedAnswer() !== null;

    if (hadSaved || !hasNow) {
        return baseCount;
    }
    return baseCount + 1;
}

function updateAnsweredCount() {
    if (answeredCountEl) {
        answeredCountEl.textContent = String(getEffectiveAnsweredCount());
    }
}

function formatTimeLeft(totalSeconds) {
    const mins = Math.floor(totalSeconds / 60);
    const secs = totalSeconds % 60;
    return String(mins).padStart(2, '0') + ":" + String(secs).padStart(2, '0');
}

function autoSubmitExam(reasonText) {
    if (isAutoSubmitting) {
        return;
    }
    isAutoSubmitting = true;
    document.getElementById("autoSubmitReason").value = reasonText;
    examForm.action = "../SubmitExamServlet";
    syncHiddenFields();
    examForm.submit();
}

function startTimer() {
    const timeLeftEl = document.getElementById("timeLeft");
    const tick = function () {
        const endTime = parseInt(sessionStorage.getItem(endTimeKey), 10);
        const remainingMs = endTime - Date.now();
        const remainingSeconds = Math.max(0, Math.floor(remainingMs / 1000));
        timeLeftEl.textContent = formatTimeLeft(remainingSeconds);

        if (remainingSeconds <= 0) {
            alert("Time is up. Exam will be submitted automatically.");
            autoSubmitExam("timeout");
        }
    };

    tick();
    setInterval(tick, 1000);
}

updateAnsweredCount();
startTimer();

function logEvent(type) {
    suspiciousCount++;
    proctorLog.push({type: type, timestamp: new Date().toISOString()});
    sessionStorage.setItem(suspiciousKey, suspiciousCount);
    sessionStorage.setItem(logKey, JSON.stringify(proctorLog));
    syncHiddenFields();
    alert("Warning! " + type);
    // if too many suspicious actions, auto submit to flag/terminate the exam
    var threshold = 3;
    if (suspiciousCount >= threshold) {
        alert("Too many suspicious activities – exam will be submitted automatically.");
        autoSubmitExam("proctor-threshold");
    }
}

// Detect visibility change (tab switch/minimize) with deduplication
document.addEventListener("visibilitychange", function () {
    if (document.hidden) {
        if (!hiddenEventOpen) {
            hiddenEventOpen = true;
            hiddenEventCount++;
            if (hiddenEventCount >= 2) {
                logEvent("Repeated tab switching/page hiding detected");
            }
        }
    } else {
        hiddenEventOpen = false;
    }
});

// detect opening dev tools via F12 or Ctrl+Shift+I
document.addEventListener('keydown', function(e) {
    if (e.key === 'F12' || (e.ctrlKey && e.shiftKey && e.key === 'I')) {
        e.preventDefault();
        logEvent('Opened developer tools');
    }
});

// disable right click
document.addEventListener('contextmenu', function(e) {
    e.preventDefault();
    logEvent('Right-click/context menu');
});

if (document.documentElement.requestFullscreen) {
    document.documentElement.requestFullscreen().catch(function () {
    });
}

document.addEventListener("fullscreenchange", function () {
    if (!document.fullscreenElement) {
        logEvent("Exited fullscreen");
    }
});

examForm.addEventListener("submit", function(event) {
    const localAnsweredCount = getEffectiveAnsweredCount();
    const unansweredCount = Math.max(0, totalQuestionsCount - localAnsweredCount);
    const isFinalSubmit = event.submitter && event.submitter.formAction && event.submitter.formAction.indexOf("SubmitExamServlet") !== -1;

    if (!isAutoSubmitting && isFinalSubmit && unansweredCount > 0) {
        const proceed = confirm("You still have " + unansweredCount + " unanswered question(s). Submit anyway?");
        if (!proceed) {
            event.preventDefault();
            return;
        }
    }

    syncHiddenFields();
});

document.querySelectorAll('input[name="answer"]').forEach(function (inputEl) {
    inputEl.addEventListener("change", updateAnsweredCount);
});
</script>
<jsp:include page="/footer.jsp" />
