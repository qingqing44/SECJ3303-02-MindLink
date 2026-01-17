package com.mindlink.admin.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import com.mindlink.module.LearningModule;
import java.util.List;

@Repository
public class AssesModuleDaoImpl implements AssesModuleDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<LearningModule> findAll() {
        // SQL change: Query unique module IDs and titles from the assessment table
        String sql = "SELECT DISTINCT module_id, assessment_title FROM assessment";
        
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            LearningModule m = new LearningModule();
            m.setModuleId(rs.getInt("module_id"));
            m.setTitle(rs.getString("assessment_title"));
            m.setDescription("Questions grouped under this module."); // Placeholder
            return m;
        });
    }
}