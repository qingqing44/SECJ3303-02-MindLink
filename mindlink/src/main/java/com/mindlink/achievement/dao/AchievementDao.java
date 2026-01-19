package com.mindlink.achievement.dao;

import com.mindlink.achievement.Achievement;
import java.util.List;

public interface AchievementDao {
    List<Achievement> findAll();

    Achievement findById(String achievementType);

    void save(Achievement achievement);

    void update(Achievement achievement);

    void delete(String achievementType);
}
