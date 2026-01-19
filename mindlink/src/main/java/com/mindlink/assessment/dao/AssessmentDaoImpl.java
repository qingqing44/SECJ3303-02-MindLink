package com.mindlink.assessment.dao;

import com.mindlink.assessment.Assessment;
import com.mindlink.assessment.AssessmentOption;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Repository
public class AssessmentDaoImpl implements AssessmentDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Assessment> assessmentRowMapper = new RowMapper<Assessment>() {
        @Override
        public Assessment mapRow(ResultSet rs, int rowNum) throws SQLException {
            Assessment assessment = new Assessment();
            assessment.setId(rs.getInt("assessment_id"));
            assessment.setSetId(rs.getInt("set_id"));
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
        for (Assessment assessment : assessments) {
            String optionSql = "SELECT * FROM ass_question WHERE assessment_id = ?";
            List<AssessmentOption> options = jdbcTemplate.query(optionSql, optionRowMapper, assessment.getId());
            assessment.setOptions(options);
        }
        return assessments;
    }

    @Override
    public List<Assessment> findBySetId(int setId) {
        return findBySetId(setId, null);
    }

    public List<Assessment> findBySetId(int setId, String search) {
        String sql;
        Object[] params;

        if (setId == -1) {
            sql = "SELECT * FROM assessment WHERE set_id IS NULL";
            if (search != null && !search.trim().isEmpty()) {
                sql += " AND question_text LIKE ?";
                params = new Object[] { "%" + search + "%" };
            } else {
                params = new Object[] {};
            }
        } else {
            sql = "SELECT * FROM assessment WHERE set_id = ?";
            if (search != null && !search.trim().isEmpty()) {
                sql += " AND question_text LIKE ?";
                params = new Object[] { setId, "%" + search + "%" };
            } else {
                params = new Object[] { setId };
            }
        }

        List<Assessment> assessments = jdbcTemplate.query(sql, assessmentRowMapper, params);
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
        String sql = "INSERT INTO assessment (set_id, assessment_title, question_text, question_type) VALUES (?, ?, ?, ?)";
        org.springframework.jdbc.support.KeyHolder keyHolder = new org.springframework.jdbc.support.GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            java.sql.PreparedStatement ps = connection.prepareStatement(sql, new String[] { "assessment_id" });
            ps.setInt(1, assessment.getSetId());
            ps.setString(2, assessment.getTitle());
            ps.setString(3, assessment.getQuestionText());
            ps.setString(4, assessment.getQuestionType());
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
        String sql = "UPDATE assessment SET set_id = ?, assessment_title = ?, question_text = ?, question_type = ? WHERE assessment_id = ?";
        jdbcTemplate.update(sql, assessment.getSetId(), assessment.getTitle(), assessment.getQuestionText(),
                assessment.getQuestionType(),
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
        String deleteOptions = "DELETE FROM ass_question WHERE assessment_id = ?";
        jdbcTemplate.update(deleteOptions, id);

        String sql = "DELETE FROM assessment WHERE assessment_id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public List<Map<String, Object>> findAllSets(String search) {
        String sql = "SELECT COALESCE(set_id, -1) as set_id, assessment_title, COUNT(*) as question_count FROM assessment";
        Object[] params = null;
        if (search != null && !search.trim().isEmpty()) {
            sql += " WHERE assessment_title LIKE ?";
            params = new Object[] { "%" + search + "%" };
        }
        sql += " GROUP BY set_id, assessment_title";

        if (params != null) {
            return jdbcTemplate.queryForList(sql, params);
        } else {
            return jdbcTemplate.queryForList(sql);
        }
    }

    @Override
    public void deleteSet(int setId, String title) {
        // Delete all options first
        String deleteOptions = "DELETE FROM ass_question WHERE assessment_id IN (SELECT assessment_id FROM assessment WHERE set_id = ? AND assessment_title = ?)";
        jdbcTemplate.update(deleteOptions, setId, title);

        String deleteQuestions = "DELETE FROM assessment WHERE set_id = ? AND assessment_title = ?";
        jdbcTemplate.update(deleteQuestions, setId, title);
    }

    @Override
    public void updateSetTitle(int setId, String oldTitle, String newTitle) {
        String sql = "UPDATE assessment SET assessment_title = ? WHERE set_id = ?";
        jdbcTemplate.update(sql, newTitle, setId);
    }

    @Override
    public String getSetTitle(int setId) {
        String sql = "SELECT assessment_title FROM assessment WHERE set_id = ? LIMIT 1";
        try {
            return jdbcTemplate.queryForObject(sql, String.class, setId);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public int getNextSetId() {
        String sql = "SELECT MAX(set_id) FROM assessment";
        try {
            Integer maxId = jdbcTemplate.queryForObject(sql, Integer.class);
            return (maxId == null) ? 1 : maxId + 1;
        } catch (Exception e) {
            return 1;
        }
    }
}
