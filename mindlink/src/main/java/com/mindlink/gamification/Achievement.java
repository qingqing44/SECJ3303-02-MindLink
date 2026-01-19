package com.mindlink.gamification;

public class Achievement {
    private String title;
    private String description;
    private String iconPath;
    private boolean unlocked;
    private int currentProgress;
    private int targetValue;
    private String unlockedDate;
    private String type; // The key (e.g., MIND_EXPLORER)

    public Achievement() {
    }

    public Achievement(String title, String description, String iconPath, boolean unlocked, int currentProgress,
            int targetValue) {
        this.title = title;
        this.description = description;
        this.iconPath = iconPath;
        this.unlocked = unlocked;
        this.currentProgress = currentProgress;
        this.targetValue = targetValue;
    }

    // Getters and Setters
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getIconPath() {
        return iconPath;
    }

    public void setIconPath(String iconPath) {
        this.iconPath = iconPath;
    }

    public boolean isUnlocked() {
        return unlocked;
    }

    public void setUnlocked(boolean unlocked) {
        this.unlocked = unlocked;
    }

    public int getCurrentProgress() {
        return currentProgress;
    }

    public void setCurrentProgress(int currentProgress) {
        this.currentProgress = currentProgress;
    }

    // Helper for UI to get capped progress
    public int getCappedProgress() {
        return Math.min(currentProgress, targetValue);
    }

    public int getTargetValue() {
        return targetValue;
    }

    public void setTargetValue(int targetValue) {
        this.targetValue = targetValue;
    }

    public String getUnlockedDate() {
        return unlockedDate;
    }

    public void setUnlockedDate(String unlockedDate) {
        this.unlockedDate = unlockedDate;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getProgressPercent() {
        if (targetValue <= 0)
            return 0;
        int percent = (int) Math.round(((double) currentProgress / targetValue) * 100);
        return Math.min(percent, 100);
    }
}
