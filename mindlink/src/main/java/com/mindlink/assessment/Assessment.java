package com.mindlink.assessment;

import java.util.ArrayList;
import java.util.List;

public class Assessment {
    private int id;
    private int setId;
    private String title;
    private String questionText;
    private String questionType;
    private List<AssessmentOption> options = new ArrayList<>();

    public Assessment() {
    }

    public Assessment(int id, int setId, String title, String questionText, String questionType) {
        this.id = id;
        this.setId = setId;
        this.title = title;
        this.questionText = questionText;
        this.questionType = questionType;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSetId() {
        return setId;
    }

    public void setSetId(int setId) {
        this.setId = setId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public String getQuestionType() {
        return questionType;
    }

    public void setQuestionType(String questionType) {
        this.questionType = questionType;
    }

    public List<AssessmentOption> getOptions() {
        return options;
    }

    public void setOptions(List<AssessmentOption> options) {
        this.options = options;
    }

    // Static nested class for detailed history answers
    public static class AnswerSnapshot {
        private int answerId;
        private int historyId;
        private String questionText;
        private String selectedOption;
        private int score;

        public AnswerSnapshot() {
        }

        public int getAnswerId() {
            return answerId;
        }

        public void setAnswerId(int answerId) {
            this.answerId = answerId;
        }

        public int getHistoryId() {
            return historyId;
        }

        public void setHistoryId(int historyId) {
            this.historyId = historyId;
        }

        public String getQuestionText() {
            return questionText;
        }

        public void setQuestionText(String questionText) {
            this.questionText = questionText;
        }

        public String getSelectedOption() {
            return selectedOption;
        }

        public void setSelectedOption(String selectedOption) {
            this.selectedOption = selectedOption;
        }

        public int getScore() {
            return score;
        }

        public void setScore(int score) {
            this.score = score;
        }
    }
}
