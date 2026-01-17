<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Achievements Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #FFF3E0;
            --text-dark: #003049;
            --btn-dark: #013B46; /* Dark Teal from screenshot */
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            margin: 0; padding: 0;
            color: var(--text-dark);
            overflow-x: hidden;
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
            transition: color 0.3s;
        }

        .nav-left a:hover, .nav-right a:hover {
            color: #0d4e57;
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

        /* Main Container */
        .hero-container {
            position: relative;
            height: calc(100vh - 90px);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 0 20px;
            overflow: hidden; /* Prevent scrollbars from shapes */
        }

        /* Center Content */
        .content-box {
            text-align: center;
            z-index: 10;
            position: relative;
            max-width: 800px;
        }

        h1 {
            font-size: 52px;
            font-weight: 800;
            color: #003049;
            line-height: 1.3;
            margin-bottom: 50px;
        }

        /* Button Stack */
        .button-group {
            display: flex;
            flex-direction: column;
            gap: 20px;
            align-items: center;
        }

        .btn-action {
            background-color: var(--btn-dark);
            color: white;
            padding: 18px 40px;
            border-radius: 40px; /* Pill shape */
            font-size: 18px;
            font-weight: 600;
            text-decoration: none;
            width: 300px; /* Fixed width for uniformity */
            text-align: center;
            transition: transform 0.2s;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }

        .btn-action:hover {
            transform: scale(1.05);
            opacity: 0.95;
        }

        /* Decorative Shapes */
        .shape-left, .shape-right {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            z-index: 1;
            height: 100%; /* Fill height */
            width: auto;
            max-width: 35%; /* Don't overlap text */
            object-fit: contain;
        }

        .shape-left { left: 0; object-position: left center; }
        .shape-right { right: 0; object-position: right center; }

        /* Mobile Responsive */
        @media (max-width: 1000px) {
            .shape-left, .shape-right { opacity: 0.15; }
            h1 { font-size: 36px; }
        }

    </style>
</head>
<body>

 <!-- Header Navigation -->
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
    <div class="hero-container">
        
        <img src="${pageContext.request.contextPath}/images/assessment_left.png" class="shape-left" alt="">

        <div class="content-box">
            <h1>Begin your journey to <br> earning achievements <br> and self-improvement!</h1>
            
            <div class="button-group">
                <a href="${pageContext.request.contextPath}/gamification/achievements" class="btn-action">
                    View Achievements &nbsp; &rarr;
                </a>

                <a href="${pageContext.request.contextPath}/gamification/activities" class="btn-action">
                    View My Activities &nbsp; &rarr;
                </a>
            </div>
        </div>

        <img src="${pageContext.request.contextPath}/images/assessment_right.png" class="shape-right" alt="">

    </div>

</body>
</html>