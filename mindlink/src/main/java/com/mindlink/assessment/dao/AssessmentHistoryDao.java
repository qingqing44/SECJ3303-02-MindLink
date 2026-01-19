package com.mindlink.assessment.dao;

import com.mindlink.assessment.AssessmentHistory;
import com.mindlink.assessment.Assessment;
import java.util.List;

public interface AssessmentHistoryDao {
    int save(AssessmentHistory history);

    List<AssessmentHistory> findByStudentId(String studentId);

    List<AssessmentHistory> findAll(); // For counselor view

    // Detailed answers
    void saveAnswers(List<Assessment.AnswerSnapshot> answers);

    List<Assessment.AnswerSnapshot> findAnswersByHistoryId(int historyId);
}
