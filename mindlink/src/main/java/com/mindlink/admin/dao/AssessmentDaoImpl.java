package com.mindlink.admin.dao;

import com.mindlink.assessment.Assessment;
import com.mindlink.assessment.AssessmentOption;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class AssessmentDaoImpl implements AssessmentDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Assessment> assessmentRowMapper = new RowMapper<Assessment>() {
        @Override
        public Assessment mapRow(ResultSet rs, int rowNum) throws SQLException {
            Assessment assessment = new Assessment();
            assessment.setId(rs.getInt("assessment_id"));
            assessment.setTitle(rs.getString("assessment_title"));
            assessment.setQuestionText(rs.getString("question_text"));
            assessment.setQuestionType(rs.getString("question_type"));
            return assessment;
        }
    };

    private final RowMapper<AssessmentOption> optionRowMapper = new RowMapper<AssessmentOption>() {
        @Override
        public AssessmentOption mapRow(ResultSet rs, int rowNum) throws SQLException {
            AssessmentOption option = new AssessmentOption();
            option.setOptionId(rs.getInt("option_id"));
            option.setAssessmentId(rs.getInt("assessment_id"));
            option.setOptionText(rs.getString("option_text"));
            option.setScoreValue(rs.getInt("score_value"));
            return option;
        }
    };

    @Override
    public List<Assessment> findByTitle(String title) {
        String sql = "SELECT * FROM assessment WHERE assessment_title = ?";
        List<Assessment> assessments = jdbcTemplate.query(sql, assessmentRowMapper, title);

        for (Assessment assessment : assessments) {
            String optionSql = "SELECT * FROM ass_question WHERE assessment_id = ?";
            List<AssessmentOption> options = jdbcTemplate.query(optionSql, optionRowMapper, assessment.getId());
            assessment.setOptions(options);
        }

        return assessments;
    }

    @Override
    public List<Assessment> findAll() {
        String sql = "SELECT * FROM assessment";
        List<Assessment> assessments = jdbcTemplate.query(sql, assessmentRowMapper);
        // Loading options for list view might be heavy if many questions,
        // but user probably wants to see them or at least counting them.
        // For admin list, we can just fetch options too or lazy load.
        // Let's fetch them for now to be safe.
        for (Assessment assessment : assessments) {
            String optionSql = "SELECT * FROM ass_question WHERE assessment_id = ?";
            List<AssessmentOption> options = jdbcTemplate.query(optionSql, optionRowMapper, assessment.getId());
            assessment.setOptions(options);
        }
        return assessments;
    }

    @Override
    public List<Assessment> findByModuleId(int moduleId) {
        String sql = "SELECT * FROM assessment WHERE module_id = ?";
        List<Assessment> assessments = jdbcTemplate.query(sql, assessmentRowMapper, moduleId);
        for (Assessment assessment : assessments) {
            String optionSql = "SELECT * FROM ass_question WHERE assessment_id = ?";
            List<AssessmentOption> options = jdbcTemplate.query(optionSql, optionRowMapper, assessment.getId());
            assessment.setOptions(options);
        }
        return assessments;
    }

    @Override
    public Assessment findById(int id) {
        String sql = "SELECT * FROM assessment WHERE assessment_id = ?";
        List<Assessment> assessments = jdbcTemplate.query(sql, assessmentRowMapper, id);
        if (assessments.isEmpty()) {
            return null;
        }
        Assessment assessment = assessments.get(0);
        String optionSql = "SELECT * FROM ass_question WHERE assessment_id = ?";
        List<AssessmentOption> options = jdbcTemplate.query(optionSql, optionRowMapper, assessment.getId());
        assessment.setOptions(options);
        return assessment;
    }

    @Override
    public void save(Assessment assessment) {
        String sql = "INSERT INTO assessment (assessment_title, question_text, question_type) VALUES (?, ?, ?)";
        org.springframework.jdbc.support.KeyHolder keyHolder = new org.springframework.jdbc.support.GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            java.sql.PreparedStatement ps = connection.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, assessment.getTitle());
            ps.setString(2, assessment.getQuestionText());
            ps.setString(3, assessment.getQuestionType());
            return ps;
        }, keyHolder);

        int assessmentId = keyHolder.getKey().intValue();
        assessment.setId(assessmentId);

        if (assessment.getOptions() != null) {
            for (AssessmentOption option : assessment.getOptions()) {
                String optionSql = "INSERT INTO ass_question (assessment_id, option_text, score_value) VALUES (?, ?, ?)";
                jdbcTemplate.update(optionSql, assessmentId, option.getOptionText(), option.getScoreValue());
            }
        }
    }

    @Override
    public void update(Assessment assessment) {
        String sql = "UPDATE assessment SET assessment_title = ?, question_text = ?, question_type = ? WHERE assessment_id = ?";
        jdbcTemplate.update(sql, assessment.getTitle(), assessment.getQuestionText(), assessment.getQuestionType(),
                assessment.getId());

        // Replace options
        String deleteOptions = "DELETE FROM ass_question WHERE assessment_id = ?";
        jdbcTemplate.update(deleteOptions, assessment.getId());

        if (assessment.getOptions() != null) {
            for (AssessmentOption option : assessment.getOptions()) {
                String optionSql = "INSERT INTO ass_question (assessment_id, option_text, score_value) VALUES (?, ?, ?)";
                jdbcTemplate.update(optionSql, assessment.getId(), option.getOptionText(), option.getScoreValue());
            }
        }
    }

    @Override
    public void delete(int id) {
        // Delete options first (if no cascade)
        String deleteOptions = "DELETE FROM ass_question WHERE assessment_id = ?";
        jdbcTemplate.update(deleteOptions, id);

        String sql = "DELETE FROM assessment WHERE assessment_id = ?";
        jdbcTemplate.update(sql, id);
    }
}
