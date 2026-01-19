package com.mindlink.achievement.dao;

import com.mindlink.achievement.Achievement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository("adminAchievementDao")
public class AchievementDaoImpl implements AchievementDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Achievement> rowMapper = new RowMapper<Achievement>() {
        @Override
        public Achievement mapRow(ResultSet rs, int rowNum) throws SQLException {
            Achievement achievement = new Achievement();
            achievement.setAchievementType(rs.getString("achievement_type"));
            achievement.setTitle(rs.getString("title"));
            achievement.setDescription(rs.getString("description"));
            achievement.setIconPath(rs.getString("icon_path"));
            achievement.setTargetValue(rs.getInt("target_value"));
            return achievement;
        }
    };

    @Override
    public List<Achievement> findAll() {
        String sql = "SELECT * FROM achievement_badges";
        return jdbcTemplate.query(sql, rowMapper);
    }

    @Override
    public Achievement findById(String achievementType) {
        String sql = "SELECT * FROM achievement_badges WHERE achievement_type = ?";
        List<Achievement> list = jdbcTemplate.query(sql, rowMapper, achievementType);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public void save(Achievement achievement) {
        String sql = "INSERT INTO achievement_badges (achievement_type, title, description, icon_path, target_value) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, achievement.getAchievementType(), achievement.getTitle(), achievement.getDescription(),
                achievement.getIconPath(), achievement.getTargetValue());
    }

    @Override
    public void update(Achievement achievement) {
        String sql = "UPDATE achievement_badges SET title = ?, description = ?, icon_path = ?, target_value = ? WHERE achievement_type = ?";
        jdbcTemplate.update(sql, achievement.getTitle(), achievement.getDescription(), achievement.getIconPath(),
                achievement.getTargetValue(), achievement.getAchievementType());
    }

    @Override
    public void delete(String achievementType) {
        String sql = "DELETE FROM achievement_badges WHERE achievement_type = ?";
        jdbcTemplate.update(sql, achievementType);
    }
}
