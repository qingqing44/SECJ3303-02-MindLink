package com.mindlink.assessment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

//student view assessment
import com.mindlink.admin.dao.AssessmentDao;

@Controller

@RequestMapping("/assessment")
public class AssessmentController {

    @Autowired
    private AssessmentDao assessmentDao;

    @GetMapping
    public String dashboard() {
        return "assessment/welcome";
    }

    @GetMapping("/select-module")
    public String moduleSelect(Model model) {
        // Fetch distinct assessment titles for selection
        List<Assessment> allAssessments = assessmentDao.findAll();
        List<String> assessmentTitles = allAssessments.stream()
            .map(Assessment::getTitle)
            .distinct()
            .collect(java.util.stream.Collectors.toList());
        model.addAttribute("assessmentTitles", assessmentTitles);
        return "assessment/dashboard";
    }

    @GetMapping("/questions")
    public String showQuestions(@RequestParam("title") String title, Model model) {
        List<Assessment> questions = assessmentDao.findByTitle(title);
        model.addAttribute("questions", questions);
        model.addAttribute("title", title);
        return "assessment/question";
    }

    @PostMapping("/submit")
    public String submitAssessment(HttpServletRequest request, Model model) {
        int totalScore = 0;
        Map<String, String[]> parameterMap = request.getParameterMap();

        for (String paramName : parameterMap.keySet()) {
            if (paramName.startsWith("q_")) {
                try {
                    String value = request.getParameter(paramName);
                    totalScore += Integer.parseInt(value);
                } catch (NumberFormatException e) {
                    // Ignore invalid values
                }
            }
        }

        model.addAttribute("score", totalScore);

        // Simple interpretation logic
        String interpretation;
        String suggestionTitle;
        List<String> suggestions;

        // You might want to refine this logic based on max possible score
        if (totalScore < 10) {
            interpretation = "Your mental health seems stable!";
            suggestionTitle = "Great Job!";
            suggestions = List.of("Keep up your healthy habits", "Share your positivity with others");
        } else if (totalScore < 20) {
            interpretation = "You might be experiencing some stress.";
            suggestionTitle = "Take Care!";
            suggestions = List.of("Take short breaks", "Practice deep breathing", "Talk to a friend");
        } else {
            interpretation = "Your mental health needs attention.";
            suggestionTitle = "Oh No!";
            suggestions = List.of("Eat Healthy Food", "Get More Sleep", "Consider speaking to a counselor");
        }

        model.addAttribute("interpretation", interpretation);
        model.addAttribute("suggestionTitle", suggestionTitle);
        model.addAttribute("suggestions", suggestions);

        return "assessment/result";
    }
}