package com.mindlink.assessment; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CounselorAssessmentService {

    @Autowired
    private JdbcTemplate jdbcTemplate; // Connects to your real database

    public List<AssessmentResult> getAssessmentResults(String type, String risk, String search) {
        // 1. Build Query with JOIN (History + Student Name)
        StringBuilder sql = new StringBuilder(
            "SELECT h.student_id, s.name AS student_name, h.assessment_title, h.score, h.interpretation, h.completed_at " +
            "FROM assessment_history h " +
            "JOIN student s ON h.student_id = s.student_id " +
            "WHERE 1=1 "
        );
        
        List<Object> params = new ArrayList<>();

        // 2. Apply Filters
        if (type != null && !type.equals("all")) {
            sql.append("AND h.assessment_title = ? ");
            params.add(type);
        }
        
        // 🟢 UPDATED: Filter logic based on Score > 20
        if ("high".equals(risk)) {
            sql.append("AND h.score > 20 "); 
        }

        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND s.name LIKE ? ");
            params.add("%" + search.trim() + "%");
        }

        sql.append("ORDER BY h.completed_at DESC");

        // 3. Execute & Map to Java Object
        return jdbcTemplate.query(sql.toString(), params.toArray(), (rs, rowNum) -> 
            new AssessmentResult(
                rs.getString("student_id"),
                rs.getString("student_name"),
                rs.getString("assessment_title"),
                rs.getInt("score"),
                rs.getString("interpretation"),
                rs.getTimestamp("completed_at").toString().substring(0, 16)
            )
        );
    }
}