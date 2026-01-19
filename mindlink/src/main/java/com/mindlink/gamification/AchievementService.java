package com.mindlink.gamification;

import com.mindlink.gamification.dao.AchievementDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AchievementService {

    @Autowired
    private AchievementDao achievementDao;

    public List<Achievement> getStudentAchievements(String studentId) {
        List<Achievement> allBadges = achievementDao.getAllBadgeDefinitions();
        java.util.Map<String, java.sql.Timestamp> unlockedMap = achievementDao.getUnlockedAchievementsMap(studentId);
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMM yyyy");

        // Fetch counts for progress calculation
        int assessmentCount = achievementDao.getAssessmentCount(studentId);
        int sessionCount = achievementDao.getConfirmedAppointmentCount(studentId);
        int forumCount = achievementDao.getForumPostCount(studentId);

        for (Achievement ach : allBadges) {
            java.sql.Timestamp unlockedAt = unlockedMap.get(ach.getType());
            boolean isUnlocked = (unlockedAt != null);
            ach.setUnlocked(isUnlocked);
            if (isUnlocked) {
                ach.setUnlockedDate(sdf.format(unlockedAt));
            }

            // Calculate current progress based on type
            switch (ach.getType()) {
                case "MIND_EXPLORER":
                    ach.setCurrentProgress(assessmentCount);
                    break;
                case "WELLNESS_WARRIOR":
                    ach.setCurrentProgress(sessionCount);
                    break;
                case "INNER_PEACE":
                    ach.setCurrentProgress(calculatePoints(studentId));
                    break;
                case "FORUM_MASTER":
                    ach.setCurrentProgress(forumCount);
                    break;
                default:
                    ach.setCurrentProgress(isUnlocked ? ach.getTargetValue() : 0);
                    break;
            }

            // Auto-unlock if target reached and not yet unlocked
            if (!isUnlocked && ach.getCurrentProgress() >= ach.getTargetValue()) {
                achievementDao.unlockAchievement(studentId, ach.getType());
                ach.setUnlocked(true);
            }

            // UI Polish: If unlocked, ensure progress is at least 100% (targetValue)
            if (ach.isUnlocked() && ach.getCurrentProgress() < ach.getTargetValue()) {
                ach.setCurrentProgress(ach.getTargetValue());
            }
        }

        return allBadges;
    }

    public int calculatePoints(String studentId) {
        // Simple logic for INNER_PEACE points: 500 per assessment, 500 per session, 100
        // per forum post
        int assessmentCount = achievementDao.getAssessmentCount(studentId);
        int sessionCount = achievementDao.getConfirmedAppointmentCount(studentId);
        int forumCount = achievementDao.getForumPostCount(studentId);

        return (assessmentCount * 500) + (sessionCount * 500) + (forumCount * 100);
    }

    public int getAchievedTasksCount(String studentId) {
        return achievementDao.getUnlockedAchievementTypes(studentId).size();
    }
}
