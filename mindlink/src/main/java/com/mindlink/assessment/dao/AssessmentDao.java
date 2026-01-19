package com.mindlink.assessment.dao;

import com.mindlink.assessment.Assessment;
import java.util.List;
import java.util.Map;

public interface AssessmentDao {
    List<Assessment> findByTitle(String title);

    List<Assessment> findAll();

    List<Assessment> findBySetId(int setId);

    List<Assessment> findBySetId(int setId, String search);

    Assessment findById(int id);

    void save(Assessment assessment);

    void update(Assessment assessment);

    void delete(int id);

    // Set management
    List<Map<String, Object>> findAllSets(String search);

    void deleteSet(int setId, String title);

    void updateSetTitle(int setId, String oldTitle, String newTitle);

    String getSetTitle(int setId);

    int getNextSetId();
}
