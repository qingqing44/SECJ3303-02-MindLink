package com.mindlink.gamification;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/gamification")
public class GamificationController {

    @Autowired
    private AchievementService achievementService;

    // 1. Gamification Dashboard (The page in your screenshot)
    @GetMapping("")
    public String showDashboard() {
        return "gamification/dashboard"; // Looks for WEB-INF/gamification/dashboard.jsp
    }

    // Placeholders for the buttons
    @GetMapping("/achievements")
    public String showAchievements(HttpSession session, Model model) {
        Object studentObj = session.getAttribute("loggedInStudent");
        if (!(studentObj instanceof java.util.Map)) {
            return "redirect:/login";
        }

        java.util.Map<String, Object> studentMap = (java.util.Map<String, Object>) studentObj;
        String studentId = (String) studentMap.get("student_id");
        if (studentId == null)
            return "redirect:/login";

        List<Achievement> achievements = achievementService.getStudentAchievements(studentId);
        model.addAttribute("achievements", achievements);

        return "gamification/achievements";
    }

    @GetMapping("/activities")
    public String showActivities(HttpSession session, Model model) {
        Object studentObj = session.getAttribute("loggedInStudent");
        if (!(studentObj instanceof java.util.Map)) {
            return "redirect:/login";
        }

        java.util.Map<String, Object> studentMap = (java.util.Map<String, Object>) studentObj;
        String studentId = (String) studentMap.get("student_id");
        if (studentId == null)
            return "redirect:/login";

        List<Achievement> achievements = achievementService.getStudentAchievements(studentId);

        // Sort: Locked on top, Unlocked at bottom
        achievements.sort((a1, a2) -> Boolean.compare(a1.isUnlocked(), a2.isUnlocked()));

        model.addAttribute("achievements", achievements);
        model.addAttribute("totalPoints", achievementService.calculatePoints(studentId));
        model.addAttribute("achievedCount", achievementService.getAchievedTasksCount(studentId));

        return "gamification/activities";
    }
}