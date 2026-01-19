package com.mindlink.usermanagement.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mindlink.usermanagement.dao.StudentDao;
import com.mindlink.usermanagement.model.Student;

@Service
public class StudentService {

    @Autowired
    private StudentDao studentDao;

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