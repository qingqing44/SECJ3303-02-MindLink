package com.mindlink.admin;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mindlink.module.LearningModule;
import com.mindlink.module.ModuleQuestion;
import com.mindlink.module.ModuleService;

@Controller
@RequestMapping("/admin/modules")
public class AdminModuleController {

    @Autowired
    private ModuleService moduleService;

    // 1. List all modules (for CRUD operations) - Redirect to dashboard
    @GetMapping("")
    public String listModules(Model model) {
        return "redirect:/admin/modules/dashboard";
    }

    // 2. Module Dashboard 
    @GetMapping("/dashboard")
    public String showModuleDashboard(Model model) {
        try {
            List<LearningModule> modules = moduleService.getAllModules();
            model.addAttribute("modules", modules);
            return "admin/module_dashboard";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error loading modules: " + e.getMessage());
            model.addAttribute("modules", new ArrayList<>());
            return "admin/module_dashboard";
        }
    }

    // 3. Module Intro 
    @GetMapping("/intro")
    public String showModuleIntro(@RequestParam(value = "id", required = false) String id, Model model) {
        if (id != null) {
            LearningModule module = moduleService.getModuleById(id);
            if (module != null) {
                model.addAttribute("module", module);
                return "admin/module_intro";
            }
        }
        return "redirect:/admin/modules/dashboard";
    }

    // 4. Show Add Form
    @GetMapping("/add")
    public String showAddForm(Model model) {
        LearningModule module = new LearningModule();
        module.setTitle("");
        module.setDescription("");
        module.setImagePath("");
        model.addAttribute("module", module);
        return "admin/module_form";
    }

    // 5. Show Edit Form
    @GetMapping("/edit")
    public String showEditForm(@RequestParam("id") String id, Model model) {
        LearningModule module = moduleService.getModuleById(id);
        model.addAttribute("module", module);
        return "admin/module_form";
    }

    // 6. Save 
    @PostMapping("/save")
    public String saveModule(@ModelAttribute LearningModule module) {
        moduleService.saveModule(module);
        return "redirect:/admin/modules/dashboard";
    }

    // 7. Delete
    @GetMapping("/delete")
    public String deleteModule(@RequestParam("id") String id) {
        moduleService.deleteModule(id);
        return "redirect:/admin/modules/dashboard";
    }

    // QUESTION MANAGEMENT
    // 8. Add Question 
    @GetMapping("/questions/add")
    public String showAddQuestionForm(@RequestParam("moduleId") int moduleId, Model model) {
        ModuleQuestion question = new ModuleQuestion();
        question.setModuleId(moduleId);
        question.setChapterNumber(1);
        question.setQuestionNumber("1.1");
        question.setQuestionType("PDF");
        model.addAttribute("question", question);
        model.addAttribute("moduleId", moduleId);
        return "admin/question_form";
    }

    // 9. Edit 
    @GetMapping("/questions/edit")
    public String showEditQuestionForm(@RequestParam("id") int questionId, Model model) {
        try {
            ModuleQuestion question = moduleService.getQuestionById(questionId);
            if (question != null) {
                model.addAttribute("question", question);
                model.addAttribute("moduleId", question.getModuleId());
                return "admin/question_form";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error loading question: " + e.getMessage());
        }
        return "redirect:/admin/modules/dashboard";
    }

    // 10. Save 
    @PostMapping("/questions/save")
    public String saveQuestion(@ModelAttribute ModuleQuestion question) {
        moduleService.saveQuestion(question);
        return "redirect:/admin/modules/dashboard";
    }

    // 11. Delete
    @GetMapping("/questions/delete")
    public String deleteQuestion(@RequestParam("id") int questionId) {
        moduleService.deleteQuestion(questionId);
        return "redirect:/admin/modules/dashboard";
    }
}
