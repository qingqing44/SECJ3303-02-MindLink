package com.mindlink.assistant;

import com.mindlink.assistant.service.DailyTipService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Virtual Assistant - Daily Tips Controller
 * Displays daily mental health tips from database
 */
@Controller
@RequestMapping("/ai")
public class TipsController {

    @Autowired
    private DailyTipService dailyTipService;

    // JSP: WEB-INF/assistant/tips.jsp
    @GetMapping("/tips")
    public String showTips(Model model) {
        // Get 3 random daily tips
        model.addAttribute("randomTips", dailyTipService.getThreeRandomTips());
        
        return "assistant/tips";
    }
}