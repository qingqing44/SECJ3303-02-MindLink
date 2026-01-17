package com.mindlink.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

import com.mindlink.admin.dao.AssessmentDao;
import com.mindlink.assessment.Assessment;
import com.mindlink.assessment.AssessmentOption;
import com.mindlink.module.ModuleService;

@Controller
@RequestMapping("/admin/assessment")
public class AdminAssessmentController {

    @Autowired
    private AssessmentDao assessmentDao;

    @Autowired
    private ModuleService moduleService; 

    @GetMapping
    public String listQuestions(Model model) {
        // Redirect to module select page first
        return "redirect:/admin/assessment/select-module";
    }
    
    @GetMapping("/list")
    public String showList(@RequestParam(value = "moduleId", required = false) Integer moduleId, Model model) {
        List<Assessment> questions;
        if (moduleId != null) {
            questions = assessmentDao.findByModuleId(moduleId);
            // Get module info for display
            com.mindlink.module.LearningModule module = moduleService.getModuleById(String.valueOf(moduleId));
            if (module != null) {
                model.addAttribute("selectedModule", module);
            }
        } else {
            questions = assessmentDao.findAll();
        }
        // Convert Assessment to AdminAssessment for the view
        List<AdminAssessment> adminQuestions = convertToAdminAssessment(questions);
        model.addAttribute("questions", adminQuestions);
        model.addAttribute("moduleId", moduleId);
        return "admin/assessment_list";
    }

    @GetMapping("/select-module")
    public String moduleSelect(Model model) {
        try {
            List<com.mindlink.module.LearningModule> modules = moduleService.getAllModules();
            model.addAttribute("modules", modules);
        } catch (Exception e) {
            model.addAttribute("modules", new ArrayList<>());
        }
        return "admin/assessment_module_select";
    }

    @GetMapping("/add")
    public String addQuestionForm(@RequestParam(value = "moduleId", required = false) Integer moduleId, Model model) {
        AdminAssessment assessment = new AdminAssessment();
        if (moduleId != null) {
            assessment.setModuleId(moduleId);
            model.addAttribute("moduleId", moduleId);
        }
        model.addAttribute("assessment", assessment);
        return "admin/assessment_form";
    }

    @PostMapping("/save")
    public String saveQuestion(@ModelAttribute AdminAssessment adminAssessment,
                               @RequestParam(value = "moduleId", required = false) Integer moduleId) {
        // Convert AdminAssessment to Assessment
        Assessment assessment = convertToAssessment(adminAssessment, moduleId);
        assessmentDao.save(assessment);
        if (moduleId != null) {
            return "redirect:/admin/assessment/list?moduleId=" + moduleId;
        }
        return "redirect:/admin/assessment/select-module";
    }

    @GetMapping("/edit")
    public String editQuestionForm(@RequestParam("id") int id, 
                                   @RequestParam(value = "moduleId", required = false) Integer moduleId,
                                   Model model) {
        Assessment assessment = assessmentDao.findById(id);
        AdminAssessment adminAssessment = convertToAdminAssessment(assessment);
        if (moduleId != null) {
            adminAssessment.setModuleId(moduleId);
            model.addAttribute("moduleId", moduleId);
        }
        model.addAttribute("assessment", adminAssessment);
        return "admin/assessment_form";
    }

    @PostMapping("/update")
    public String updateQuestion(@ModelAttribute AdminAssessment adminAssessment,
                                @RequestParam(value = "moduleId", required = false) Integer moduleId) {
        Assessment assessment = convertToAssessment(adminAssessment, moduleId);
        assessment.setId(adminAssessment.getId());
        assessmentDao.update(assessment);
        if (moduleId != null) {
            return "redirect:/admin/assessment/list?moduleId=" + moduleId;
        }
        return "redirect:/admin/assessment/select-module";
    }

    @GetMapping("/delete")
    public String deleteQuestion(@RequestParam("id") int id,
                                @RequestParam(value = "moduleId", required = false) Integer moduleId) {
        assessmentDao.delete(id);
        if (moduleId != null) {
            return "redirect:/admin/assessment/list?moduleId=" + moduleId;
        }
        return "redirect:/admin/assessment/select-module";
    }

    // Helper methods to convert between models
    private AdminAssessment convertToAdminAssessment(Assessment assessment) {
        if (assessment == null) return null;
        
        AdminAssessment adminAssessment = new AdminAssessment();
        adminAssessment.setId(assessment.getId());
        adminAssessment.setTitle(assessment.getTitle());
        adminAssessment.setQuestionText(assessment.getQuestionText());
        
        // Convert AssessmentOption to AdminAssessment.Option
        List<AdminAssessment.Option> options = new ArrayList<>();
        if (assessment.getOptions() != null) {
            for (AssessmentOption ao : assessment.getOptions()) {
                AdminAssessment.Option option = new AdminAssessment.Option();
                option.setOptionId(ao.getOptionId());
                option.setAssessmentId(ao.getAssessmentId());
                option.setOptionText(ao.getOptionText());
                option.setScoreValue(ao.getScoreValue());
                options.add(option);
            }
        }
        adminAssessment.setOptions(options);
        
        return adminAssessment;
    }

    private List<AdminAssessment> convertToAdminAssessment(List<Assessment> assessments) {
        List<AdminAssessment> adminAssessments = new ArrayList<>();
        for (Assessment assessment : assessments) {
            adminAssessments.add(convertToAdminAssessment(assessment));
        }
        return adminAssessments;
    }

    private Assessment convertToAssessment(AdminAssessment adminAssessment, Integer moduleId) {
        if (adminAssessment == null) return null;
        
        Assessment assessment = new Assessment();
        assessment.setId(adminAssessment.getId());
        assessment.setTitle(adminAssessment.getTitle());
        assessment.setQuestionText(adminAssessment.getQuestionText());
        assessment.setQuestionType("multiple_choice");
        
        // Convert AdminAssessment.Option to AssessmentOption
        List<AssessmentOption> options = new ArrayList<>();
        if (adminAssessment.getOptions() != null) {
            for (AdminAssessment.Option o : adminAssessment.getOptions()) {
                AssessmentOption option = new AssessmentOption();
                option.setOptionId(o.getOptionId());
                option.setAssessmentId(o.getAssessmentId());
                option.setOptionText(o.getOptionText());
                option.setScoreValue(o.getScoreValue());
                options.add(option);
            }
        }
        assessment.setOptions(options);
        
        return assessment;
    }
}