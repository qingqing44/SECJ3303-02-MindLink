package com.mindlink.admin.dao;

import java.util.List;

import com.mindlink.module.LearningModule;

public interface AssesModuleDao {
    List<LearningModule> findAll();
}