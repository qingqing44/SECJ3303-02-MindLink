package com.mindlink.counseling;

import java.util.List;

public class DashboardStats {
    private int totalUsers;
    private int totalAppointments;
    private int pendingFeedback;
    private int totalPosts;

    private List<Integer> ratingCounts;    
    private List<String> last7DaysLabels;   
    private List<Integer> dailyAppointments; 

    public DashboardStats(int totalUsers, int totalAppointments, int pendingFeedback, int totalPosts,
                          List<Integer> ratingCounts, List<String> last7DaysLabels, List<Integer> dailyAppointments) {
        this.totalUsers = totalUsers;
        this.totalAppointments = totalAppointments;
        this.pendingFeedback = pendingFeedback;
        this.totalPosts = totalPosts;
        this.ratingCounts = ratingCounts;
        this.last7DaysLabels = last7DaysLabels;
        this.dailyAppointments = dailyAppointments;
    }

    public int getTotalUsers() { return totalUsers; }
    public int getTotalAppointments() { return totalAppointments; }
    public int getPendingFeedback() { return pendingFeedback; }
    public int getTotalPosts() { return totalPosts; }
    
    public List<Integer> getRatingCounts() { return ratingCounts; }
    public List<String> getLast7DaysLabels() { return last7DaysLabels; }
    public List<Integer> getDailyAppointments() { return dailyAppointments; }

    public String getChartLabels() {
        if (last7DaysLabels == null || last7DaysLabels.isEmpty()) {
            return "[]";
        }
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < last7DaysLabels.size(); i++) {
            sb.append("\"").append(last7DaysLabels.get(i)).append("\"");
            if (i < last7DaysLabels.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("]");
        return sb.toString(); 
    }
}