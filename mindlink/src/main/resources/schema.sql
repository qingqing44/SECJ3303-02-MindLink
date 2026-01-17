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
DROP TABLE IF EXISTS counselor;
CREATE TABLE counselor (
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
);

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
);

-- Sample Data for Students (Student IDs start from S001)
INSERT INTO student (student_id, name, email, password, phone, faculty, year, status) VALUES
('S001', 'Karen Voon Xiu Wen', 'karen@utm.my', 'password123', '+60123456789', 'Faculty of Computing', 3, 'APPROVED'),
('S002', 'Siti Nurhaliza', 'siti.s002@utm.my', 'password123', '+60123456790', 'Faculty of Computing', 2, 'APPROVED'),
('S003', 'Muhammad Ali', 'ali.s003@utm.myutm.my', 'password123', '+60123456792', 'Faculty of Computing', 1, 'APPROVED'),
('S005', 'Hassan bin Ismail', 'hassan.s005@utm.my', 'password123', '+60123456793', 'Faculty of Engineering', 2, 'PENDING');

-- Sample Data for Admins (Admin IDs start from A001)
INSERT INTO admin (admin_id, name, email, password, phone, department, role) VALUES
('A001', 'Dr. Sarah Johnson', 'testadmin@utm.my', 'admin123', '+60198765432', 'Faculty of Computing', 'admin'),
('A002', 'Prof. Ahmad Rahman', 'ahmad.a002@utm.my', 'admin123', '+60198765433', 'Faculty of Computing', 'admin'),
('A003', 'Dr. Lee Mei Ling', 'lee.a003@utm.my', 'admin123', '+60198765434', 'Faculty of Engineering', 'admin');

-- Sample Data for Counselors (Counselor IDs start from C001)
INSERT INTO counselor (
    id, 
    name, 
    email, 
    password, 
    location, 
    education, 
    university, 
    languages, 
    specialization, 
    bio, 
    quote, 
    image_url, 
    phone_number,
    cert_id,
    status
) VALUES 
('C001', 'Ms. Tan Mei Ling', 'tan.meiling@utm.my', 'counselor123', 'Block A Room 209', 'M.A. Clinical Psychology', 'Universiti Sains Malaysia', 'English, Mandarin, Malay', 'Academic stress management, motivation building, emotional resilience', 'Experienced clinical psychologist dedicated to student well-being.', 'Empowering your journey.', 'tan.jpg', '012-3456789', 'CERT-2024-001', 'approved'),
('C002', 'Mr. Ryan Lin', 'ryan.lin@utm.my', 'counselor123', 'Block A Room 301', 'M.Sc. Counseling', 'UPM', 'English, Hokkien', 'Cognitive behavioral therapy', 'Focused on behavioral adjustments and mental clarity.', 'Change starts within.', 'ryan.jpg', '013-9876543', 'CERT-2024-002', 'approved'),
('C003', 'Ms. Nur Alya', 'nur.alya@utm.my', 'counselor123', 'Block B Room 314', 'PhD in Psychology', 'UKM', 'Malay, English', 'Anxiety and mood disorders', 'Expert in helping students manage anxiety and mood fluctuations.', 'Healing takes time.', 'nur.jpg', '014-5678901', 'CERT-2024-003', 'approved'),
('C004', 'Ms. Evelyn Reed', 'evelyn.reed@utm.my', 'counselor123', 'Block A Room 301', 'M.Sc. Counseling', 'UPM', 'English', 'Adjustment issues', 'Helping students navigate campus life transitions.', 'Guidance for every step.', 'evelyn.jpg', '016-1122334', 'CERT-2024-004', 'approved');

-- Sample Data for Appointments
INSERT INTO appointment (id, student_id, counselor_name, date, time, type, venue, status) VALUES
('BK001', 'S001', 'Mr. Ryan Lin', '2026-01-31', '04:00 PM', 'Physical', 'Block B Room 314', 'Booked'),
('BK002', 'S001', 'Ms. Tan Mei Ling', '2026-01-31', '09:00 AM', 'Online', 'https://utm.webex.com/utm/mstanmeiling', 'Booked'),
('BK003', 'S001', 'Ms. Tan Mei Ling', '2025-12-10', '10:00 AM', 'Physical', 'Block B Room 314', 'Booked'),
('BK004', 'S001', 'Mr. Ryan Lin', '2025-01-05', '02:00 PM', 'Online', 'https://utm.webex.com/utm/ryanlin', 'Booked');
('BK005', 'S001', 'Ms. Nur Alya', '2025-11-20', '09:00 AM', 'Online', 'https://utm.webex.com/utm/nuralya', 'Booked');

-- Sample Data for Chatbot (Rule-based responses)
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

-- Sample Data for Daily Tips
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

-- Sample Data for Forum
INSERT INTO forum (title, description, created_by, status) VALUES
('Coping with Exam Stress', 'Share your strategies and experiences dealing with exam-related stress and anxiety.', 'A001', 'active'),
('Building Healthy Relationships', 'Discuss ways to maintain and improve relationships with friends, family, and partners.', 'A001', 'active'),
('Work-Life Balance', 'Tips and discussions about balancing academic work, personal life, and self-care.', 'A001', 'active'),
('Self-Care Practices', 'Share and discover different self-care activities that work for you.', 'A002', 'active');

-- Sample Data for Forum Posts
-- Forum 1: Coping with Exam Stress
INSERT INTO forum_post (forum_id, user_id, user_name, content, status, is_anonymous, created_at) VALUES
(1, 'S001', 'Karen Voon Xiu Wen', 'I find that creating a study schedule really helps me manage exam stress. Breaking down my revision into smaller chunks makes everything feel more manageable. What strategies work for you all?', 'normal', FALSE, '2026-01-10 09:15:00'),
(1, 'S002', 'Siti Nurhaliza', 'Deep breathing exercises before exams have been a game changer for me! I do 4-7-8 breathing and it really calms my nerves.', 'normal', FALSE, '2026-01-11 14:30:00'),
(1, 'S003', 'Muhammad Ali', 'I used to panic during exams, but now I practice mindfulness meditation daily. It has helped me stay calm and focused during tests.', 'normal', FALSE, '2026-01-12 16:45:00'),
(1, 'S001', 'Karen Voon Xiu Wen', 'Has anyone tried the Pomodoro technique? I''ve been using it and it helps me stay focused without burning out.', 'normal', FALSE, '2026-01-13 10:20:00'),
(1, 'S005', 'Hassan bin Ismail', 'I struggle with exam anxiety a lot. Sometimes I feel like I know the material but my mind goes blank during the exam. Any advice?', 'normal', TRUE, '2026-01-14 11:00:00');

-- Forum 2: Building Healthy Relationships
INSERT INTO forum_post (forum_id, user_id, user_name, content, status, is_anonymous, created_at) VALUES
(2, 'S001', 'Karen Voon Xiu Wen', 'Communication is key! I''ve learned that being open and honest with friends, even when it''s difficult, strengthens our relationships.', 'normal', FALSE, '2026-01-08 13:20:00'),
(2, 'S002', 'Siti Nurhaliza', 'Setting boundaries has been really important for me. It''s okay to say no sometimes and prioritize your own well-being.', 'normal', FALSE, '2026-01-09 15:10:00'),
(2, 'S003', 'Muhammad Ali', 'I find that active listening makes a huge difference. When I truly listen to my friends without thinking about what to say next, our conversations become much more meaningful.', 'normal', FALSE, '2026-01-10 09:30:00'),
(2, 'S001', 'Karen Voon Xiu Wen', 'How do you all handle conflicts in friendships? I sometimes avoid confrontation but I know that''s not always healthy.', 'normal', FALSE, '2026-01-11 17:45:00'),
(2, 'S005', 'Hassan bin Ismail', 'I''ve been having trouble maintaining long-distance friendships since coming to university. Any tips on staying connected?', 'normal', TRUE, '2026-01-12 12:15:00');

-- Forum 3: Work-Life Balance
INSERT INTO forum_post (forum_id, user_id, user_name, content, status, is_anonymous, created_at) VALUES
(3, 'S001', 'Karen Voon Xiu Wen', 'I try to follow the 8-8-8 rule: 8 hours for work/study, 8 hours for sleep, and 8 hours for personal time. It''s not always perfect but it helps me maintain balance.', 'normal', FALSE, '2026-01-07 10:00:00'),
(3, 'S002', 'Siti Nurhaliza', 'Taking breaks is so important! I used to study for hours without stopping, but now I take 15-minute breaks every hour and I''m actually more productive.', 'normal', FALSE, '2026-01-08 14:25:00'),
(3, 'S003', 'Muhammad Ali', 'I schedule my "me time" just like I schedule my classes. If it''s in my calendar, I''m more likely to actually do it!', 'normal', FALSE, '2026-01-09 11:40:00'),
(3, 'S001', 'Karen Voon Xiu Wen', 'Does anyone else struggle with feeling guilty when taking time for themselves? I feel like I should always be studying.', 'normal', FALSE, '2026-01-10 16:20:00'),
(3, 'S005', 'Hassan bin Ismail', 'I''m overwhelmed with assignments and can''t find time for anything else. How do you all manage your time effectively?', 'normal', TRUE, '2026-01-11 13:50:00'),
(3, 'S002', 'Siti Nurhaliza', 'Remember that rest is productive too! Your brain needs downtime to process information and recharge.', 'normal', FALSE, '2026-01-12 15:30:00');

-- Forum 4: Self-Care Practices
INSERT INTO forum_post (forum_id, user_id, user_name, content, status, is_anonymous, created_at) VALUES
(4, 'S001', 'Karen Voon Xiu Wen', 'I love starting my day with a 10-minute meditation. It sets a positive tone for the rest of the day. What''s your morning self-care routine?', 'normal', FALSE, '2026-01-06 08:00:00'),
(4, 'S002', 'Siti Nurhaliza', 'Journaling has been amazing for me! Writing down my thoughts and feelings helps me process everything and feel more grounded.', 'normal', FALSE, '2026-01-07 19:15:00'),
(4, 'S003', 'Muhammad Ali', 'Going for a walk in nature is my go-to self-care activity. Even just 20 minutes outside makes me feel refreshed and recharged.', 'normal', FALSE, '2026-01-08 17:00:00'),
(4, 'S001', 'Karen Voon Xiu Wen', 'I''ve been trying to practice gratitude daily. Before bed, I write down three things I''m grateful for. It really shifts my perspective!', 'normal', FALSE, '2026-01-09 21:30:00'),
(4, 'S005', 'Hassan bin Ismail', 'I struggle with self-care because I feel like I don''t have time. What are some quick self-care activities that don''t take much time?', 'normal', TRUE, '2026-01-10 12:45:00'),
(4, 'S002', 'Siti Nurhaliza', 'Taking a warm bath with some calming music is my favorite way to unwind after a stressful day. Highly recommend!', 'normal', FALSE, '2026-01-11 20:00:00'),
(4, 'S003', 'Muhammad Ali', 'Reading for pleasure (not textbooks!) is one of my favorite self-care practices. It helps me escape and relax.', 'normal', FALSE, '2026-01-12 18:20:00');

-- Sample Data for Forum Comments
-- Comments for Forum 1: Coping with Exam Stress
-- Post 1: Karen's study schedule post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(1, 'S002', 'Siti Nurhaliza', 'That''s a great approach! I also break down my study sessions into 2-hour blocks with breaks in between. It really helps!', 'normal', '2026-01-10 10:30:00'),
(1, 'S003', 'Muhammad Ali', 'I do something similar! I use a weekly planner and assign specific topics to each day. It makes everything less overwhelming.', 'normal', '2026-01-10 14:20:00'),
(1, 'C001', 'Ms. Tan Mei Ling', 'Excellent strategy! Creating a structured plan can significantly reduce anxiety. Remember to also schedule time for rest and relaxation.', 'normal', '2026-01-10 16:45:00');

-- Post 2: Siti's breathing exercises post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(2, 'S001', 'Karen Voon Xiu Wen', 'I''ve heard about this technique! Can you explain the 4-7-8 method? I''d love to try it before my next exam.', 'normal', '2026-01-11 15:00:00'),
(2, 'S003', 'Muhammad Ali', 'Breathing exercises are so underrated! I combine them with visualization - imagining myself doing well in the exam.', 'normal', '2026-01-11 16:15:00');

-- Post 3: Muhammad's mindfulness meditation post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(3, 'S001', 'Karen Voon Xiu Wen', 'How long do you meditate each day? I''m interested in starting but not sure where to begin.', 'normal', '2026-01-12 17:30:00'),
(3, 'S002', 'Siti Nurhaliza', 'Meditation has helped me too! I started with just 5 minutes a day and gradually increased. There are great apps like Headspace that can guide you.', 'normal', '2026-01-12 18:00:00');

-- Post 4: Karen's Pomodoro technique post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(4, 'S002', 'Siti Nurhaliza', 'I love the Pomodoro technique! 25 minutes of focused work followed by a 5-minute break works perfectly for me.', 'normal', '2026-01-13 11:00:00'),
(4, 'S005', 'Hassan bin Ismail', 'I''ve been meaning to try this. Do you use any specific timer app or just a regular timer?', 'normal', '2026-01-13 12:30:00'),
(4, 'C002', 'Mr. Ryan Lin', 'The Pomodoro technique is excellent for maintaining focus and preventing burnout. I recommend starting with shorter intervals if 25 minutes feels too long initially.', 'normal', '2026-01-13 14:15:00');

-- Post 5: Hassan's exam anxiety post (anonymous)
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(5, 'S001', 'Karen Voon Xiu Wen', 'I''ve experienced this too. What helps me is writing down key points on a scrap paper as soon as I get the exam paper - it helps me organize my thoughts.', 'normal', '2026-01-14 12:00:00'),
(5, 'C003', 'Ms. Nur Alya', 'This is a common experience. Practice relaxation techniques before exams, and remember that it''s okay to take a moment to breathe during the exam if you feel overwhelmed.', 'normal', '2026-01-14 13:30:00');

-- Comments for Forum 2: Building Healthy Relationships
-- Post 6: Karen's communication post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(6, 'S002', 'Siti Nurhaliza', 'Communication is definitely key! I''ve learned that being honest, even when it''s uncomfortable, usually leads to better understanding.', 'normal', '2026-01-08 14:30:00'),
(6, 'S003', 'Muhammad Ali', 'I agree completely. I used to avoid difficult conversations, but I''ve found that addressing issues early prevents bigger problems later.', 'normal', '2026-01-08 16:00:00');

-- Post 7: Siti's boundaries post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(7, 'S001', 'Karen Voon Xiu Wen', 'Setting boundaries was hard for me at first, but it''s made my relationships much healthier. Learning to say no is a skill!', 'normal', '2026-01-09 16:30:00'),
(7, 'C001', 'Ms. Tan Mei Ling', 'Boundaries are essential for healthy relationships. They''re not about being selfish - they''re about respecting yourself and others.', 'normal', '2026-01-09 17:45:00');

-- Post 8: Muhammad's active listening post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(8, 'S001', 'Karen Voon Xiu Wen', 'Active listening is something I''m still working on. It''s harder than it sounds, but it really does make conversations more meaningful.', 'normal', '2026-01-10 10:30:00'),
(8, 'S002', 'Siti Nurhaliza', 'I try to practice this with my friends. Putting away my phone and giving them my full attention makes such a difference!', 'normal', '2026-01-10 11:15:00');

-- Post 9: Karen's conflict handling post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(9, 'S002', 'Siti Nurhaliza', 'I used to avoid conflicts too, but I''ve learned that addressing issues calmly and directly is usually better than letting resentment build up.', 'normal', '2026-01-11 18:30:00'),
(9, 'C002', 'Mr. Ryan Lin', 'Conflict is natural in relationships. The key is to approach it with respect, listen to the other person''s perspective, and focus on finding a solution together.', 'normal', '2026-01-11 19:00:00');

-- Post 10: Hassan's long-distance friendships post (anonymous)
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(10, 'S001', 'Karen Voon Xiu Wen', 'I maintain my long-distance friendships through regular video calls and sending each other updates about our lives. It takes effort but it''s worth it!', 'normal', '2026-01-12 13:30:00'),
(10, 'S002', 'Siti Nurhaliza', 'Scheduling regular catch-ups helps! Even if it''s just a quick text or sharing memes, staying in touch regularly makes a big difference.', 'normal', '2026-01-12 14:00:00');

-- Comments for Forum 3: Work-Life Balance
-- Post 11: Karen's 8-8-8 rule post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(11, 'S002', 'Siti Nurhaliza', 'The 8-8-8 rule sounds great! I struggle with this balance, especially during exam season. How do you stick to it?', 'normal', '2026-01-07 11:30:00'),
(11, 'S003', 'Muhammad Ali', 'I''ve tried this too! It''s not always perfect, but having a framework helps me stay aware of how I''m spending my time.', 'normal', '2026-01-07 13:00:00');

-- Post 12: Siti's breaks post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(12, 'S001', 'Karen Voon Xiu Wen', 'Taking breaks is so important! I used to think I was being lazy, but I''m actually more productive when I take regular breaks.', 'normal', '2026-01-08 15:30:00'),
(12, 'C003', 'Ms. Nur Alya', 'Research shows that regular breaks actually improve productivity and focus. Your brain needs time to process and recharge!', 'normal', '2026-01-08 16:00:00');

-- Post 13: Muhammad's scheduling me-time post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(13, 'S001', 'Karen Voon Xiu Wen', 'Scheduling me-time is brilliant! I''m going to try this. What activities do you usually schedule for yourself?', 'normal', '2026-01-09 12:30:00'),
(13, 'S002', 'Siti Nurhaliza', 'I do this too! I schedule things like reading, going for walks, or just doing nothing. It helps me actually follow through.', 'normal', '2026-01-09 13:15:00');

-- Post 14: Karen's guilt about taking time post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(14, 'S002', 'Siti Nurhaliza', 'I feel this too! But remember, taking care of yourself is not selfish - it''s necessary. You can''t pour from an empty cup.', 'normal', '2026-01-10 17:00:00'),
(14, 'C001', 'Ms. Tan Mei Ling', 'It''s completely normal to feel this way, but self-care is essential for your well-being and academic success. Rest is productive!', 'normal', '2026-01-10 17:30:00');

-- Post 15: Hassan's time management post (anonymous)
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(15, 'S001', 'Karen Voon Xiu Wen', 'I use a priority matrix - urgent and important tasks first, then important but not urgent. It helps me focus on what really matters.', 'normal', '2026-01-11 14:30:00'),
(15, 'S002', 'Siti Nurhaliza', 'Breaking tasks into smaller chunks and using a timer helps me stay focused. Also, don''t forget to say no to things that aren''t essential!', 'normal', '2026-01-11 15:00:00'),
(15, 'C002', 'Mr. Ryan Lin', 'Time management is a skill that takes practice. Start by tracking how you spend your time for a week, then identify areas where you can be more efficient.', 'normal', '2026-01-11 16:00:00');

-- Post 16: Siti's rest is productive post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(16, 'S001', 'Karen Voon Xiu Wen', 'This is such an important reminder! I needed to hear this today. Thank you for sharing!', 'normal', '2026-01-12 16:00:00'),
(16, 'S003', 'Muhammad Ali', 'Absolutely! Rest is when our brains consolidate learning. It''s not wasted time - it''s essential for memory and understanding.', 'normal', '2026-01-12 16:30:00');

-- Comments for Forum 4: Self-Care Practices
-- Post 17: Karen's meditation post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(17, 'S002', 'Siti Nurhaliza', 'I''ve been wanting to start a morning meditation practice! Do you use any guided meditations or do you do it on your own?', 'normal', '2026-01-06 09:30:00'),
(17, 'S003', 'Muhammad Ali', 'Meditation in the morning sets such a positive tone for the day. I do 10 minutes of mindfulness meditation every morning too!', 'normal', '2026-01-06 10:00:00');

-- Post 18: Siti's journaling post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(18, 'S001', 'Karen Voon Xiu Wen', 'Journaling has been so helpful for me too! I write about my day, my feelings, and things I''m grateful for. It''s like therapy!', 'normal', '2026-01-07 20:00:00'),
(18, 'C001', 'Ms. Tan Mei Ling', 'Journaling is an excellent self-care practice. It helps process emotions and gain clarity. There are many different journaling styles you can explore!', 'normal', '2026-01-07 20:30:00');

-- Post 19: Muhammad's nature walk post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(19, 'S001', 'Karen Voon Xiu Wen', 'Nature walks are amazing! I love going to the campus park. Being in nature really does help clear my mind.', 'normal', '2026-01-08 18:00:00'),
(19, 'S002', 'Siti Nurhaliza', 'I agree! Even a short walk outside makes me feel so much better. Fresh air and movement are underrated!', 'normal', '2026-01-08 18:30:00');

-- Post 20: Karen's gratitude practice post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(20, 'S002', 'Siti Nurhaliza', 'Gratitude practice is so powerful! I do this too and it really shifts my mindset. Sometimes I write them in a journal, sometimes I just think about them.', 'normal', '2026-01-09 22:00:00'),
(20, 'S003', 'Muhammad Ali', 'I''ve been doing this for a few months now and it''s amazing how it changes your perspective. Even on tough days, there''s always something to be grateful for.', 'normal', '2026-01-09 22:30:00');

-- Post 21: Hassan's quick self-care post (anonymous)
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(21, 'S001', 'Karen Voon Xiu Wen', 'Some quick self-care ideas: 5-minute breathing exercises, listening to your favorite song, stretching, drinking a glass of water mindfully, or calling a friend.', 'normal', '2026-01-10 13:30:00'),
(21, 'S002', 'Siti Nurhaliza', 'Even small things count! Taking a few deep breaths, stepping outside for fresh air, or doing a quick skincare routine can make a difference.', 'normal', '2026-01-10 14:00:00'),
(21, 'C003', 'Ms. Nur Alya', 'Self-care doesn''t have to be time-consuming. Even 5-10 minutes of intentional self-care can be beneficial. The key is consistency!', 'normal', '2026-01-10 14:30:00');

-- Post 22: Siti's warm bath post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(22, 'S001', 'Karen Voon Xiu Wen', 'Warm baths are the best! I add some Epsom salts and light a candle. It''s my favorite way to unwind after a stressful day.', 'normal', '2026-01-11 21:00:00'),
(22, 'S003', 'Muhammad Ali', 'I''m going to try this! Sounds so relaxing. Do you have any music recommendations for a calming bath experience?', 'normal', '2026-01-11 21:30:00');

-- Post 23: Muhammad's reading post
INSERT INTO forum_comment (post_id, user_id, user_name, content, status, created_at) VALUES
(23, 'S001', 'Karen Voon Xiu Wen', 'Reading for pleasure is such a great escape! What genres do you enjoy? I love fiction - it helps me disconnect from academic stress.', 'normal', '2026-01-12 19:00:00'),
(23, 'S002', 'Siti Nurhaliza', 'I love reading too! Even just 20-30 minutes before bed helps me relax and sleep better. It''s my favorite form of self-care.', 'normal', '2026-01-12 19:30:00');

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

-- Sample Data for Modules
INSERT INTO module (title, description, image_path) VALUES
('Introduction to Mental Health', 'Learn the basics of mental health, reduce stigma, and understand emotional well-being.', 'mental-health-intro.png'),
('Emotional Awareness and Regulation', 'Recognize your emotions, understand their causes, and develop healthy strategies to manage them effectively in daily and social situations.', 'emotional-awareness.png');

-- Sample Data for Module Questions (Introduction to Mental Health - Module ID 1)
INSERT INTO module_question (module_id, chapter_number, question_number, question_text, question_type) VALUES
(1, 1, '1.1', 'Definition and Key Concepts PDF', 'PDF'),
(1, 1, '1.2', 'Mental Health vs Mental Illness PDF', 'PDF'),
(1, 1, '1.3', 'Mental Health Spectrum PDF', 'PDF'),
(1, 2, '2.1', 'What is Stigma? PDF', 'PDF'),
(1, 2, '2.2', 'Media and Cultural Misconceptions PDF', 'PDF');

-- Sample Data for Module Questions (Emotional Awareness - Module ID 2)
INSERT INTO module_question (module_id, chapter_number, question_number, question_text, question_type) VALUES
(2, 1, '1.1', 'Understanding Your Emotions PDF', 'PDF'),
(2, 1, '1.2', 'Emotional Triggers and Responses PDF', 'PDF'),
(2, 2, '2.1', 'Emotion Regulation Techniques PDF', 'PDF'),
(2, 2, '2.2', 'Mindfulness and Emotional Awareness PDF', 'PDF');

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
    assessment_title VARCHAR(255) NOT NULL,
    question_text TEXT NOT NULL,
    question_type VARCHAR(50) DEFAULT 'Multiple Choice'
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

CREATE TABLE IF NOT EXISTS feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id VARCHAR(50),
    category VARCHAR(100),
    subject VARCHAR(255),
    message TEXT,
    rating INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    admin_reply TEXT
);

-- Sample Data for Assessment (Stress Test)
INSERT INTO assessment (assessment_title, question_text) VALUES 
('Stress Test', 'How often do you feel overwhelmed by your workload?'),
('Stress Test', 'Do you find it difficult to relax after work/study?'),
('Stress Test', 'How often do you get headaches or physical tension?');

-- Options for Question 1 (IDs will assume 1, 2, 3 based on auto-increment, but for safety in scripts usually we'd need to look them up. 
-- For this demo, assuming sequential insertion starting at 1).
-- Q1: Overwhelmed
INSERT INTO ass_question (assessment_id, option_text, score_value) VALUES 
(1, 'Never', 0), (1, 'Sometimes', 5), (1, 'Often', 10);

-- Q2: Difficult to relax
INSERT INTO ass_question (assessment_id, option_text, score_value) VALUES 
(2, 'No, I relax easily', 0), (2, 'Sometimes', 5), (2, 'Yes, very difficult', 10);

-- Q3: Physical tension
INSERT INTO ass_question (assessment_id, option_text, score_value) VALUES 
(3, 'Rarely', 0), (3, 'Occasionally', 5), (3, 'Frequently', 10);

-- Sample Data for Assessment (Happiness Check)
INSERT INTO assessment (assessment_title, question_text) VALUES 
('Happiness Check', 'I feel satisfied with my life currently.'),
('Happiness Check', 'I find joy in small things.');

-- Q4: Satisfied (ID 4)
INSERT INTO ass_question (assessment_id, option_text, score_value) VALUES 
(4, 'Strongly Disagree', 0), (4, 'Neutral', 5), (4, 'Strongly Agree', 10);

-- Q5: Joy (ID 5)
INSERT INTO ass_question (assessment_id, option_text, score_value) VALUES 
(5, 'Rarely', 0), (5, 'Sometimes', 5), (5, 'Always', 10);

INSERT INTO feedback (id, booking_id, category, subject, message, rating, created_at) VALUES 
(2, 'BK003', 'Counselor Behavior', 'Nice Counselor', 'I love this counselor!', 5, '2026-01-14 07:29:20');

-- Assessment Table: Stores questions for assessments
CREATE TABLE IF NOT EXISTS assessment (
    assessment_id INT AUTO_INCREMENT PRIMARY KEY,
    assessment_title VARCHAR(255) NOT NULL,
    question_text TEXT NOT NULL,
    question_type VARCHAR(50) DEFAULT 'Multiple Choice'
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

CREATE TABLE IF NOT EXISTS feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id VARCHAR(50),
    category VARCHAR(100),
    subject VARCHAR(255),
    message TEXT,
    rating INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample Data for Assessment (Stress Test)
INSERT INTO assessment (assessment_title, question_text) VALUES 
('Stress Test', 'How often do you feel overwhelmed by your workload?'),
('Stress Test', 'Do you find it difficult to relax after work/study?'),
('Stress Test', 'How often do you get headaches or physical tension?'),
('Stress Test', 'How often do you find that you cannot cope with all the things you have to do?', 'multiple_choice'),
('Stress Test', 'How often do you feel you are on top of things?', 'multiple_choice'),
('Stress Test', 'How often do you feel angered because of things that happened outside of your control?', 'multiple_choice'),
('Stress Test', 'How often do you feel that difficulties are piling up so high that you cannot overcome them?', 'multiple_choice'),
('Stress Test', 'How often do you experience physical symptoms of stress (e.g., headaches, stomach aches)?', 'multiple_choice'),
('Stress Test', 'How often do you have trouble falling or staying asleep due to racing thoughts?', 'multiple_choice'),
('Stress Test', 'How often do you feel overwhelmed by your academic or daily responsibilities?', 'multiple_choice');

-- Options for Question 1 (IDs will assume 1, 2, 3 based on auto-increment, but for safety in scripts usually we'd need to look them up. 
-- For this demo, assuming sequential insertion starting at 1).
-- Q1: Overwhelmed
INSERT INTO ass_question (assessment_id, option_text, score_value) VALUES 
(1, 'Never', 0), (1, 'Sometimes', 5), (1, 'Often', 10);

-- Q2: Difficult to relax
INSERT INTO ass_question (assessment_id, option_text, score_value) VALUES 
(2, 'No, I relax easily', 0), (2, 'Sometimes', 5), (2, 'Yes, very difficult', 10);

-- Q3: Physical tension
INSERT INTO ass_question (assessment_id, option_text, score_value) VALUES 
(3, 'Rarely', 0), (3, 'Occasionally', 5), (3, 'Frequently', 10),
(6, 'Never', 0), (104, 'Rarely', 3), (104, 'Often', 7), (104, 'Always', 10),
(7, 'Always', 0), (105, 'Often', 3), (105, 'Rarely', 7), (105, 'Never', 10),
(8, 'Never', 0), (106, 'Rarely', 3), (106, 'Often', 7), (106, 'Always', 10),
(9, 'Never', 0), (107, 'Rarely', 3), (107, 'Often', 7), (107, 'Always', 10),
(10, 'Never', 0), (108, 'Rarely', 3), (108, 'Often', 7), (108, 'Always', 10),
(11, 'Never', 0), (109, 'Rarely', 3), (109, 'Often', 7), (109, 'Always', 10),
(12, 'Never', 0), (110, 'Rarely', 3), (110, 'Often', 7), (110, 'Always', 10);


-- Sample Data for Assessment (Happiness Check)
INSERT INTO assessment (assessment_title, question_text) VALUES 
('Happiness Check', 'I feel satisfied with my life currently.'),
('Happiness Check', 'I find joy in small things.'),
('Happiness Check', 'In most ways, my life is close to my ideal.', 'multiple_choice'),
('Happiness Check', 'The conditions of my life are excellent.', 'multiple_choice'),
('Happiness Check', 'I am satisfied with my life.', 'multiple_choice'),
('Happiness Check', 'So far, I have gotten the important things I want in life.', 'multiple_choice'),
('Happiness Check', 'If I could live my life over, I would change almost nothing.', 'multiple_choice'),
('Happiness Check', 'I feel optimistic about my future.', 'multiple_choice'),
('Happiness Check', 'I feel that I have a sense of purpose in what I do.', 'multiple_choice'),
('Happiness Check', 'I enjoy the small things in my daily life.', 'multiple_choice'),
('Happiness Check', 'I feel energetic and motivated most days.', 'multiple_choice');

-- Q4: Satisfied (ID 4)
INSERT INTO ass_question (assessment_id, option_text, score_value) VALUES 
(4, 'Strongly Disagree', 0), (4, 'Neutral', 5), (4, 'Strongly Agree', 10);

-- Q5: Joy (ID 5)
INSERT INTO ass_question (assessment_id, option_text, score_value) VALUES 
(5, 'Rarely', 0), (5, 'Sometimes', 5), (5, 'Always', 10),
(13, 'Strongly Disagree', 0), (13, 'Disagree', 3), (13, 'Agree', 7), (13, 'Strongly Agree', 10),
(14, 'Strongly Disagree', 0), (14, 'Disagree', 3), (14, 'Agree', 7), (14, 'Strongly Agree', 10),
(15, 'Strongly Disagree', 0), (15, 'Disagree', 3), (15, 'Agree', 7), (15, 'Strongly Agree', 10),
(16, 'Strongly Disagree', 0), (16, 'Disagree', 3), (16, 'Agree', 7), (16, 'Strongly Agree', 10),
(17, 'Strongly Disagree', 0), (17, 'Disagree', 3), (17, 'Agree', 7), (17, 'Strongly Agree', 10),
(18, 'Strongly Disagree', 0), (18, 'Disagree', 3), (18, 'Agree', 7), (18, 'Strongly Agree', 10),
(19, 'Strongly Disagree', 0), (19, 'Disagree', 3), (19, 'Agree', 7), (19, 'Strongly Agree', 10),
(20, 'Strongly Disagree', 0), (20, 'Disagree', 3), (20, 'Agree', 7), (20, 'Strongly Agree', 10),
(21, 'Strongly Disagree', 0), (21, 'Disagree', 3), (21, 'Agree', 7), (21, 'Strongly Agree', 10),
(22, 'Strongly Disagree', 0), (22, 'Disagree', 3), (22, 'Agree', 7), (22, 'Strongly Agree', 10);

INSERT INTO feedback (id, booking_id, category, subject, message, rating, created_at) VALUES 
(2, 'BK003', 'Counselor Behavior', 'Nice Counselor', 'I love this counselor!', 5, '2026-01-14 07:29:20');

CREATE TABLE IF NOT EXISTS student_achievements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(100) NOT NULL,
    achievement_type VARCHAR(100) NOT NULL, -- e.g., 'WELLNESS_WARRIOR'
    unlocked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    UNIQUE KEY unique_student_ach (student_id, achievement_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO student_achievements (student_id, achievement_type, unlocked_at) VALUES
('S001', 'MIND_EXPLORER', '2025-01-10 10:30:00'),
('S001', 'WELLNESS_WARRIOR', '2025-01-12 14:45:00'),
('S002', 'MIND_EXPLORER', '2025-01-11 09:20:00'),
('S001', 'BALANCED_MIND', '2025-01-11 10:30:49'),
('S001', 'RESILIENCE_BUILDER', '2025-01-15 10:50:49'),
('S001', 'TINY_TRIUMPH', '2025-02-13 11:00:49'),
('S001', 'STEADY_START', '2025-02-25 08:50:45'),
('S001', 'FIRST_STEP_FORWARD', '2025-02-25 09:40:45'),
('S001', 'INNER_PEACE', '2025-01-25 19:40:45');

-- New table to track daily logins
CREATE TABLE IF NOT EXISTS user_logins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(100),
    login_date DATE,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    UNIQUE KEY (student_id, login_date)
);

-- Insert 3 new "Locked" milestones for users to work towards
-- These will now appear in your activities list
INSERT INTO student_achievements (student_id, achievement_type, unlocked_at) VALUES
('S001', 'FORUM_MASTER', NULL),        -- Milestone for posting in forum
('S001', 'CONSISTENT_CALM', NULL),     -- Milestone for 7-day login streak
('S001', 'FEEDBACK_FANATIC', NULL),    -- Milestone for providing feedback
('S001', 'FORUM_PARTICIPANT', NULL),   -- Goal: Post in the forum
('S001', 'DAILY_ZEN', NULL),           -- Goal: Log in for a 7-day streak
('S001', 'FEEDBACK_PROVIDER', NULL),   -- Goal: Rate a counselor session
('S001', 'KNOWLEDGE_SEEKER', NULL);    -- Goal: Read all learning modules

-- Update Assessment Table to include module_id
ALTER TABLE assessment ADD COLUMN module_id INT AFTER assessment_id;

-- Add Foreign Key constraint
ALTER TABLE assessment 
ADD CONSTRAINT fk_assessment_module 
FOREIGN KEY (module_id) REFERENCES module(module_id) ON DELETE CASCADE;

-- Create index for faster filtering
CREATE INDEX idx_assessment_module_id ON assessment(module_id);

-- Update Stress Test to belong to Module 1
UPDATE assessment SET module_id = 1 WHERE assessment_title = 'Stress Test';

-- Update Happiness Check to belong to Module 2
UPDATE assessment SET module_id = 2 WHERE assessment_title = 'Happiness Check';