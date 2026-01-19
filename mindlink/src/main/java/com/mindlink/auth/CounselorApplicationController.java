package com.mindlink.auth;

import com.mindlink.usermanagement.model.Counselor;
import com.mindlink.usermanagement.service.UserManagementCounselorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/counselor")
public class CounselorApplicationController {

    @Autowired
    private UserManagementCounselorService counselorService;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/apply")
    public String showApplicationForm() {
        return "auth/counselor_apply";
    }

    @PostMapping("/apply/submit")
    public String submitApplication(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            @RequestParam("certId") String certId,
            @RequestParam("password") String password,
            @RequestParam(value = "location", required = false) String location,
            @RequestParam(value = "education", required = false) String education,
            @RequestParam(value = "university", required = false) String university,
            @RequestParam(value = "languages", required = false) String languages,
            @RequestParam(value = "specialization", required = false) String specialization,
            RedirectAttributes redirectAttributes) {

        try {
            // Check if email already exists
            String checkEmailSql = "SELECT COUNT(*) FROM counselor WHERE email = ?";
            Integer emailCount = jdbcTemplate.queryForObject(checkEmailSql, Integer.class, email);
            if (emailCount != null && emailCount > 0) {
                redirectAttributes.addFlashAttribute("error",
                        "This email is already registered. Please use a different email.");
                return "redirect:/counselor/apply";
            }

            // Generate counselor ID
            String counselorId = generateNextCounselorId();

            // Create counselor object
            Counselor counselor = new Counselor();
            counselor.setCounselorId(counselorId);
            counselor.setName(name);
            counselor.setEmail(email);
            counselor.setPhone(phone);
            counselor.setCertId(certId);
            counselor.setPassword(password);
            counselor.setLocation(location);
            counselor.setEducation(education);
            counselor.setUniversity(university);
            counselor.setLanguages(languages);
            counselor.setSpecialization(specialization);
            counselor.setStatus("pending");

            // Save counselor application
            counselorService.saveCounselor(counselor);

            redirectAttributes.addFlashAttribute("success",
                    "Your application has been submitted successfully! An administrator will review your application and you will be notified once a decision is made.");
            return "redirect:/counselor/apply";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error",
                    "An error occurred while submitting your application. Please try again.");
            return "redirect:/counselor/apply";
        }
    }

    private String generateNextCounselorId() {
        String sql = "SELECT MAX(CAST(SUBSTRING(id, 2) AS UNSIGNED)) FROM counselor WHERE id REGEXP '^C[0-9]+$'";
        try {
            Integer maxNum = jdbcTemplate.queryForObject(sql, Integer.class);
            if (maxNum == null) {
                maxNum = 0;
            }
            int nextNum = maxNum + 1;
            return String.format("C%03d", nextNum);
        } catch (Exception e) {
            return "C001";
        }
    }
}
