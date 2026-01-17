<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Question Form - MindLink Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #FFF3E0;
            --text-dark: #003049;
            --card-bg: #FFFFFF;
            --btn-teal: #48C9B0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            margin: 0;
            padding: 0;
            color: var(--text-dark);
        }

        /* Header Navigation */
        .header {
            padding: 20px 100px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
        }

        .nav-left,
        .nav-right {
            display: flex;
            align-items: center;
            justify-content: space-evenly;
            flex: 1;
            gap: 0;
        }

        .nav-left a, .nav-right a {
            text-decoration: none;
            color: #00313e;
            font-size: 16px;
            font-weight: 500;
            padding: 8px 16px;
            transition: color 0.3s;
        }

        .nav-left a:hover, .nav-right a:hover {
            color: var(--btn-teal);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            color: var(--text-dark);
            font-size: 24px;
            font-weight: 800;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logo-icon img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .form-container {
            max-width: 700px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .form-card {
            background: var(--card-bg);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .form-card h2 {
            margin-top: 0;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 700;
            color: var(--text-dark);
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-dark);
            font-size: 14px;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-family: 'Inter', sans-serif;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--btn-teal);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .btn-save {
            background: var(--btn-teal);
            color: white;
            border: none;
            padding: 14px 30px;
            border-radius: 20px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        .btn-save:hover {
            background: #3ab89f;
        }

        .btn-cancel {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #666;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }

        .btn-cancel:hover {
            color: var(--btn-teal);
        }
    </style>
</head>
<body>
    <!-- Standard Admin Header -->
    <div class="header">
        <div class="nav-left">
            <a href="${pageContext.request.contextPath}/admin/home">Home</a>
            <a href="${pageContext.request.contextPath}/admin/modules/dashboard">Module</a>
        </div>

        <a href="${pageContext.request.contextPath}/admin/home" class="logo">
            <div class="logo-icon">
                <img src="${pageContext.request.contextPath}/images/mindlink.png" alt="MindLink">
            </div>
            <span>MindLink</span>
        </a>

        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/admin/user-management">User Management</a>
            <a href="${pageContext.request.contextPath}/admin/profile">Profile</a>
        </div>
    </div>

    <div class="form-container">
        <div class="form-card">
            <h2>${question != null && question.questionId != 0 ? 'Edit' : 'Add New'} Question</h2>
            
            <form action="${pageContext.request.contextPath}/admin/modules/questions/save" method="post">
                <input type="hidden" name="questionId" value="${question != null ? question.questionId : 0}">
                <input type="hidden" name="moduleId" value="${question != null ? question.moduleId : moduleId}">
                
                <div class="form-group">
                    <label>Chapter Number</label>
                    <input type="number" name="chapterNumber" value="${question != null ? question.chapterNumber : 1}" min="1" required>
                </div>
                
                <div class="form-group">
                    <label>Question Number (e.g., 1.1, 2.3)</label>
                    <input type="text" name="questionNumber" value="${question != null ? question.questionNumber : ''}" placeholder="1.1" required>
                </div>
                
                <div class="form-group">
                    <label>Question Text</label>
                    <textarea name="questionText" rows="4" required>${question != null ? question.questionText : ''}</textarea>
                </div>
                
                <div class="form-group">
                    <label>Question Type</label>
                    <select name="questionType" required>
                        <option value="PDF" ${question != null && question.questionType == 'PDF' ? 'selected' : ''}>PDF</option>
                        <option value="Video" ${question != null && question.questionType == 'Video' ? 'selected' : ''}>Video</option>
                        <option value="Quiz" ${question != null && question.questionType == 'Quiz' ? 'selected' : ''}>Quiz</option>
                        <option value="Interactive" ${question != null && question.questionType == 'Interactive' ? 'selected' : ''}>Interactive</option>
                    </select>
                </div>
                
                <button type="submit" class="btn-save">Save Question</button>
                <a href="${pageContext.request.contextPath}/admin/modules/dashboard" class="btn-cancel">Cancel</a>
            </form>
        </div>
    </div>
</body>
</html>

