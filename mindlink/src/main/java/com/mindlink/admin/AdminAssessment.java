package com.mindlink.admin;

import java.util.ArrayList;
import java.util.List;

public class AdminAssessment {
    private int id;
    private int moduleId;
    private String title; // Maps to 'assessment_title'
    private String questionText;
    private List<Option> options = new ArrayList<>();

    // Standard Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getModuleId() { return moduleId; }
    public void setModuleId(int moduleId) { this.moduleId = moduleId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getQuestionText() { return questionText; }
    public void setQuestionText(String questionText) { this.questionText = questionText; }
    public List<Option> getOptions() { return options; }
    public void setOptions(List<Option> options) { this.options = options; }

    // Required Inner Class for options
    public static class Option {
        private int optionId;
        private int assessmentId;
        private String optionText;
        private int scoreValue;

        public Option() {}
        // Getters and Setters for optionId, assessmentId, optionText, scoreValue...
        public int getOptionId() { return optionId; }
        public void setOptionId(int optionId) { this.optionId = optionId; }
        public int getAssessmentId() { return assessmentId; }
        public void setAssessmentId(int assessmentId) { this.assessmentId = assessmentId; }
        public String getOptionText() { return optionText; }
        public void setOptionText(String optionText) { this.optionText = optionText; }
        public int getScoreValue() { return scoreValue; }
        public void setScoreValue(int scoreValue) { this.scoreValue = scoreValue; }
    }
}