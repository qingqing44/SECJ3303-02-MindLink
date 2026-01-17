package com.mindlink.usermanagement.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.mindlink.usermanagement.dao.StudentDao;
import com.mindlink.usermanagement.model.Student;

@Service
public class StudentService {

    @Autowired
    private StudentDao studentDao;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Student> getAllStudents() {
        return studentDao.findAll();
    }

    public Optional<Student> getStudentById(String id) {
        return studentDao.findById(id);
    }

    public void saveStudent(Student student) {
        if (student.getStudentId() == null || student.getStudentId().trim().isEmpty()) {
            throw new IllegalArgumentException("Student ID is required.");
        }

        String studentId = student.getStudentId().trim();
        student.setStudentId(studentId);

        Student existing = studentDao.findById(studentId).orElse(null);
        if (existing != null) {
            // Update
            student.setCreatedAt(existing.getCreatedAt());
            student.setUpdatedAt(LocalDateTime.now());

            if (student.getPassword() == null || student.getPassword().isEmpty()) {
                student.setPassword(existing.getPassword());
            }
            studentDao.update(student);
        } else {
            // Create (requires provided ID)
            createStudent(student);
        }
    }

    private void createStudent(Student student) {
        student.setCreatedAt(LocalDateTime.now());
        student.setUpdatedAt(LocalDateTime.now());
        if (student.getStatus() == null || student.getStatus().isEmpty()) {
            student.setStatus("PENDING");
        }
        studentDao.save(student);
    }

    private String generateNextStudentId() {
        // Find the highest student ID that matches pattern S###
        String sql = "SELECT MAX(CAST(SUBSTRING(student_id, 2) AS UNSIGNED)) FROM student WHERE student_id REGEXP '^S[0-9]+$'";
        try {
            Integer maxNum = jdbcTemplate.queryForObject(sql, Integer.class);
            if (maxNum == null) {
                maxNum = 0;
            }
            int nextNum = maxNum + 1;
            return String.format("S%03d", nextNum);
        } catch (Exception e) {
            return "S001";
        }
    }

    public void deleteStudent(String id) {
        studentDao.deleteById(id);
    }

    public List<Student> searchStudents(String keyword) {
        if (keyword == null || keyword.isEmpty()) {
            return getAllStudents();
        }
        return studentDao.searchByIdOrName(keyword);
    }

    public void approveStudent(String id) {
        studentDao.updateStatus(id, "APPROVED");
    }

    public List<Student> getPendingStudents() {
        // Since we don't have a specific DAO method for implementation simplicity and
        // time,
        // we can filter all students. For 50+ students preferably add a DAO method
        // "findByStatus".
        return getAllStudents().stream()
                .filter(s -> "PENDING".equalsIgnoreCase(s.getStatus()))
                .toList();
    }
}