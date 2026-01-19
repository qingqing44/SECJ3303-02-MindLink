package com.mindlink.assessment;

import java.util.Date;
import java.util.List;

public class AssessmentHistory {
    private int historyId;
    private String studentId;
    private String assessmentTitle;
    private int score;
    private String interpretation;
    private Date completedAt;

    // Getters and Setters
    public int getHistoryId() {
        return historyId;
    }

    public void setHistoryId(int historyId) {
        this.historyId = historyId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getAssessmentTitle() {
        return assessmentTitle;
    }

    public void setAssessmentTitle(String assessmentTitle) {
        this.assessmentTitle = assessmentTitle;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getInterpretation() {
        return interpretation;
    }

    public void setInterpretation(String interpretation) {
        this.interpretation = interpretation;
    }

    public Date getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(Date completedAt) {
        this.completedAt = completedAt;
    }

    private List<Assessment.AnswerSnapshot> answers;

    public List<Assessment.AnswerSnapshot> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Assessment.AnswerSnapshot> answers) {
        this.answers = answers;
    }
}
