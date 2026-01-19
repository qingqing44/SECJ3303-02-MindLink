package com.mindlink.assessment;

public class AssessmentResult {
    private String studentId;
    private String studentName;
    private String assessmentTitle; 
    private int score;
    private String interpretation; 
    private String completedAt;

    public AssessmentResult(String studentId, String studentName, String assessmentTitle, int score, String interpretation, String completedAt) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.assessmentTitle = assessmentTitle;
        this.score = score;
        this.interpretation = interpretation;
        this.completedAt = completedAt;
    }

    // Getters
    public String getStudentId() { return studentId; }
    public String getStudentName() { return studentName; }
    public String getAssessmentTitle() { return assessmentTitle; }
    public int getScore() { return score; }
    public String getInterpretation() { return interpretation; }
    public String getCompletedAt() { return completedAt; }

    public boolean isHighRisk() {
        if (interpretation == null) return false;
        String lower = interpretation.toLowerCase();
        return lower.contains("severe") || lower.contains("high") || lower.contains("extreme");
    }
}
