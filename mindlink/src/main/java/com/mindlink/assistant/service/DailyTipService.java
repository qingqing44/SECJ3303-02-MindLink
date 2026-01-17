package com.mindlink.assistant.service;

import com.mindlink.assistant.dao.DailyTipDAO;
import com.mindlink.assistant.model.DailyTip;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DailyTipService {

    @Autowired
    private DailyTipDAO dailyTipDAO;

    /**
     * Get a random tip
     */
    public DailyTip getRandomTip() {
        return dailyTipDAO.findRandom();
    }


    public List<DailyTip> getThreeRandomTips() {
        return dailyTipDAO.findThreeRandom();
    }

    /**
     * Get all tips
     */
    public List<DailyTip> getAllTips() {
        return dailyTipDAO.findAll();
    }

    /**
     * Get tip by ID
     */
    public DailyTip getTipById(int id) {
        return dailyTipDAO.findById(id);
    }

    /**
     * Add a new tip
     */
    public void addTip(String title, String content) {
        dailyTipDAO.create(title, content);
    }

    /**
     * Update a tip
     */
    public void updateTip(int id, String title, String content) {
        dailyTipDAO.update(id, title, content);
    }

    /**
     * Delete a tip
     */
    public void deleteTip(int id) {
        dailyTipDAO.delete(id);
    }
}
