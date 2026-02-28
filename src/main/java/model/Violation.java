package model;

public class Violation {
    private int violationId;
    private int studentId;
    private int examId;
    private String violationType;
    private String description;
    private String violationDate;

    public Violation() {}

    public Violation(int violationId, int studentId, int examId, String violationType, String description, String violationDate) {
        this.violationId = violationId;
        this.studentId = studentId;
        this.examId = examId;
        this.violationType = violationType;
        this.description = description;
        this.violationDate = violationDate;
    }

    public int getViolationId() { return violationId; }
    public void setViolationId(int violationId) { this.violationId = violationId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getExamId() { return examId; }
    public void setExamId(int examId) { this.examId = examId; }

    public String getViolationType() { return violationType; }
    public void setViolationType(String violationType) { this.violationType = violationType; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getViolationDate() { return violationDate; }
    public void setViolationDate(String violationDate) { this.violationDate = violationDate; }
}
