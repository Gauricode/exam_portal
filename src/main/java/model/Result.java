package model;

public class Result {
    private int resultId;
    private int studentId;
    private int examId;
    private int score;
    private int totalQuestions;
    private String resultDate;
    private String status;

    public Result() {}

    public Result(int resultId, int studentId, int examId, int score, int totalQuestions, String resultDate, String status) {
        this.resultId = resultId;
        this.studentId = studentId;
        this.examId = examId;
        this.score = score;
        this.totalQuestions = totalQuestions;
        this.resultDate = resultDate;
        this.status = status;
    }

    public int getResultId() { return resultId; }
    public void setResultId(int resultId) { this.resultId = resultId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getExamId() { return examId; }
    public void setExamId(int examId) { this.examId = examId; }

    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }

    public int getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(int totalQuestions) { this.totalQuestions = totalQuestions; }

    public String getResultDate() { return resultDate; }
    public void setResultDate(String resultDate) { this.resultDate = resultDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
