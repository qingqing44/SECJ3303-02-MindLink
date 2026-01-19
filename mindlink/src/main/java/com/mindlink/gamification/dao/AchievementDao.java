package com.mindlink.gamification.dao;

import com.mindlink.gamification.Achievement;
import java.util.List;

public interface AchievementDao {
    List<Achievement> getAllBadgeDefinitions();

    List<String> getUnlockedAchievementTypes(String studentId);

    java.util.Map<String, java.sql.Timestamp> getUnlockedAchievementsMap(String studentId);

    void unlockAchievement(String studentId, String type);

    // For counting specific activities
    int getAssessmentCount(String studentId);

    int getConfirmedAppointmentCount(String studentId);

    int getForumPostCount(String studentId);
}
