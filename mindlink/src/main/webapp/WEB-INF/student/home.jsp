<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HomePage-Student Portal - MindLink</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #FFE6D0;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* 🟢 UPDATED HEADER: Fixed position & Glass Effect */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            padding: 15px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(255, 255, 255, 0.95); /* Slight transparency */
            backdrop-filter: blur(10px); /* Glass blur */
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
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
            transition: color 0.3s;
        }

        .nav-left a:hover, .nav-right a:hover {
            color: #F77F00; /* MindLink Orange for hover consistency */
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
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logo-icon img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        /* 🟢 UPDATED CONTAINER: Added top padding so header doesn't block content */
        .container {
            background: #FFE6D0;
            padding: 130px 100px 120px; /* Increased top padding to 130px */
            position: relative;
            overflow: hidden;
            min-height: 100vh;
            background-image:
                url('${pageContext.request.contextPath}/images/background-left.png'),
                url('${pageContext.request.contextPath}/images/background-right.png');
            background-position: left bottom, right bottom;
            background-repeat: no-repeat, no-repeat;
            background-size: auto, auto;
            background-color: #FFE6D0;
        }

        /* Welcome Content */
        .welcome-content {
            text-align: center;
            position: relative;
            z-index: 2;
        }

        .welcome-title {
            font-size: 56px;
            color: #00313e;
            font-weight: 700;
            margin-bottom: 15px;
        }

        .welcome-subtitle {
            font-size: 40px;
            color: #00313e;
            font-weight: 600;
            margin-bottom: 50px;
        }

        /* Today's Mind Tip */
        .tip-box {
            background: white;
            border-radius: 20px;
            padding: 30px 40px;
            max-width: 600px;
            margin: 0 auto 50px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .tip-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }

        .lightbulb-link {
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.3s;
        }

        .lightbulb-link:hover {
            transform: scale(1.1);
        }

        .lightbulb-link img {
            width: 32px;
            height: 32px;
            object-fit: contain;
        }

        .tip-title {
            font-size: 20px;
            color: #00313e;
            font-weight: 600;
        }

        .tip-content {
            font-size: 16px;
            color: #555;
            line-height: 1.6;
            text-align: left;
        }

        /* Upcoming Sessions */
        .sessions-section {
            max-width: 600px;
            margin: 0 auto;
        }

        .sessions-title {
            font-size: 28px;
            color: #00313e;
            font-weight: 700;
            margin-bottom: 25px;
        }

        .session-item {
            background: white;
            border-radius: 15px;
            padding: 25px 30px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .session-info h3 {
            font-size: 18px;
            color: #00313e;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .session-info p {
            font-size: 14px;
            color: #666;
        }

        .view-button {
            background: linear-gradient(135deg, #ffa500, #ff8c00);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
        }

        .view-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(255, 165, 0, 0.4);
        }

        /* Fixed Chat Button */
        .chat-button {
            position: fixed;
            bottom: 60px;
            right: 60px;
            background: white;
            padding: 20px;
            border-radius: 20px;
            cursor: pointer;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            transition: all 0.3s;
            z-index: 1000;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            width: 120px;
        }

        .chat-button:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
        }

        .chat-button-icon {
            width: 60px;
            height: 60px;
            object-fit: contain;
        }

        .chat-button-text {
            font-size: 11px;
            font-weight: 700;
            color: #00313e;
            text-align: center;
            line-height: 1.3;
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .header {
                padding: 15px 30px; /* Adjusted for smaller screens */
            }

            .container {
                padding: 120px 50px 50px;
                background-size: 15% auto, 15% auto;
            }

            .nav-left, .nav-right {
                gap: 20px;
            }
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 10px;
                position: static; /* Unstick on mobile if needed, or keep fixed */
                padding: 20px;
            }
            
            .container {
                padding-top: 20px; /* Reset padding if header is static */
                background-image: none;
            }

            .nav-left, .nav-right {
                gap: 15px;
            }

            .welcome-title {
                font-size: 36px;
            }

            .welcome-subtitle {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>
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
            <a href="${pageContext.request.contextPath}/forum/welcome">Forum</a>
            <a href="${pageContext.request.contextPath}/profile">Profile</a>
        </div>
    </div>

    <div class="container">
        <div class="welcome-content">
            <h1 class="welcome-title">Welcome back, Karen!</h1>
            <h2 class="welcome-subtitle">How are you feeling today?</h2>

            <div class="tip-box">
                <div class="tip-header">
                    <a href="${pageContext.request.contextPath}/ai/tips" class="lightbulb-link" title="Go to Mind Tips page">
                        <img src="${pageContext.request.contextPath}/images/lightbulb.png" alt="Mind Tip">
                    </a>
                    <span class="tip-title">Today's Mind Tip:</span>
                </div>
                <p class="tip-content">
                    "Take a few deep breaths before studying — calm mind, better focus."
                </p>
            </div>

            <div class="sessions-section">
                <h3 class="sessions-title">Upcoming Session:</h3>

                <div class="session-item">
                    <div class="session-info">
                        <h3>Session with Dr. Evelyn Reed</h3>
                        <p>Date: July 5, 2025, 10:00 AM</p>
                    </div>
                    <a href="/counseling" class="view-button">View</a>
                </div>

                <div class="session-item">
                    <div class="session-info">
                        <h3>Session with Dr. Aaron Smith</h3>
                        <p>Date: July 20, 2025, 10:00 AM</p>
                    </div>
                    <a href="/counseling" class="view-button">View</a>
                </div>
            </div>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/ai/chatbot" class="chat-button">
        <img src="${pageContext.request.contextPath}/images/chatbot.png" alt="Chat with AI" class="chat-button-icon">
        <span class="chat-button-text">CHAT<br>WITH AI<br>HERE!</span>
    </a>

    <script>
        // Add smooth animations on load
        window.addEventListener('load', function() {
            const container = document.querySelector('.container');
            container.style.opacity = '0';
            setTimeout(function() {
                container.style.transition = 'opacity 0.8s';
                container.style.opacity = '1';
            }, 100);
        });

        // Add click feedback for interactive elements
        document.querySelectorAll('.view-button, .chat-button, .lightbulb-link').forEach(function(element) {
            element.addEventListener('click', function(e) {
                const currentTransform = this.style.transform || '';
                this.style.transform = currentTransform + ' scale(0.95)';
                setTimeout(() => {
                    this.style.transform = currentTransform;
                }, 150);
            });
        });
    </script>
</body>
</html>