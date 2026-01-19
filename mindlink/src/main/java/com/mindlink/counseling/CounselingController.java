package com.mindlink.counseling;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession; 
import java.util.Map; 

@Controller
@RequestMapping("/counseling")
public class CounselingController {

    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private CounselorService counselorService;

    @Autowired
    private SessionFeedbackService sessionFeedbackService;

    // --- 1. HOME PAGE ---
    @GetMapping("/home") 
    public String showCounselingHome(Model model, HttpSession session) { 
        model.addAttribute("appointments", appointmentService.getUpcomingAppointments());
        return "counseling/home"; 
    }

    // --- 2. BOOKING PAGE ---
    @GetMapping("/booking")
    public String showBookingPage(
            @RequestParam(value = "preselected", required = false) String preselected,
            @RequestParam(value = "rescheduleId", required = false) String rescheduleId,
            Model model) {
        
        model.addAttribute("counselors", counselorService.getAllCounselors());
        model.addAttribute("bookedAppointments", appointmentService.getAllAppointments());
        
        if (rescheduleId != null && !rescheduleId.isEmpty()) {
            model.addAttribute("rescheduleId", rescheduleId);
            Appointment existing = appointmentService.getAppointmentById(rescheduleId);
            if (existing != null) {
                model.addAttribute("preselectedName", existing.getCounselorName());
            }
        } else {
            model.addAttribute("preselectedName", preselected); 
        }
        
        return "counseling/booking";
    }

    // --- 3. HANDLE BOOKING SUBMISSION ---
    @SuppressWarnings("unchecked") 
    @PostMapping("/booking/submit")
    public String processBooking(
            @RequestParam(value = "existingId", required = false) String existingId,
            @RequestParam("date") String date,
            @RequestParam("time") String time,
            @RequestParam("counselor") String counselorName, // Renamed to avoid confusion with class name
            @RequestParam(value = "mode", defaultValue = "Online") String mode,
            HttpSession session,
            Model model) {
        
        // 1. Get Student ID from Session
        Object studentObj = session.getAttribute("loggedInStudent");
        String studentId = "S001"; // Default fallback
        
        if (studentObj instanceof Map) {
            Map<String, Object> studentMap = (Map<String, Object>) studentObj;
            studentId = (String) studentMap.get("student_id");
        } 

        // 2. Determine Venue
        String venue;
        if (mode.equalsIgnoreCase("Physical")) {
            venue = "Block B Room 314";
        } else {
            String cleanName = counselorName.toLowerCase().replace(" ", "").replace(".", "");
            venue = "https://utm.webex.com/utm/" + cleanName;
        }

        // 3. Create Appointment Object
        Appointment app = new Appointment();
        app.setStudentId(studentId);
        app.setCounselorName(counselorName);
        app.setDate(date);
        app.setTime(time);
        app.setType(mode);
        app.setVenue(venue);

        // 4. Save or Update
        if (existingId != null && !existingId.isEmpty()) {
            app.setId(existingId);
            app.setStatus("Rescheduled");
            appointmentService.rescheduleAppointment(app); 
        } else {
            app.setStatus("Booked");
            appointmentService.bookAppointment(app); 
        }

        // 5. Success Page Data
        model.addAttribute("bookingId", app.getId()); 
        model.addAttribute("counselorName", counselorName);
        model.addAttribute("sessionType", mode);
        model.addAttribute("venue", venue);
        model.addAttribute("date", date);
        model.addAttribute("time", time);

        return "counseling/booking_success";
    }

    // --- 4. CANCEL ---
    @GetMapping("/booking/cancel")
    public String cancelBooking(@RequestParam("id") String id) {
        appointmentService.deleteAppointment(id);
        return "redirect:/counseling/home";
    }

    // --- 5. BROWSE ---
    @GetMapping("/browse")
    public String showBrowsePage(@RequestParam(value = "search", required = false) String search, Model model) {
        if (search != null && !search.isEmpty()) {
            model.addAttribute("counselors", counselorService.searchCounselors(search));
        } else {
            model.addAttribute("counselors", counselorService.getAllCounselors());
        }
        return "counseling/browse";
    }

    // --- 6. PROFILE ---
    @GetMapping("/counselor")
    public String showCounselorProfile(@RequestParam("id") String id, Model model) {
        // FIX: Removed .orElse(null) because getCounselorById returns the object directly
        Counselor c = counselorService.getCounselorById(id);
        
        if (c == null)
            return "redirect:/counseling/browse";
        
        model.addAttribute("c", c);
        return "counseling/profile";
    }

    // --- 7. HISTORY & FEEDBACK ---
    @GetMapping("/history")
    public String showHistoryPage(Model model) {
        model.addAttribute("appointments", appointmentService.getPastAppointments());
        return "counseling/history";
    }

    @GetMapping("/history/view")
    public String viewAppointment(@RequestParam("id") String id, Model model) {
        
        // 1. Get Appointment Details
        Appointment app = appointmentService.getAppointmentById(id);
        if (app == null) return "redirect:/counseling/history";
        model.addAttribute("app", app);

        // 🟢 2. NEW: Fetch Feedback for this specific appointment
        Feedback fb = sessionFeedbackService.getFeedbackByAppointmentId(id);
        model.addAttribute("feedback", fb); // Pass it to the JSP

        return "counseling/appointment_details";
    }

    @GetMapping("/history/feedback")
    public String showFeedbackForm(@RequestParam("id") String id, Model model) {
        model.addAttribute("bookingId", id);
        return "counseling/submit_feedback";
    }

    @PostMapping("/history/feedback/submit")
    public String processFeedback(@RequestParam("bookingId") String id,
            @RequestParam("category") String category,
            @RequestParam("subject") String subject,
            @RequestParam("message") String message,
            @RequestParam("rating") int rating,
            Model model) {

        Feedback fb = new Feedback(id, category, subject, message, rating);
        sessionFeedbackService.saveFeedback(fb);

        model.addAttribute("success", true);
        model.addAttribute("bookingId", id);
        return "counseling/submit_feedback";
    }

    // --- 8. VIEW DETAILS (Success Page Reuse) ---
    @GetMapping("/view")
    public String viewAppointmentDetails(@RequestParam("id") String id, Model model) {
        Appointment app = appointmentService.getAppointmentById(id);
        if (app == null) return "redirect:/counseling/home";

        model.addAttribute("bookingId", app.getId());
        model.addAttribute("counselorName", app.getCounselorName());
        model.addAttribute("sessionType", app.getType()); 
        model.addAttribute("venue", app.getVenue());
        model.addAttribute("date", app.getDate());
        model.addAttribute("time", app.getTime());

        return "counseling/booking_success";
    }
    
}