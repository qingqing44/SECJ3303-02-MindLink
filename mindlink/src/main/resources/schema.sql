-- MindLink Database Schema
-- Virtual Assistant & Support Module Tables

-- Drop Database if exists (for clean setup)
DROP DATABASE IF EXISTS mindlink_db;

-- Create Database
CREATE DATABASE IF NOT EXISTS mindlink_db;
USE mindlink_db;

-- Student Table: Stores student user information
CREATE TABLE IF NOT EXISTS student (
    student_id VARCHAR(100) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    faculty VARCHAR(255),
    year INT,
    status VARCHAR(20) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Admin Table: Stores admin user information
CREATE TABLE IF NOT EXISTS admin (
    admin_id VARCHAR(100) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    department VARCHAR(255),
    role VARCHAR(100) DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Counselor Table: Stores counselor user information
CREATE TABLE IF NOT EXISTS counselor (
    id VARCHAR(50) PRIMARY KEY, 
    name VARCHAR(100),
    password VARCHAR(255) NOT NULL,
    location VARCHAR(100),
    education VARCHAR(100),
    university VARCHAR(100),
    languages VARCHAR(100),
    email VARCHAR(100),
    bio TEXT,
    quote VARCHAR(255),
    image_url VARCHAR(255),
    phone_number VARCHAR(20),
    specialization VARCHAR(255),
    cert_id VARCHAR(100),
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_status (status),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Chatbot Table: Stores keyword-response pairs for rule-based chatbot
CREATE TABLE IF NOT EXISTS chatbot (
    id INT AUTO_INCREMENT PRIMARY KEY,
    keyword VARCHAR(255) NOT NULL,
    response TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_keyword (keyword)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Daily Tips Table: Stores daily mental health tips
CREATE TABLE IF NOT EXISTS daily_tips (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Forum Table: Stores forum/discussion topics
CREATE TABLE IF NOT EXISTS forum (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_by VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status ENUM('active', 'closed', 'archived') DEFAULT 'active',
    INDEX idx_created_by (created_by),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Forum Posts Table: Stores individual posts/replies in forums
CREATE TABLE IF NOT EXISTS forum_post (
    id INT AUTO_INCREMENT PRIMARY KEY,
    forum_id INT NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    status ENUM('normal', 'reported') DEFAULT 'normal',
    is_anonymous BOOLEAN DEFAULT FALSE,
    report_reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (forum_id) REFERENCES forum(id) ON DELETE CASCADE,
    INDEX idx_forum_id (forum_id),
    INDEX idx_user_id (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Forum Comments Table: Stores comments/replies to forum posts
CREATE TABLE IF NOT EXISTS forum_comment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    status ENUM('normal', 'reported') DEFAULT 'normal',
    report_reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES forum_post(id) ON DELETE CASCADE,
    INDEX idx_post_id (post_id),
    INDEX idx_user_id (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Appointment Table: Stores counseling appointment details
CREATE TABLE IF NOT EXISTS appointment (
    id VARCHAR(50) PRIMARY KEY,
    student_id VARCHAR(50),      -- Who booked it
    counselor_name VARCHAR(100), -- Who they booked with
    date VARCHAR(20),
    time VARCHAR(20),
    type VARCHAR(20),            -- Online/Physical
    venue VARCHAR(100),
    status VARCHAR(20) DEFAULT 'Confirmed',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Module Table: Stores learning modules
CREATE TABLE IF NOT EXISTS module (
    module_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    image_path VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_title (title)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Module Question Table: Stores questions/lessons for each module
CREATE TABLE IF NOT EXISTS module_question (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    module_id INT NOT NULL,
    chapter_number INT NOT NULL,
    question_number VARCHAR(50) NOT NULL,
    question_text TEXT NOT NULL,
    question_type VARCHAR(50) DEFAULT 'PDF',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (module_id) REFERENCES module(module_id) ON DELETE CASCADE,
    INDEX idx_module_id (module_id),
    INDEX idx_chapter (module_id, chapter_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- User Module Progress Table: Stores which questions a student has completed
CREATE TABLE IF NOT EXISTS user_module_progress (
    progress_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(100) NOT NULL,
    module_id INT NOT NULL,
    question_id INT NOT NULL,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (module_id) REFERENCES module(module_id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES module_question(question_id) ON DELETE CASCADE,
    UNIQUE KEY unique_progress (student_id, question_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Assessment Table: Stores questions for assessments
CREATE TABLE IF NOT EXISTS assessment (
    assessment_id INT AUTO_INCREMENT PRIMARY KEY,
    set_id INT, -- Formerly module_id
    assessment_title VARCHAR(255) NOT NULL,
    question_text TEXT NOT NULL,
    question_type VARCHAR(50) DEFAULT 'Multiple Choice',
    FOREIGN KEY (set_id) REFERENCES module(module_id) ON DELETE CASCADE,
    INDEX idx_set_id (set_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Assessment Question/Option Table: Stores options for each question
CREATE TABLE IF NOT EXISTS ass_question (
    option_id INT AUTO_INCREMENT PRIMARY KEY,
    assessment_id INT NOT NULL,
    option_text VARCHAR(255) NOT NULL,
    score_value INT NOT NULL,
    FOREIGN KEY (assessment_id) REFERENCES assessment(assessment_id) ON DELETE CASCADE,
    INDEX idx_assessment_id (assessment_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Feedback Table: Stores feedback related to counselor appointments
CREATE TABLE IF NOT EXISTS feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id VARCHAR(50),
    category VARCHAR(100),
    subject VARCHAR(255),
    message TEXT,
    rating INT,
    admin_reply TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Student Achievements Table: Tracks unlocked achievements per student
CREATE TABLE IF NOT EXISTS student_achievements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(100) NOT NULL,
    achievement_type VARCHAR(100) NOT NULL, -- e.g., 'WELLNESS_WARRIOR'
    unlocked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    UNIQUE KEY unique_student_ach (student_id, achievement_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Achievement Badge Definitions Table
CREATE TABLE IF NOT EXISTS achievement_badges (
    achievement_type VARCHAR(100) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    icon_path VARCHAR(255) NOT NULL,
    target_value INT NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- User Logins Table: Tracks daily logins for achievements
CREATE TABLE IF NOT EXISTS user_logins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(100),
    login_date DATE,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    UNIQUE KEY unique_login (student_id, login_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Assessment History Table: Stores summary of completed assessments
CREATE TABLE IF NOT EXISTS assessment_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(100) NOT NULL,
    assessment_title VARCHAR(255) NOT NULL,
    score INT NOT NULL,
    interpretation TEXT,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Assessment Answers Table: Stores detailed answers for each assessment in history
CREATE TABLE IF NOT EXISTS assessment_answers (
    answer_id INT AUTO_INCREMENT PRIMARY KEY,
    history_id INT NOT NULL,
    question_text TEXT NOT NULL,
    selected_option TEXT NOT NULL,
    score INT NOT NULL,
    FOREIGN KEY (history_id) REFERENCES assessment_history(history_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ==========================================
-- Sample Data
-- ==========================================

-- Students
INSERT INTO student (student_id, name, email, password, phone, faculty, year, status) VALUES
('S001', 'Karen Voon Xiu Wen', 'karen@utm.my', 'password123', '+60123456789', 'Faculty of Computing', 3, 'APPROVED'),
('S002', 'Siti Nurhaliza', 'siti.s002@utm.my', 'password123', '+60123456790', 'Faculty of Computing', 2, 'APPROVED'),
('S003', 'Muhammad Ali', 'ali.s003@utm.my', 'password123', '+60123456792', 'Faculty of Computing', 1, 'APPROVED'),
('S005', 'Hassan bin Ismail', 'hassan.s005@utm.my', 'password123', '+60123456793', 'Faculty of Engineering', 2, 'PENDING');

-- Admins
INSERT INTO admin (admin_id, name, email, password, phone, department, role) VALUES
('A001', 'Dr. Sarah Johnson', 'testadmin@utm.my', 'admin123', '+60198765432', 'Faculty of Computing', 'admin'),
('A002', 'Prof. Ahmad Rahman', 'ahmad.a002@utm.my', 'admin123', '+60198765433', 'Faculty of Computing', 'admin'),
('A003', 'Dr. Lee Mei Ling', 'lee.a003@utm.my', 'admin123', '+60198765434', 'Faculty of Engineering', 'admin');

-- Counselors
INSERT INTO counselor (id, name, email, password, location, education, university, languages, specialization, bio, quote, image_url, phone_number, cert_id, status) VALUES 
('C001', 'Ms. Tan Mei Ling', 'tan.meiling@utm.my', 'counselor123', 'Block A Room 209', 'M.A. Clinical Psychology', 'Universiti Sains Malaysia', 'English, Mandarin, Malay', 'Academic stress management, motivation building, emotional resilience', 'Experienced clinical psychologist dedicated to student well-being.', 'Empowering your journey.', 'tan.jpg', '012-3456789', 'CERT-2024-001', 'approved'),
('C002', 'Mr. Ryan Lin', 'ryan.lin@utm.my', 'counselor123', 'Block A Room 301', 'M.Sc. Counseling', 'UPM', 'English, Hokkien', 'Cognitive behavioral therapy', 'Focused on behavioral adjustments and mental clarity.', 'Change starts within.', 'ryan.jpg', '013-9876543', 'CERT-2024-002', 'approved'),
('C003', 'Ms. Nur Alya', 'nur.alya@utm.my', 'counselor123', 'Block B Room 314', 'PhD in Psychology', 'UKM', 'Malay, English', 'Anxiety and mood disorders', 'Expert in helping students manage anxiety and mood fluctuations.', 'Healing takes time.', 'nur.jpg', '014-5678901', 'CERT-2024-003', 'approved'),
('C004', 'Ms. Evelyn Reed', 'evelyn.reed@utm.my', 'counselor123', 'Block A Room 301', 'M.Sc. Counseling', 'UPM', 'English', 'Adjustment issues', 'Helping students navigate campus life transitions.', 'Guidance for every step.', 'evelyn.jpg', '016-1122334', 'CERT-2024-004', 'approved');

-- Appointments
INSERT INTO appointment (id, student_id, counselor_name, date, time, type, venue, status) VALUES
('BK001', 'S001', 'Mr. Ryan Lin', '2026-01-31', '04:00 PM', 'Physical', 'Block B Room 314', 'Booked'),
('BK002', 'S001', 'Ms. Tan Mei Ling', '2026-01-31', '09:00 AM', 'Online', 'https://utm.webex.com/utm/mstanmeiling', 'Booked'),
('BK003', 'S001', 'Ms. Tan Mei Ling', '2025-12-10', '10:00 AM', 'Physical', 'Block B Room 314', 'Booked'),
('BK004', 'S001', 'Mr. Ryan Lin', '2025-01-05', '02:00 PM', 'Online', 'https://utm.webex.com/utm/ryanlin', 'Booked'),
('BK005', 'S001', 'Ms. Nur Alya', '2025-11-20', '09:00 AM', 'Online', 'https://utm.webex.com/utm/nuralya', 'Booked');

-- Chatbot
INSERT INTO chatbot (keyword, response) VALUES
('hello', 'Hello! I''m here to help you with mental health support. How can I assist you today?'),
('hi', 'Hi there! Welcome to MindLink. What would you like to know?'),
('stress', 'Stress is a common experience. Try deep breathing exercises, take breaks, and prioritize self-care. Would you like tips on managing stress?'),
('anxiety', 'Anxiety can be challenging. Consider practicing mindfulness, staying active, and maintaining a regular sleep schedule. Remember, it''s okay to seek professional help.'),
('depression', 'Depression is a serious condition. Please reach out to a counselor or mental health professional. You can book a counseling session through our platform.'),
('help', 'I''m here to help! You can ask me about stress, anxiety, mental health tips, or book a counseling appointment. What would you like to know?'),
('tips', 'Here are some wellness tips: Get regular exercise, maintain a healthy sleep schedule, practice mindfulness, connect with others, and take time for activities you enjoy.'),
('counseling', 'To book a counseling session, please visit the Counseling section of the platform. Our qualified counselors are here to support you.'),
('feeling down', 'It''s normal to feel down sometimes. Consider talking to someone you trust, engaging in activities you enjoy, or booking a counseling session.'),
('mental health', 'Mental health is important. Take care of yourself through self-care practices, regular exercise, proper sleep, and seeking support when needed.');

-- Daily Tips
INSERT INTO daily_tips (title, content) VALUES
('Find Your Calm Before You Begin', 'Before studying or starting your day, take a moment to pause. Close your eyes, take three deep breaths for 5 seconds, feel it, and release. A calm mind helps you focus better.'),
('Start Your Day Mindfully', 'Start your day with 5 minutes of deep breathing or meditation to set a positive tone.'),
('Practice Daily Gratitude', 'Practice gratitude by writing down three things you''re thankful for each day.'),
('Stay Connected', 'Stay connected with friends and family - social connections are vital for mental health.'),
('Take Regular Breaks', 'Take regular breaks during work or study to prevent burnout and maintain focus.'),
('Prioritize Sleep', 'Get 7-9 hours of sleep each night to support both mental and physical well-being.'),
('Move Your Body', 'Engage in physical activity daily, even a short walk can boost your mood.'),
('Unplug Before Bed', 'Limit screen time before bed to improve sleep quality.'),
('Be Present', 'Practice mindfulness by being fully present in the current moment.'),
('Set Realistic Goals', 'Set realistic goals and celebrate small achievements along the way.'),
('Ask for Help', 'Remember that it''s okay to ask for help - seeking support is a sign of strength.');

-- Forum
INSERT INTO forum (title, description, created_by, status) VALUES
('Coping with Exam Stress', 'Share your strategies and experiences dealing with exam-related stress and anxiety.', 'A001', 'active'),
('Building Healthy Relationships', 'Discuss ways to maintain and improve relationships with friends, family, and partners.', 'A001', 'active'),
('Work-Life Balance', 'Tips and discussions about balancing academic work, personal life, and self-care.', 'A001', 'active'),
('Self-Care Practices', 'Share and discover different self-care activities that work for you.', 'A002', 'active');

-- Forum Posts
INSERT INTO forum_post (forum_id, user_id, user_name, content, status, is_anonymous, created_at) VALUES
(1, 'S001', 'Karen Voon Xiu Wen', 'I find that creating a study schedule really helps me manage exam stress. Breaking down my revision into smaller chunks makes everything feel more manageable. What strategies work for you all?', 'normal', FALSE, '2026-01-10 09:15:00'),
(2, 'S001', 'Karen Voon Xiu Wen', 'Communication is key! I''ve learned that being open and honest with friends, even when it''s difficult, strengthens our relationships.', 'normal', FALSE, '2026-01-08 13:20:00'),
(3, 'S001', 'Karen Voon Xiu Wen', 'I try to follow the 8-8-8 rule: 8 hours for work/study, 8 hours for sleep, and 8 hours for personal time. It''s not always perfect but it helps me maintain balance.', 'normal', FALSE, '2026-01-07 10:00:00'),
(4, 'S001', 'Karen Voon Xiu Wen', 'I love starting my day with a 10-minute meditation. It sets a positive tone for the rest of the day. What''s your morning self-care routine?', 'normal', FALSE, '2026-01-06 08:00:00');

-- Modules
INSERT INTO module (title, description, image_path) VALUES
('Introduction to Mental Health', 'Learn the basics of mental health, reduce stigma, and understand emotional well-being.', 'mental-health-intro.png'),
('Emotional Awareness and Regulation', 'Recognize your emotions, understand their causes, and develop healthy strategies to manage them effectively in daily and social situations.', 'emotional-awareness.png');

-- Assessments
INSERT INTO assessment (set_id, assessment_title, question_text) VALUES 
(1, 'Stress Test', 'How often do you feel overwhelmed by your workload?'),
(1, 'Stress Test', 'Do you find it difficult to relax after work/study?'),
(1, 'Stress Test', 'How often do you get headaches or physical tension?'),
(2, 'Happiness Check', 'I feel satisfied with my life currently.'),
(2, 'Happiness Check', 'I find joy in small things.');

-- Assessment Questions/Options
INSERT INTO ass_question (assessment_id, option_text, score_value) VALUES 
(1, 'Never', 0), (1, 'Sometimes', 5), (1, 'Often', 10),
(2, 'No, I relax easily', 0), (2, 'Sometimes', 5), (2, 'Yes, very difficult', 10),
(3, 'Rarely', 0), (3, 'Occasionally', 5), (3, 'Frequently', 10),
(4, 'Strongly Disagree', 0), (4, 'Neutral', 5), (4, 'Strongly Agree', 10),
(5, 'Rarely', 0), (5, 'Sometimes', 5), (5, 'Always', 10);

-- Feedback
INSERT INTO feedback (booking_id, category, subject, message, rating, created_at) VALUES 
('BK003', 'Counselor Behavior', 'Nice Counselor', 'I love this counselor!', 5, '2026-01-14 07:29:20');

-- Achievement Badge Definitions
INSERT INTO achievement_badges (achievement_type, title, description, icon_path, target_value) VALUES
('MIND_EXPLORER', 'Mind Explorer', 'Completed 1st mental health assessment', 'badge3.png', 1),
('WELLNESS_WARRIOR', 'Wellness Warrior', 'Completed 5 sessions with a counselor', 'badge1.png', 5),
('INNER_PEACE', 'Inner Peace', 'Achieved 2000 points', 'badge5.png', 2000),
('BALANCED_MIND', 'Balanced Mind', 'Special milestone achievement', 'badge2.png', 1),
('RESILIENCE_BUILDER', 'Resilience Builder', 'Special milestone achievement', 'badge4.png', 1),
('TINY_TRIUMPH', 'Tiny Triumph', 'Special milestone achievement', 'badge7.png', 1),
('STEADY_START', 'Steady Start', 'Special milestone achievement', 'badge8.png', 1),
('FIRST_STEP_FORWARD', 'First Step Forward', 'Special milestone achievement', 'badge6.png', 1),
('FORUM_MASTER', 'Forum Master', 'Special milestone achievement', 'badge1.png', 1),
('KNOWLEDGE_SEEKER', 'Knowledge Seeker', 'Special milestone achievement', 'badge2.png', 1),
('CONSISTENT_CALM', 'Consistent Calm', 'Special milestone achievement', 'badge3.png', 1),
('DAILY_ZEN', 'Daily Zen', 'Special milestone achievement', 'badge4.png', 1),
('COMMUNITY_STAR', 'Community Star', 'Special milestone achievement', 'badge5.png', 1),
('FEEDBACK_HERO', 'Feedback Hero', 'Special milestone achievement', 'badge6.png', 1),
('MINDFUL_MEMBER', 'Mindful Member', 'Special milestone achievement', 'badge7.png', 1);

-- Student Achievements (S001 initial data)
INSERT INTO student_achievements (student_id, achievement_type, unlocked_at) VALUES
('S001', 'BALANCED_MIND', '2025-01-11 10:30:49'),
('S001', 'RESILIENCE_BUILDER', '2025-01-15 10:50:49'),
('S001', 'TINY_TRIUMPH', '2025-02-13 11:00:49'),
('S001', 'FIRST_STEP_FORWARD', '2025-02-25 09:40:45');