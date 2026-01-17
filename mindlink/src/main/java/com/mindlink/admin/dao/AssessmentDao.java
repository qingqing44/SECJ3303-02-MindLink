package com.mindlink.admin.dao;

import com.mindlink.assessment.Assessment;

import java.util.List;

public interface AssessmentDao {
    List<Assessment> findByTitle(String title);

    List<Assessment> findAll();

    List<Assessment> findByModuleId(int moduleId);

    Assessment findById(int id);

    void save(Assessment assessment);

    void update(Assessment assessment);

    void delete(int id);
}
