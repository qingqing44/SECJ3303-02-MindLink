package com.mindlink.counselor;

import com.mindlink.counseling.Appointment;
import com.mindlink.counseling.AppointmentService; 
import com.mindlink.counseling.CounselorService; 
import com.mindlink.counseling.Counselor; 
import com.mindlink.counseling.SessionFeedbackService;
import com.mindlink.counseling.Feedback;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession; 
import org.springframework.web.multipart.MultipartFile;
import java.nio.file.*;
import java.io.IOException;
import java.util.UUID;

@Controller
@RequestMapping("/counselor") 
public class CounselorController {

    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private CounselorService counselorService;

    @Autowired
    private SessionFeedbackService sessionFeedbackService;

    // --- 1. DASHBOARD ---
    @GetMapping({"/home", "/dashboard"})
    public String showDashboard(HttpSession session, Model model) {
        Counselor loggedIn = (Counselor) session.getAttribute("loggedInCounselor");
        if (loggedIn == null) {
            return "redirect:/login";
        }

        model.addAttribute("appointments", 
            appointmentService.getAppointmentsForCounselor(loggedIn.getName(), null, null));

        return "counselor/home"; 
    }

    // --- 2. APPOINTMENTS PAGE ---
    @GetMapping("/appointments")
    public String showAppointments(
            @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "status", required = false) String status,
            HttpSession session, 
            Model model) {
        
        Counselor loggedIn = (Counselor) session.getAttribute("loggedInCounselor");
        if (loggedIn == null) {
            return "redirect:/login";
        }

        model.addAttribute("appointments", 
            appointmentService.getAppointmentsForCounselor(loggedIn.getName(), search, status));

        model.addAttribute("currentSearch", search);
        model.addAttribute("currentStatus", status);

        return "counselor/appointments"; 
    }

    // --- 3. VIEW PROFILE PAGE ---
    @GetMapping("/profile")
    public String showProfile(HttpSession session) {
        if (session.getAttribute("loggedInCounselor") == null) {
            return "redirect:/login";
        }
        return "counselor/profile"; 
    }

    // --- 4. HANDLE UPDATE PROFILE (FIXED) ---
    @PostMapping("/updateProfile")
    public String updateProfile(@ModelAttribute Counselor formData, // This only has fields from the form
                                @RequestParam("imageFile") MultipartFile imageFile,
                                @RequestParam(value = "existingImage", required = false) String existingImage,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        try {
            Counselor existingCounselor = counselorService.getCounselorById(formData.getId()); 
            
            if (existingCounselor == null) {
                throw new RuntimeException("Counselor not found in database");
            }

            existingCounselor.setName(formData.getName());
            existingCounselor.setEmail(formData.getEmail());
            existingCounselor.setPassword(formData.getPassword());
            existingCounselor.setLocation(formData.getLocation());
            existingCounselor.setUniversity(formData.getUniversity());
            existingCounselor.setEducation(formData.getEducation());
            existingCounselor.setLanguages(formData.getLanguages());
            existingCounselor.setQuote(formData.getQuote());
            existingCounselor.setBio(formData.getBio());

            if (!imageFile.isEmpty()) {
                String uploadDir = "src/main/webapp/images/uploads/"; 
                String fileName = UUID.randomUUID().toString() + "_" + imageFile.getOriginalFilename();
                Path uploadPath = Paths.get(uploadDir);

                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                try (var inputStream = imageFile.getInputStream()) {
                    Files.copy(inputStream, uploadPath.resolve(fileName), StandardCopyOption.REPLACE_EXISTING);
                }

                existingCounselor.setImageUrl("/images/uploads/" + fileName);
            } else {
                // If no new image, ensure we keep the old one (which is already in existingCounselor)
                // No action needed here, existingCounselor.imageUrl is already set from DB
            }

            // 🟢 STEP 4: Save the MERGED object
            counselorService.updateCounselor(existingCounselor);
            
            // 🟢 STEP 5: Update the Session with the FULL object
            session.setAttribute("loggedInCounselor", existingCounselor);
            
            return "redirect:/counselor/profile?success=true";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error saving profile: " + e.getMessage());
            return "redirect:/counselor/profile";
        }
    }

    // --- 5. VIEW APPOINTMENT DETAILS ---
    @GetMapping("/appointment")
    public String showAppointmentDetails(@RequestParam("id") String id, HttpSession session, Model model) {
        if (session.getAttribute("loggedInCounselor") == null) {
            return "redirect:/login";
        }

        Appointment appointment = appointmentService.getAppointmentById(id);
        if (appointment == null) {
            return "redirect:/counselor/appointments";
        }

        model.addAttribute("appointment", appointment);

        Feedback feedback = sessionFeedbackService.getFeedbackByAppointmentId(id);
        model.addAttribute("feedback", feedback);

        return "counselor/appointment_details"; 
    }

    // --- 6. ADD NOTES & COMPLETING SESSION ---
    @PostMapping("/appointment/update")
    public String updateAppointmentNotes(
            @RequestParam("id") String id,
            @RequestParam("notes") String notes,
            @RequestParam(value = "action", required = false) String action,
            RedirectAttributes redirectAttributes) {
        
        boolean isComplete = "complete".equals(action);
        
        appointmentService.updateSessionNotes(id, notes, isComplete);
        
        if (isComplete) {
            redirectAttributes.addFlashAttribute("message", "Session completed successfully!");
            return "redirect:/counselor/appointments"; 
        } else {
            redirectAttributes.addFlashAttribute("message", "Notes saved successfully.");
            return "redirect:/counselor/appointment?id=" + id; 
        }
    }
}