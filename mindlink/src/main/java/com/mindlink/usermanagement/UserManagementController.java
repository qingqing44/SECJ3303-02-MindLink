package com.mindlink.usermanagement;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mindlink.usermanagement.model.Student;
import com.mindlink.usermanagement.service.StudentService;

@Controller
@RequestMapping("/admin/user-management")
public class UserManagementController {

    @Autowired
    private StudentService studentService;

    // Main user management dashboard 
    @GetMapping
    public String index() {
        return "redirect:/admin/user-management/students";
    }

    // ========== STUDENT MANAGEMENT ==========

    // List all students
    @GetMapping("/students")
    public String listStudents(@RequestParam(value = "search", required = false) String search, Model model) {
        List<Student> students;
        if (search != null && !search.trim().isEmpty()) {
            students = studentService.searchStudents(search);
        } else {
            students = studentService.getAllStudents();
        }
        model.addAttribute("students", students);
        model.addAttribute("searchQuery", search);
        return "admin/userCRUD/student-list";
    }

    // List pending students for approval
    @GetMapping("/students/pending")
    public String listPendingStudents(Model model) {
        List<Student> pendingStudents = studentService.getPendingStudents();
        model.addAttribute("students", pendingStudents);
        return "admin/userCRUD/student-approval-list";
    }

    // Approve student
    @PostMapping("/students/approve/{id}")
    public String approveStudent(@PathVariable String id, RedirectAttributes redirectAttributes) {
        try {
            studentService.approveStudent(id);
            redirectAttributes.addFlashAttribute("success", "Student " + id + " approved successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error approving student: " + e.getMessage());
        }
        return "redirect:/admin/user-management/students/pending";
    }

    // Show form for new student
    @GetMapping("/students/new")
    public String showNewStudentForm(Model model) {
        model.addAttribute("student", new Student());
        return "admin/userCRUD/student-form";
    }

    // Show form for editing student
    @GetMapping("/students/edit/{id}")
    public String showEditStudentForm(@PathVariable String id, Model model, RedirectAttributes redirectAttributes) {
        return studentService.getStudentById(id)
                .map(student -> {
                    model.addAttribute("student", student);
                    return "admin/userCRUD/student-form";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Student not found");
                    return "redirect:/admin/user-management/students";
                });
    }

    // Save or update student
    @PostMapping("/students/save")
    public String saveStudent(@ModelAttribute Student student, RedirectAttributes redirectAttributes) {
        try {
            // Set timestamps
            if (student.getStudentId() == null || student.getStudentId().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Student ID is required.");
                return "redirect:/admin/user-management/students/new";
            } else {
                // Existing student
                studentService.getStudentById(student.getStudentId())
                        .ifPresent(existing -> student.setCreatedAt(existing.getCreatedAt()));
            }
            student.setUpdatedAt(LocalDateTime.now());

            studentService.saveStudent(student);
            redirectAttributes.addFlashAttribute("success",
                    student.getStudentId() != null && !student.getStudentId().isEmpty()
                            ? "Student updated successfully"
                            : "Student created successfully");
        } catch (DataIntegrityViolationException e) {
            redirectAttributes.addFlashAttribute("error",
                    "Student ID already exists. Please use a different Student ID.");
            return "redirect:/admin/user-management/students/new";
        } catch (Exception e) {
            String id = student.getStudentId();
            if (id == null || id.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Error saving student: " + e.getMessage());
                return "redirect:/admin/user-management/students/new";
            }
            redirectAttributes.addFlashAttribute("error", "Error saving student: " + e.getMessage());
        }
        return "redirect:/admin/user-management/students";
    }

    // Delete student
    @GetMapping("/students/delete/{id}")
    public String deleteStudent(@PathVariable String id, RedirectAttributes redirectAttributes) {
        try {
            studentService.deleteStudent(id);
            redirectAttributes.addFlashAttribute("success", "Student deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting student: " + e.getMessage());
        }
        return "redirect:/admin/user-management/students";
    }
}
