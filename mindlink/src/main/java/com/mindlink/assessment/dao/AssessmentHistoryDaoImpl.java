package com.mindlink.assessment.dao;

import com.mindlink.assessment.AssessmentHistory;
import com.mindlink.assessment.Assessment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Date;

@Repository
public class AssessmentHistoryDaoImpl implements AssessmentHistoryDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public int save(AssessmentHistory history) {
        String sql = "INSERT INTO assessment_history (student_id, assessment_title, score, interpretation, completed_at) VALUES (?, ?, ?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            java.sql.PreparedStatement ps = connection.prepareStatement(sql, new String[] { "history_id" });
            ps.setString(1, history.getStudentId());
            ps.setString(2, history.getAssessmentTitle());
            ps.setInt(3, history.getScore());
            ps.setString(4, history.getInterpretation());
            ps.setTimestamp(5, new java.sql.Timestamp(
                    (history.getCompletedAt() != null ? history.getCompletedAt() : new Date()).getTime()));
            return ps;
        }, keyHolder);

        Number key = keyHolder.getKey();
        return (key != null) ? key.intValue() : 0;
    }

    @Override
    public List<AssessmentHistory> findByStudentId(String studentId) {
        String sql = "SELECT * FROM assessment_history WHERE student_id = ? ORDER BY completed_at DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(AssessmentHistory.class), studentId);
    }

    @Override
    public List<AssessmentHistory> findAll() {
        String sql = "SELECT * FROM assessment_history ORDER BY completed_at DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(AssessmentHistory.class));
    }

    @Override
    public void saveAnswers(List<Assessment.AnswerSnapshot> answers) {
        String sql = "INSERT INTO assessment_answers (history_id, question_text, selected_option, score) VALUES (?, ?, ?, ?)";
        for (Assessment.AnswerSnapshot answer : answers) {
            jdbcTemplate.update(sql,
                    answer.getHistoryId(),
                    answer.getQuestionText(),
                    answer.getSelectedOption(),
                    answer.getScore());
        }
    }

    @Override
    public List<Assessment.AnswerSnapshot> findAnswersByHistoryId(int historyId) {
        String sql = "SELECT * FROM assessment_answers WHERE history_id = ? ORDER BY answer_id ASC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Assessment.AnswerSnapshot.class), historyId);
    }
}
