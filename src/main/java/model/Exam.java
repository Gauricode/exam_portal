package model;

public class Exam {
    private int examId;
    private String examName;
    private String description;
    private int duration;
    private int totalQuestions;

    public Exam() {}

    public Exam(int examId, String examName, String description, int duration, int totalQuestions) {
        this.examId = examId;
        this.examName = examName;
        this.description = description;
        this.duration = duration;
        this.totalQuestions = totalQuestions;
    }

    public int getExamId() { return examId; }
    public void setExamId(int examId) { this.examId = examId; }

    public String getExamName() { return examName; }
    public void setExamName(String examName) { this.examName = examName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public int getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(int totalQuestions) { this.totalQuestions = totalQuestions; }
}
