package com.mindlink.assessment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

//student view assessment
import com.mindlink.assessment.dao.AssessmentHistoryDao;
import com.mindlink.assessment.dao.AssessmentDao;

@Controller
@RequestMapping("/assessment")
public class AssessmentController {

    @Autowired
    private AssessmentDao assessmentDao;

    @Autowired
    private AssessmentHistoryDao historyDao;

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
        model.addAttribute("modules", assessmentTitles);
        return "assessment/dashboard";
    }

    @GetMapping("/questions")
    public String showQuestions(@RequestParam("title") String title,
            @RequestParam(value = "page", defaultValue = "1") int page,
            HttpSession session, Model model) {
        List<Assessment> allQuestions = assessmentDao.findByTitle(title);

        int pageSize = 4;
        int totalQuestions = allQuestions.size();
        int totalPages = (int) Math.ceil((double) totalQuestions / pageSize);

        // Clamp page
        if (page < 1)
            page = 1;
        if (page > totalPages && totalPages > 0)
            page = totalPages;

        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalQuestions);

        List<Assessment> pageQuestions = (start < totalQuestions) ? allQuestions.subList(start, end)
                : java.util.Collections.emptyList();

        // Initialize score on first page
        if (page == 1) {
            session.setAttribute("runningScore", 0);
        }

        model.addAttribute("questions", pageQuestions);
        model.addAttribute("title", title);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "assessment/question";
    }

    @PostMapping("/submit")
    public String submitAssessment(HttpServletRequest request, HttpSession session) {
        String title = request.getParameter("title");
        int currentPage = Integer.parseInt(request.getParameter("currentPage"));
        int totalPages = Integer.parseInt(request.getParameter("totalPages"));

        Integer runningScore = (Integer) session.getAttribute("runningScore");
        if (runningScore == null)
            runningScore = 0;

        @SuppressWarnings("unchecked")
        java.util.List<Assessment.AnswerSnapshot> sessionAnswers = (java.util.List<Assessment.AnswerSnapshot>) session
                .getAttribute("sessionAnswers");
        if (sessionAnswers == null)
            sessionAnswers = new java.util.ArrayList<>();

        Map<String, String[]> parameterMap = request.getParameterMap();
        int pageScore = 0;

        for (String paramName : parameterMap.keySet()) {
            if (paramName.startsWith("qa_")) {
                String idStr = paramName.substring(3);
                String questionText = request.getParameter("qt_" + idStr);
                String ansValue = request.getParameter(paramName); // "OptionText|Score"

                if (ansValue != null && ansValue.contains("|")) {
                    String[] parts = ansValue.split("\\|");
                    String optionText = parts[0];
                    int score = Integer.parseInt(parts[1]);

                    Assessment.AnswerSnapshot snapshot = new Assessment.AnswerSnapshot();
                    snapshot.setQuestionText(questionText);
                    snapshot.setSelectedOption(optionText);
                    snapshot.setScore(score);
                    sessionAnswers.add(snapshot);

                    pageScore += score;
                }
            }
        }

        runningScore += pageScore;
        session.setAttribute("runningScore", runningScore);
        session.setAttribute("sessionAnswers", sessionAnswers);

        if (currentPage < totalPages) {
            return "redirect:/assessment/questions?title=" + title + "&page=" + (currentPage + 1);
        }

        // Final submission
        int totalScore = runningScore;
        session.setAttribute("assessmentScore", totalScore);

        String interpretation;
        String suggestionTitle;
        List<String> suggestions;

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

        session.setAttribute("interpretation", interpretation);
        session.setAttribute("suggestionTitle", suggestionTitle);
        session.setAttribute("suggestions", suggestions);

        try {
            @SuppressWarnings("unchecked")
            Map<String, Object> loggedInStudent = (Map<String, Object>) session.getAttribute("loggedInStudent");
            if (loggedInStudent != null) {
                AssessmentHistory history = new AssessmentHistory();
                history.setStudentId((String) loggedInStudent.get("student_id"));
                history.setAssessmentTitle(title);
                history.setScore(totalScore);
                history.setInterpretation(interpretation);

                int historyId = historyDao.save(history);

                // Link answers to historyId and save
                for (Assessment.AnswerSnapshot ans : sessionAnswers) {
                    ans.setHistoryId(historyId);
                }
                historyDao.saveAnswers(sessionAnswers);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Clear session data
        session.removeAttribute("runningScore");
        session.removeAttribute("sessionAnswers");

        return "redirect:/assessment/loading";
    }

    @GetMapping("/history")
    public String showHistory(HttpSession session, Model model) {
        @SuppressWarnings("unchecked")
        Map<String, Object> loggedInStudent = (Map<String, Object>) session.getAttribute("loggedInStudent");
        if (loggedInStudent == null)
            return "redirect:/login";

        String studentId = (String) loggedInStudent.get("student_id");
        List<AssessmentHistory> historyList = historyDao.findByStudentId(studentId);

        // Populate answers for each history item
        for (AssessmentHistory h : historyList) {
            h.setAnswers(historyDao.findAnswersByHistoryId(h.getHistoryId()));
        }

        model.addAttribute("historyList", historyList);
        return "assessment/history";
    }

    @GetMapping("/admin/history")
    public String showAllHistory(HttpSession session, Model model) {
        // Just redirect to counselor home or similar if team is doing this,
        // for now let's keep it but point to a generic place or fetch details too.
        if (session.getAttribute("loggedInCounselor") == null && session.getAttribute("adminId") == null) {
            return "redirect:/login";
        }
        List<AssessmentHistory> historyList = historyDao.findAll();
        for (AssessmentHistory h : historyList) {
            h.setAnswers(historyDao.findAnswersByHistoryId(h.getHistoryId()));
        }
        model.addAttribute("historyList", historyList);
        return "assessment/history"; // Reuse student view for now if admin_history is gone
    }

    @GetMapping("/loading")
    public String showLoading() {
        return "assessment/loading";
    }

    @GetMapping("/result")
    public String showResult(HttpSession session, Model model) {
        Integer score = (Integer) session.getAttribute("assessmentScore");
        if (score == null) {
            return "redirect:/assessment";
        }

        model.addAttribute("score", score);
        model.addAttribute("interpretation", session.getAttribute("interpretation"));
        model.addAttribute("suggestionTitle", session.getAttribute("suggestionTitle"));
        model.addAttribute("suggestions", session.getAttribute("suggestions"));

        return "assessment/result";
    }
}