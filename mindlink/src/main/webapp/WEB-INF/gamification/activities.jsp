<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Activities</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cutive+Mono&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --bg-color: #FFF3E0;
            --text-dark: #003049;
            --card-bg: #FFFCF7;
            --bar-bg: #013B46; /* Dark background of the bar */
            --bar-fill: #63A4B2; /* Lighter teal fill */
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            margin: 0; padding: 20px;
            color: var(--text-dark);
            height: 100vh;
            overflow: hidden; 
        }

        /* Navbar */
        .navbar { display: flex; justify-content: space-between; align-items: center; padding: 10px 40px; margin-bottom: 20px; }
        .nav-links a { text-decoration: none; color: var(--text-dark); margin: 0 15px; font-weight: 600; }
        .logo { font-size: 32px; font-weight: 800; color: var(--text-dark); }

        /* Main Container */
        .container {
            display: flex; justify-content: center; align-items: center;
            height: calc(100vh - 100px);
        }

        /* The Card */
        .dashboard-card {
            background-color: var(--card-bg);
            width: 1000px;
            height: 600px;
            border-radius: 50px;
            padding: 30px 60px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            position: relative;
        }

        /* Header */
        .card-header {
            display: flex; align-items: center; justify-content: center;
            position: relative; margin-bottom: 30px;
        }

        .back-btn {
            position: absolute; left: 0;
            font-size: 40px; text-decoration: none; color: #000;
            font-weight: bold; line-height: 1;
        }

        h1 { font-size: 36px; font-weight: 800; margin: 0; }

        /* --- SCROLLABLE LIST --- */
        .activities-scroll-area {
            height: 480px;
            overflow-y: auto;
            padding-right: 20px;
            scrollbar-width: thin; /* Firefox */
            scrollbar-color: #000 #E0E0E0;
        }

        /* Webkit Scrollbar */
        .activities-scroll-area::-webkit-scrollbar { width: 15px; }
        .activities-scroll-area::-webkit-scrollbar-track { background: #E0E0E0; border-radius: 10px; }
        .activities-scroll-area::-webkit-scrollbar-thumb { background-color: #FFF; border: 2px solid #000; border-radius: 10px; }

        /* Activity Item */
        .activity-item {
            margin-bottom: 30px;
        }

        .activity-text {
            font-family: 'Cutive Mono', monospace; /* The Retro Font */
            font-size: 18px;
            color: #4A5568;
            margin-bottom: 8px;
            display: flex; justify-content: space-between;
        }

        .bar-container {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        /* The Progress Bar Styling */
        .progress-track {
            flex: 1;
            height: 35px;
            background-color: var(--bar-bg);
            border-radius: 20px;
            overflow: hidden;
            position: relative;
        }

        .progress-fill {
            height: 100%;
            background-color: var(--bar-fill);
            border-radius: 20px 0 0 20px;
            /* Smooth animation on load */
            width: 0; 
            transition: width 1s ease-out;
        }

        .reward-icon {
            width: 40px; height: 40px;
            object-fit: contain;
        }

    </style>
</head>
<body>

    <nav class="navbar">
        <div class="nav-links">
            <a href="/home">Home</a>
            <a href="/learning">Learning</a>
        </div>
        <div class="logo">MindLink</div>
        <div class="nav-links">
            <a href="/forum">Community</a>
            <a href="/profile">Profile</a>
        </div>
    </nav>

    <div class="container">
        <div class="dashboard-card">
            
            <div class="card-header">
                <a href="${pageContext.request.contextPath}/gamification" class="back-btn">
                    <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M9 14L4 9l5-5"/>
                        <path d="M4 9h10c4 0 7 3 7 7v1"/>
                    </svg>
                </a>
                <h1>My Activities</h1>
            </div>

            <div class="activities-scroll-area">
                
                <div class="activity-item">
                    <div class="activity-text">
                        <span>Shared a positive message or review</span>
                        <span>0 / 1</span>
                    </div>
                    <div class="bar-container">
                        <div class="progress-track">
                            <div class="progress-fill" style="width: 5%;"></div>
                        </div>
                        <img src="${pageContext.request.contextPath}/images/badge1.png" class="reward-icon">
                    </div>
                </div>

                <div class="activity-item">
                    <div class="activity-text">
                        <span>Completed 5 sessions with a counselor</span>
                        <span>1 / 5</span>
                    </div>
                    <div class="bar-container">
                        <div class="progress-track">
                            <div class="progress-fill" style="width: 20%;"></div>
                        </div>
                        <img src="${pageContext.request.contextPath}/images/badge2.png" class="reward-icon">
                    </div>
                </div>

                <div class="activity-item">
                    <div class="activity-text">
                        <span>Visited the app daily for 14 days</span>
                        <span>7 / 14</span>
                    </div>
                    <div class="bar-container">
                        <div class="progress-track">
                            <div class="progress-fill" style="width: 50%;"></div>
                        </div>
                        <img src="${pageContext.request.contextPath}/images/badge3.png" class="reward-icon">
                    </div>
                </div>

                <div class="activity-item">
                    <div class="activity-text">
                        <span>Completed first mental health assessment</span>
                        <span>1 / 1</span>
                    </div>
                    <div class="bar-container">
                        <div class="progress-track">
                            <div class="progress-fill" style="width: 100%;"></div>
                        </div>
                        <img src="${pageContext.request.contextPath}/images/badge4.png" class="reward-icon">
                    </div>
                </div>

                <div class="activity-item">
                    <div class="activity-text">
                        <span>Logged in for 3 consecutive days</span>
                        <span>3 / 3</span>
                    </div>
                    <div class="bar-container">
                        <div class="progress-track">
                            <div class="progress-fill" style="width: 100%;"></div>
                        </div>
                        <img src="${pageContext.request.contextPath}/images/badge5.png" class="reward-icon">
                    </div>
                </div>

                <div class="activity-item">
                    <div class="activity-text">
                        <span>Read 5 Learning Modules</span>
                        <span>2 / 5</span>
                    </div>
                    <div class="bar-container">
                        <div class="progress-track">
                            <div class="progress-fill" style="width: 40%;"></div>
                        </div>
                        <img src="${pageContext.request.contextPath}/images/badge6.png" class="reward-icon">
                    </div>
                </div>

            </div>
        </div>
    </div>

</body>
</html>