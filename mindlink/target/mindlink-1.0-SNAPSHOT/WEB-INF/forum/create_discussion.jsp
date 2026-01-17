<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Discussion - MindLink</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #FFE6D0; /* soft peach to match forum style */
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Header */
        .header {
            padding: 20px 100px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            border-bottom: 1px solid #e0e0e0;
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
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 700;
            color: #00313e;
            font-size: 32px;
            text-decoration: none;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
        }

        .logo-icon img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        /* Container */
        .container {
            max-width: 900px;
            margin: 40px auto 60px;
            padding: 0 20px;
        }

        /* Back Arrow */
        .back-btn {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: none;
            background: transparent;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #00313e;
            font-size: 22px;
            cursor: pointer;
            transition: transform 0.2s ease;
            margin-bottom: 20px;
        }

        .back-btn:hover {
            transform: translateX(-4px);
        }

        /* Form Block (no card, sits on peach bg) */
        .form-card {
            padding: 10px 0 0;
        }

        .form-title {
            font-size: 40px;
            color: #00313e;
            font-weight: 700;
            margin-bottom: 6px;
            text-align: center;
        }

        .form-subtitle {
            color: #555;
            font-size: 14px;
            margin-bottom: 40px;
            text-align: center;
        }

        .form-inner {
            max-width: 620px;
            margin: 0 auto;
        }

        /* Form Fields */
        .form-group {
            margin-bottom: 22px;
        }

        .form-label {
            display: block;
            font-size: 16px;
            font-weight: 700;
            color: #00313e;
            margin-bottom: 8px;
        }

        .required {
            color: #ff6b6b;
        }

        .form-input {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 14px;
            font-family: inherit;
            outline: none;
            transition: border-color 0.3s;
        }

        .form-input:focus {
            border-color: #00313e;
        }

        .form-textarea {
            width: 100%;
            min-height: 150px;
            padding: 14px 18px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 14px;
            font-family: inherit;
            outline: none;
            resize: vertical;
            transition: border-color 0.3s;
        }

        .form-textarea:focus {
            border-color: #00313e;
        }

        /* Checkboxes */
        .checkbox-group {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .checkbox-item input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .checkbox-item label {
            font-size: 14px;
            color: #333;
            cursor: pointer;
        }

        /* Guidelines Box */
        .guidelines-box {
            background: #FFEFD9;
            padding: 24px 28px;
            border-radius: 22px;
            border: 2px solid #F3C9A4;
            margin: 10px 0 28px;
        }

        .guidelines-title {
            font-size: 18px;
            font-weight: 700;
            color: #00313e;
            text-align: center;
            margin-bottom: 10px;
        }

        .guidelines-list {
            list-style: none;
            padding: 0;
        }

        .guidelines-list li {
            font-size: 14px;
            color: #666;
            padding: 5px 0;
            padding-left: 20px;
            position: relative;
        }

        .guidelines-list li::before {
            content: "•";
            position: absolute;
            left: 0;
            color: #00313e;
            font-weight: bold;
        }

        /* Buttons */
        .button-group {
            display: flex;
            gap: 40px;
            justify-content: center;
            margin-top: 30px;
        }

        .cancel-btn {
            background: #FF5C5C;
            color: #ffffff;
            border: none;
            padding: 14px 40px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .cancel-btn:hover {
            background: #e14a4a;
        }

        .submit-btn {
            background: #0066FF;
            color: white;
            border: none;
            padding: 14px 40px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            background: #0052cc;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 49, 62, 0.3);
        }
        /* Chatbot button bottom-right */
        .chat-button {
            position: fixed;
            bottom: 40px;
            right: 40px;
            background: white;
            padding: 12px;
            border-radius: 50%;
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
            cursor: pointer;
            z-index: 1000;
        }

        .chat-button img {
            width: 52px;
            height: 52px;
            object-fit: contain;
        }

        /* Success Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 2000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            padding: 40px;
            border-radius: 20px;
            text-align: center;
            max-width: 400px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }

        .success-icon {
            font-size: 60px;
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 24px;
            color: #00313e;
            font-weight: 700;
            margin-bottom: 15px;
        }

        .modal-text {
            color: #666;
            font-size: 15px;
            margin-bottom: 25px;
        }

        .modal-btn {
            background: #00313e;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                padding: 20px;
            }

            .button-group {
                flex-direction: column;
            }

            .cancel-btn, .submit-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="nav-left">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/learning">Learning</a>
        </div>
        
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <div class="logo-icon">
                <img src="${pageContext.request.contextPath}/images/mindlink.png" alt="MindLink">
            </div>
            <span>MindLink</span>
        </a>
        
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/forum/welcome" style="color: #0d4e57; font-weight: 600;">Forum</a>
            <a href="${pageContext.request.contextPath}/profile">Profile</a>
        </div>
    </div>

    <!-- Container -->
    <div class="container">
        <a href="${pageContext.request.contextPath}/forum/detail" class="back-btn">←</a>

        <div class="form-card">
            <h1 class="form-title">Create New Discussion</h1>
            <p class="form-subtitle">Share your own experiences and discuss with others!</p>

            <form id="discussionForm" action="${pageContext.request.contextPath}/forum/create" method="POST">
                <input type="hidden" name="forumId" value="${forumId}">
                <input type="hidden" name="userId" value="S001">
                <input type="hidden" name="userName" value="Student User">
                <div class="form-inner">
                    <!-- Content -->
                    <div class="form-group">
                        <label class="form-label">1. CONTENT : <span class="required">*</span></label>
                        <textarea name="content" class="form-textarea" placeholder="Share your thoughts, experiences, or questions..." required></textarea>
                    </div>

                    <!-- Post Settings -->
                    <div class="form-group">
                        <label class="form-label">3. Post Settings: <span class="required">*</span></label>
                        <div class="checkbox-group">
                            <div class="checkbox-item">
                                <input type="checkbox" id="anonymous" name="anonymous" value="true">
                                <label for="anonymous">Post anonymously</label>
                            </div>
                        </div>
                    </div>

                    <!-- Community Guidelines -->
                    <div class="guidelines-box">
                        <div class="guidelines-title">Community Guidelines Reminder</div>
                        <ul class="guidelines-list">
                            <li>Be respectful and supportive</li>
                            <li>No medical advice</li>
                            <li>Seek professional help when needed</li>
                            <li>Report inappropriate content</li>
                        </ul>
                        <div class="checkbox-item" style="margin-top:10px;">
                            <input type="checkbox" id="agree" required>
                            <label for="agree">I've read and agree with the guidelines</label>
                        </div>
                    </div>

                    <!-- Buttons -->
                    <div class="button-group">
                        <button type="button" class="cancel-btn" onclick="window.location.href='${pageContext.request.contextPath}/forum/detail'">[Cancel]</button>
                        <button type="submit" class="submit-btn">[Post Discussion]</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Success Modal -->
    <div class="modal" id="successModal">
        <div class="modal-content">
            <div class="success-icon">✓</div>
            <h2 class="modal-title">Post Created Successfully!</h2>
            <p class="modal-text">Your discussion has been posted to the forum.</p>
            <button class="modal-btn" onclick="window.location.href='${pageContext.request.contextPath}/forum/detail'">Return to Forum</button>
        </div>
    </div>

    <script>
        function handleSubmit(event) {
            // Form will submit normally to server
            // Modal can be shown after successful submission if needed
        }
    </script>

    <!-- Chatbot Icon -->
    <a href="${pageContext.request.contextPath}/ai/chatbot" class="chat-button">
        <img src="${pageContext.request.contextPath}/images/chatbot.png" alt="Chat with AI">
    </a>
</body>
</html>