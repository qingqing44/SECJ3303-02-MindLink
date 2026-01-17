<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>MindLink - Learning Resources</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* --- THEME COLORS --- */
        :root {
            --bg-color: #FFF3E0;
            --text-dark: #003049;
            --text-body: #333333;
            --card-bg: #FFFFFF;
            --btn-yellow: #F2C94C;
            --btn-teal: #48C9B0;
            --btn-pink: #EF96AA;
            --btn-purple: #C89BF4;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            /* Gradient Background */
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(247, 127, 0, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 90% 80%, rgba(72, 201, 176, 0.1) 0%, transparent 50%);
            margin: 0;
            padding: 0;
            color: var(--text-body);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* 🟢 ANIMATED BLOBS (Background Decoration) */
        .blob {
            position: absolute; filter: blur(60px); z-index: -1; opacity: 0.6;
            animation: float 10s ease-in-out infinite;
        }
        .blob-1 { top: 100px; left: -50px; width: 400px; height: 400px; background: rgba(247, 127, 0, 0.15); border-radius: 40% 60% 70% 30%; }
        .blob-2 { bottom: 50px; right: -50px; width: 500px; height: 500px; background: rgba(72, 201, 176, 0.15); border-radius: 60% 40% 30% 70%; animation-direction: reverse; }
        @keyframes float {
            0% { transform: translate(0, 0) rotate(0deg); }
            50% { transform: translate(20px, 20px) rotate(5deg); }
            100% { transform: translate(0, 0) rotate(0deg); }
        }

        /* 🟢 UPDATED HEADER (Fixed & Glass Effect) */
        .header {
            position: fixed;
            top: 0; left: 0; width: 100%; z-index: 1000;
            padding: 15px 50px;
            display: flex; justify-content: space-between; align-items: center;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            box-sizing: border-box;
        }

        .nav-left, .nav-right {
            display: flex; align-items: center; justify-content: space-evenly; flex: 1; gap: 0;
        }

        .nav-left a, .nav-right a {
            text-decoration: none; color: #00313e; font-size: 16px; font-weight: 500; transition: color 0.3s;
        }

        .nav-left a:hover, .nav-right a:hover { color: #F77F00; }

        .logo {
            display: flex; align-items: center; gap: 10px; font-weight: 700;
            color: #00313e; font-size: 32px; text-decoration: none;
        }

        .logo-icon { width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; }
        .logo-icon img { width: 100%; height: 100%; object-fit: contain; }

        /* Main Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
            /* 🟢 Added Top Padding to clear fixed header */
            padding: 140px 40px 60px;
        }

        h1 {
            font-size: 48px; font-weight: 800; color: var(--text-dark);
            margin-bottom: 20px; line-height: 1.2;
        }

        .subtitle {
            font-size: 18px; color: #555; margin-bottom: 60px;
            max-width: 600px; margin-left: auto; margin-right: auto; line-height: 1.5;
        }

        /* --- GRID SYSTEM --- */
        .cards-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
            width: 100%;
        }

        .card {
            background: rgba(255, 255, 255, 0.9); /* Slight transparency */
            backdrop-filter: blur(5px);
            border-radius: 30px;
            padding: 40px 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            display: flex; flex-direction: column; align-items: center; justify-content: space-between;
            text-align: center;
            min-height: 400px;
            transition: all 0.3s ease;
            border: 1px solid rgba(255,255,255,0.5);
            position: relative; overflow: hidden;
        }

        .card:hover { transform: translateY(-10px); box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1); }

        /* 🟢 NEW ICON STYLES */
        .icon-circle {
            width: 80px; height: 80px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 36px; margin-bottom: 20px;
            color: white;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        /* Icon Background Colors matching buttons */
        .bg-yellow { background: var(--btn-yellow); }
        .bg-teal { background: var(--btn-teal); }
        .bg-pink { background: var(--btn-pink); }
        .bg-purple { background: var(--btn-purple); }

        .card h2 {
            font-size: 22px; color: var(--text-dark); margin-bottom: 15px; font-weight: 700;
        }

        .card p {
            font-size: 15px; line-height: 1.6; color: #666; margin-bottom: 30px;
        }

        /* Buttons */
        .btn {
            padding: 12px 35px; border-radius: 50px; border: none;
            color: white; font-size: 16px; font-weight: 600; cursor: pointer;
            text-decoration: none; display: inline-block; transition: all 0.2s;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .btn-yellow { background-color: var(--btn-yellow); }
        .btn-teal { background-color: var(--btn-teal); }
        .btn-pink { background-color: var(--btn-pink); }
        .btn-purple { background-color: var(--btn-purple); }

        .btn:hover { transform: scale(1.05); box-shadow: 0 6px 15px rgba(0,0,0,0.15); }

        /* Responsiveness */
        @media (max-width: 1200px) {
            .cards-container { grid-template-columns: repeat(2, 1fr); max-width: 800px; margin: 0 auto; }
        }
        @media (max-width: 600px) {
            .header { flex-direction: column; padding: 20px; }
            .container { padding-top: 160px; }
            .cards-container { grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>

    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

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

        <h1>Resources for Your Well-being</h1>
        <p class="subtitle">
            Explore expert insights, self-care guides, and tools to support your mental health journey.
        </p>

        <div class="cards-container">
            <div class="card">
                <div class="icon-circle bg-yellow">
                    <i class="fas fa-book-open"></i>
                </div>
                <div>
                    <h2>Learning<br>Module</h2>
                    <p>Practical tips on stress management, mindfulness, and emotional resilience.</p>
                </div>
                <a href="${pageContext.request.contextPath}/learning/modules" class="btn btn-yellow">Start Learning</a>
            </div>

            <div class="card">
                <div class="icon-circle bg-teal">
                    <i class="fas fa-clipboard-check"></i>
                </div>
                <div>
                    <h2>Self<br>Assessment</h2>
                    <p>Interactive quizzes to help you understand your mental state and needs.</p>
                </div>
                <a href="${pageContext.request.contextPath}/assessment" class="btn btn-teal">Take Quiz</a>
            </div>

            <div class="card">
                <div class="icon-circle bg-pink">
                    <i class="fas fa-user-md"></i>
                </div>
                <div>
                    <h2>Counseling &<br>Appointment</h2>
                    
                    <p>Book live sessions with certified mental health professionals.</p>
                </div>
                <a href="${pageContext.request.contextPath}/counseling/home" class="btn btn-pink">Book Now</a>
            </div>

            <div class="card">
                <div class="icon-circle bg-purple">
                    <i class="fas fa-trophy"></i>
                </div>
                <div>
                    <h2>Achievements</h2>
                    <p>Track your progress and earn badges as you reach your wellness goals.</p>
                </div>
                <a href="${pageContext.request.contextPath}/gamification" class="btn btn-purple">View Badges</a>
            </div>

        </div>
    </div>

</body>
</html>