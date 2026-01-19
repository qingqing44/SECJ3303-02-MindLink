package com.mindlink.admin;

import com.mindlink.counseling.SessionFeedbackService;
import com.mindlink.counseling.DashboardStats;
import com.mindlink.counseling.Feedback;
import com.mindlink.forum.model.Forum;
import com.mindlink.forum.model.ForumPost;
import com.mindlink.forum.model.ForumComment;
import com.mindlink.forum.service.ForumService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    // --- SERVICES ---
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private SessionFeedbackService feedbackService;

    @Autowired
    private ForumReportService forumReportService;

    @Autowired
    private ForumCommentReportService forumCommentReportService;

    @Autowired
    private ForumService forumService;

    // Admin Home Page
    @GetMapping("/home")
    public String showAdminHome() {
        return "admin/home";
    }

    // --- ADMIN PROFILE SECTION ---
    @GetMapping("/profile")
    public String showAdminProfile(Model model, HttpSession session) {
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty())
            return "redirect:/admin/login";

        String sql = "SELECT admin_id, name, email, phone, department, role FROM admin WHERE admin_id = ?";
        List<Map<String, Object>> admins = jdbcTemplate.queryForList(sql, adminId);

        if (!admins.isEmpty()) {
            Map<String, Object> data = admins.get(0);
            AdminProfile profile = new AdminProfile(
                    (String) data.get("admin_id"),
                    (String) data.get("name"),
                    (String) data.get("email"),
                    data.get("phone") != null ? (String) data.get("phone") : "",
                    data.get("department") != null ? (String) data.get("department") : "",
                    data.get("role") != null ? (String) data.get("role") : "admin");
            model.addAttribute("p", profile);
        }
        return "admin/profile";
    }

    @GetMapping("/profile/edit")
    public String showEditProfileForm(Model model, HttpSession session) {
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null)
            return "redirect:/admin/login";

        String sql = "SELECT admin_id, name, email, phone, department, role FROM admin WHERE admin_id = ?";
        List<Map<String, Object>> admins = jdbcTemplate.queryForList(sql, adminId);

        if (!admins.isEmpty()) {
            Map<String, Object> data = admins.get(0);
            AdminProfile profile = new AdminProfile(
                    (String) data.get("admin_id"),
                    (String) data.get("name"),
                    (String) data.get("email"),
                    data.get("phone") != null ? (String) data.get("phone") : "",
                    data.get("department") != null ? (String) data.get("department") : "",
                    data.get("role") != null ? (String) data.get("role") : "admin");
            model.addAttribute("p", profile);
        }
        return "admin/profile_edit";
    }

    @PostMapping("/profile/update")
    public String updateAdminProfile(@ModelAttribute AdminProfile profile,
            RedirectAttributes redirectAttributes,
            HttpSession session) {
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null)
            return "redirect:/admin/login";

        try {
            String sql = "UPDATE admin SET name = ?, email = ?, phone = ?, department = ?, updated_at = CURRENT_TIMESTAMP WHERE admin_id = ?";
            jdbcTemplate.update(sql, profile.getName(), profile.getEmail(), profile.getPhone(), profile.getDepartment(),
                    adminId);
            session.setAttribute("adminName", profile.getName());
            redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating profile.");
        }
        return "redirect:/admin/profile";
    }

    // --- FEEDBACK SECTION ---

    // 1. READ ALL FEEDBACK (Split into Pending vs Completed)
    @GetMapping("/feedback")
    public String showFeedbackPage(Model model) {
        // Get all data from service
        List<Feedback> allFeedback = feedbackService.getAllFeedback();

        // Create separate lists
        List<Feedback> pendingList = new ArrayList<>();
        List<Feedback> completedList = new ArrayList<>();

        for (Feedback fb : allFeedback) {
            // 🟢 Now this works because we imported the correct Feedback class
            if (fb.getAdminReply() == null || fb.getAdminReply().trim().isEmpty()) {
                pendingList.add(fb);
            } else {
                completedList.add(fb);
            }
        }

        // Pass lists to JSP
        model.addAttribute("pendingList", pendingList);
        model.addAttribute("completedList", completedList);

        return "admin/feedback_dashboard";
    }

    // 2. SAVE REPLY
    @PostMapping("/feedback/reply")
    public String saveReview(@RequestParam("id") String id,
            @RequestParam("reply") String reply) {
        feedbackService.saveAdminReply(id, reply);
        return "redirect:/admin/feedback";
    }

    // 3. DELETE FEEDBACK
    @GetMapping("/feedback/delete")
    public String deleteFeedback(@RequestParam("id") String id) {
        feedbackService.deleteFeedback(id);
        return "redirect:/admin/feedback";
    }

    // ANALYTICS PAGE
    @GetMapping("/analytics")
    public String showAnalyticsPage(Model model) {

        // 1. BASIC COUNTS
        int totalUsers = getCount("SELECT COUNT(*) FROM student");
        int totalAppointments = getCount("SELECT COUNT(*) FROM appointment");
        int pendingFeedback = getCount("SELECT COUNT(*) FROM feedback WHERE admin_reply IS NULL");
        int totalPosts = getCount("SELECT COUNT(*) FROM forum_post");

        // 2. FETCH RATING COUNTS (1 Star to 5 Stars)
        // Initialize list with 5 zeros: [0, 0, 0, 0, 0]
        List<Integer> ratingCounts = new ArrayList<>(Arrays.asList(0, 0, 0, 0, 0));

        try {
            // Group by rating and count
            String ratingSql = "SELECT rating, COUNT(*) as count FROM feedback GROUP BY rating";
            List<Map<String, Object>> rows = jdbcTemplate.queryForList(ratingSql);

            for (Map<String, Object> row : rows) {
                int rating = ((Number) row.get("rating")).intValue();
                int count = ((Number) row.get("count")).intValue();

                if (rating >= 1 && rating <= 5) {
                    ratingCounts.set(rating - 1, count); // Store at correct index (Rating 1 -> Index 0)
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 3. FETCH ACTIVITY (Last 7 Days)
        List<String> last7DaysLabels = new ArrayList<>();
        List<Integer> dailyAppointments = new ArrayList<>();

        // Date Formatters
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Matches DB format
        SimpleDateFormat labelFormat = new SimpleDateFormat("EEE"); // "Mon", "Tue" for Chart

        // Loop backwards for 7 days
        for (int i = 6; i >= 0; i--) {
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_YEAR, -i);

            String dbDate = sdf.format(cal.getTime());
            String label = labelFormat.format(cal.getTime());

            last7DaysLabels.add(label);

            // Count appointments for this specific date
            String sql = "SELECT COUNT(*) FROM appointment WHERE date = ?";
            int count = 0;
            try {
                count = jdbcTemplate.queryForObject(sql, Integer.class, dbDate);
            } catch (Exception e) {
                count = 0;
            }
            dailyAppointments.add(count);
        }

        // 4. CREATE STATS OBJECT
        DashboardStats stats = new DashboardStats(totalUsers, totalAppointments, pendingFeedback, totalPosts,
                ratingCounts, last7DaysLabels, dailyAppointments);

        model.addAttribute("stats", stats);
        return "admin/analytics";
    }

    private int getCount(String sql) {
        try {
            return jdbcTemplate.queryForObject(sql, Integer.class);
        } catch (Exception e) {
            return 0;
        }
    }

    @GetMapping("/forum/reports")
    public String showForumReports(Model model, HttpSession session) {
        // Check if admin is logged in
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }

        model.addAttribute("reports", forumReportService.getAllReports());
        return "admin/forum_reports";
    }

    @GetMapping("/forum/reports/delete")
    public String deleteReportedPost(@RequestParam("id") String id) {
        forumReportService.deletePost(id);
        return "redirect:/admin/forum/reports";
    }

    @GetMapping("/forum/reports/dismiss")
    public String dismissReport(@RequestParam("id") String id) {
        forumReportService.dismissReport(id);
        return "redirect:/admin/forum/reports";
    }

    // ===== REPORTED COMMENTS =====
    @GetMapping("/forum/comments/reports")
    public String showReportedComments(Model model, HttpSession session) {
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }
        model.addAttribute("reports", forumCommentReportService.getAllReportedComments());
        return "admin/forum_comment_reports";
    }

    @GetMapping("/forum/comments/reports/delete")
    public String deleteReportedComment(@RequestParam("id") String id, HttpSession session) {
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }
        forumCommentReportService.deleteComment(id);
        return "redirect:/admin/forum/comments/reports";
    }

    @GetMapping("/forum/comments/reports/dismiss")
    public String dismissReportedComment(@RequestParam("id") String id, HttpSession session) {
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }
        forumCommentReportService.dismissCommentReport(id);
        return "redirect:/admin/forum/comments/reports";
    }

    @GetMapping("/forum/manage")
    public String manageForums(@RequestParam(value = "search", required = false) String search, Model model,
            HttpSession session) {
        // Check if admin is logged in
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }

        List<Forum> allForums = forumService.getAllForumsIncludingClosed();
        if (allForums == null) {
            allForums = new ArrayList<>();
        }

        // Filter by search query if provided
        if (search != null && !search.trim().isEmpty()) {
            String searchLower = search.toLowerCase().trim();
            List<Forum> filteredForums = new ArrayList<>();
            for (Forum forum : allForums) {
                // Search by ID
                if (String.valueOf(forum.getId()).contains(searchLower)) {
                    filteredForums.add(forum);
                    continue;
                }
                // Search by title/name
                if (forum.getTitle() != null && forum.getTitle().toLowerCase().contains(searchLower)) {
                    filteredForums.add(forum);
                    continue;
                }
            }
            allForums = filteredForums;
        }

        model.addAttribute("forums", allForums);
        model.addAttribute("searchQuery", search != null ? search : "");
        return "admin/forum_manage";
    }

    @GetMapping("/forum/create-form")
    public String showCreateForumForm(Model model, HttpSession session) {
        // Check if admin is logged in
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }

        return "admin/forum_form";
    }

    @PostMapping("/forum/create")
    public String createForum(@RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam(value = "createdBy", defaultValue = "A001") String createdBy,
            HttpSession session) {
        // Check if admin is logged in
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }

        // Use logged-in admin ID if available
        String createdByAdmin = adminId != null ? adminId : createdBy;
        forumService.createForum(title, description, createdByAdmin);
        return "redirect:/admin/forum/manage";
    }

    @GetMapping("/forum/edit-form")
    public String showEditForumForm(@RequestParam("id") int id, Model model, HttpSession session) {
        // Check if admin is logged in
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }

        Forum forum = forumService.getForumById(id);
        model.addAttribute("forum", forum);
        return "admin/forum_form";
    }

    @PostMapping("/forum/update")
    public String updateForum(@RequestParam("id") int id,
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            HttpSession session) {
        // Check if admin is logged in
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }

        forumService.updateForum(id, title, description);
        return "redirect:/admin/forum/manage";
    }

    @GetMapping("/forum/delete")
    public String deleteForum(@RequestParam("id") int id, HttpSession session) {
        // Check if admin is logged in
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }

        forumService.deleteForum(id);
        return "redirect:/admin/forum/manage";
    }

    @GetMapping("/forum/detail")
    public String viewForumDetail(@RequestParam("id") int id, Model model, HttpSession session) {
        // Check if admin is logged in
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }

        Forum forum = forumService.getForumById(id);
        if (forum == null) {
            // Forum not found, redirect to manage page
            return "redirect:/admin/forum/manage";
        }

        model.addAttribute("forum", forum);

        List<ForumPost> posts = forumService.getPostsByForumId(id);
        if (posts == null) {
            posts = new ArrayList<>();
        }
        model.addAttribute("posts", posts);
        model.addAttribute("postCount", forumService.getPostCount(id));

        return "admin/forum_detail";
    }

    @GetMapping("/forum/posts")
    public String viewAllPosts(@RequestParam(value = "forumId", required = false) Integer forumId,
            @RequestParam(value = "search", required = false) String search,
            Model model, HttpSession session) {
        // Check if admin is logged in
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }

        List<ForumPost> posts;
        Forum forum = null;

        if (forumId != null) {
            // Get specific forum and its posts
            forum = forumService.getForumById(forumId);
            posts = forumService.getPostsByForumId(forumId);
            if (posts == null) {
                posts = new ArrayList<>();
            }
            model.addAttribute("forum", forum);
        } else {
            // Get all posts from all forums
            List<ForumPost> allPosts = new ArrayList<>();
            List<Forum> forums = forumService.getAllForums();
            if (forums != null) {
                for (Forum f : forums) {
                    List<ForumPost> forumPosts = forumService.getPostsByForumId(f.getId());
                    if (forumPosts != null) {
                        allPosts.addAll(forumPosts);
                    }
                }
            }
            posts = allPosts;
        }

        // Filter by search query if provided
        if (search != null && !search.trim().isEmpty()) {
            String searchTerm = search.trim();
            List<ForumPost> filteredPosts = new ArrayList<>();

            // Check if search term is a number (for exact ID match)
            boolean isNumeric = searchTerm.matches("\\d+");

            for (ForumPost post : posts) {
                if (isNumeric) {
                    // Exact ID match only
                    if (post.getId() == Integer.parseInt(searchTerm)) {
                        filteredPosts.add(post);
                    }
                } else {
                    // Search by content (case-insensitive)
                    String content = post.getContent() != null ? post.getContent().toLowerCase() : "";
                    if (content.contains(searchTerm.toLowerCase())) {
                        filteredPosts.add(post);
                    }
                }
            }
            posts = filteredPosts;
        }

        model.addAttribute("posts", posts);

        // Fetch comments for each post
        Map<Integer, List<ForumComment>> commentsMap = new HashMap<>();
        for (ForumPost post : posts) {
            List<ForumComment> comments = forumService.getCommentsByPostId(post.getId());
            if (comments == null) {
                comments = new ArrayList<>();
            }
            commentsMap.put(post.getId(), comments);
        }
        model.addAttribute("commentsMap", commentsMap);

        List<Forum> forums = forumService.getAllForums();
        if (forums == null) {
            forums = new ArrayList<>();
        }
        model.addAttribute("forums", forums);
        model.addAttribute("searchQuery", search != null ? search : "");
        model.addAttribute("forumIdParam", forumId);

        return "admin/forum_posts";
    }

    @GetMapping("/forum/posts/delete")
    public String deletePost(@RequestParam("id") int postId,
            @RequestParam(value = "forumId", required = false) Integer forumId,
            HttpSession session) {
        // Check if admin is logged in
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }

        forumService.deletePost(postId);

        // Redirect back to the same forum's posts if forumId was provided
        if (forumId != null) {
            return "redirect:/admin/forum/posts?forumId=" + forumId;
        }
        return "redirect:/admin/forum/posts";
    }

    @GetMapping("/forum/comments/delete")
    public String deleteComment(@RequestParam("id") int commentId,
            @RequestParam(value = "forumId", required = false) Integer forumId,
            HttpSession session) {
        // Check if admin is logged in
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null || adminId.isEmpty()) {
            return "redirect:/admin/login";
        }

        forumService.deleteComment(commentId);

        // Redirect back to the same forum's posts if forumId was provided
        if (forumId != null) {
            return "redirect:/admin/forum/posts?forumId=" + forumId;
        }
        return "redirect:/admin/forum/posts";
    }
}