package com.mindlink.gamification.dao;

import com.mindlink.gamification.Achievement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class AchievementDaoImpl implements AchievementDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Achievement> badgeMapper = new RowMapper<Achievement>() {
        @Override
        public Achievement mapRow(ResultSet rs, int rowNum) throws SQLException {
            Achievement ach = new Achievement();
            ach.setType(rs.getString("achievement_type"));
            ach.setTitle(rs.getString("title"));
            ach.setDescription(rs.getString("description"));
            ach.setIconPath(rs.getString("icon_path"));
            ach.setTargetValue(rs.getInt("target_value"));
            return ach;
        }
    };

    @Override
    public List<Achievement> getAllBadgeDefinitions() {
        String sql = "SELECT * FROM achievement_badges";
        return jdbcTemplate.query(sql, badgeMapper);
    }

    @Override
    public List<String> getUnlockedAchievementTypes(String studentId) {
        String sql = "SELECT achievement_type FROM student_achievements WHERE student_id = ? AND unlocked_at IS NOT NULL";
        return jdbcTemplate.queryForList(sql, String.class, studentId);
    }

    @Override
    public java.util.Map<String, java.sql.Timestamp> getUnlockedAchievementsMap(String studentId) {
        String sql = "SELECT achievement_type, unlocked_at FROM student_achievements WHERE student_id = ?";
        java.util.Map<String, java.sql.Timestamp> results = new java.util.HashMap<>();
        jdbcTemplate.query(sql, (rs) -> {
            results.put(rs.getString("achievement_type"), rs.getTimestamp("unlocked_at"));
        }, studentId);
        return results;
    }

    @Override
    public void unlockAchievement(String studentId, String type) {
        String sql = "INSERT INTO student_achievements (student_id, achievement_type, unlocked_at) " +
                "VALUES (?, ?, CURRENT_TIMESTAMP) " +
                "ON DUPLICATE KEY UPDATE unlocked_at = IFNULL(unlocked_at, CURRENT_TIMESTAMP)";
        jdbcTemplate.update(sql, studentId, type);
    }

    @Override
    public int getAssessmentCount(String studentId) {
        String sql = "SELECT COUNT(DISTINCT assessment_title) FROM assessment_history WHERE student_id = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, studentId);
        return count != null ? count : 0;
    }

    @Override
    public int getConfirmedAppointmentCount(String studentId) {
        String sql = "SELECT COUNT(*) FROM appointment WHERE student_id = ? AND status = 'Completed'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, studentId);
        return count != null ? count : 0;
    }

    @Override
    public int getForumPostCount(String studentId) {
        // Assuming user_id in forum_post maps to student_id
        String sql = "SELECT COUNT(*) FROM forum_post WHERE user_id = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, studentId);
        return count != null ? count : 0;
    }
}
