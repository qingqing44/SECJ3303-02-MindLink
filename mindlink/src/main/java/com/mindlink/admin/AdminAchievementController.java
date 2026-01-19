package com.mindlink.admin;

import com.mindlink.achievement.Achievement;
import com.mindlink.achievement.dao.AchievementDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/achievements")
public class AdminAchievementController {

    @Autowired
    private AchievementDao achievementDao;

    @GetMapping
    public String listAchievements(Model model) {
        List<Achievement> achievements = achievementDao.findAll();
        model.addAttribute("achievements", achievements);
        return "admin/achievement_list";
    }

    @GetMapping("/add")
    public String addForm(Model model) {
        model.addAttribute("achievement", new Achievement());
        model.addAttribute("isEdit", false);
        return "admin/achievement_form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute Achievement achievement) {
        achievementDao.save(achievement);
        return "redirect:/admin/achievements";
    }

    @GetMapping("/edit")
    public String editForm(@RequestParam("type") String type, Model model) {
        Achievement achievement = achievementDao.findById(type);
        model.addAttribute("achievement", achievement);
        model.addAttribute("isEdit", true);
        return "admin/achievement_form";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute Achievement achievement) {
        achievementDao.update(achievement);
        return "redirect:/admin/achievements";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("type") String type) {
        achievementDao.delete(type);
        return "redirect:/admin/achievements";
    }
}
