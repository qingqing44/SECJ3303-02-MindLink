<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Achievement Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --bg-color: #FFF3E0;
            --text-dark: #003049;
            --card-bg: #FFFCF7;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            margin: 0; padding: 20px;
            color: var(--text-dark);
            height: 100vh;
            overflow: hidden; /* Prevent body scroll */
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
            padding: 30px 50px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            position: relative;
        }

        /* Header with Back Button */
        .card-header {
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            margin-bottom: 30px;
        }

        .back-btn {
            position: absolute;
            left: 0;
            font-size: 40px;
            text-decoration: none;
            color: #000;
            font-weight: bold;
            line-height: 1;
        }

        h1 {
            font-size: 36px;
            font-weight: 800;
            margin: 0;
        }

        /* --- SCROLLABLE BADGE GRID --- */
        .badge-grid-container {
            height: 480px; /* Fixed height for scrolling */
            overflow-y: auto;
            padding-right: 20px;
            
            /* Custom Scrollbar Logic */
            scrollbar-width: thin;
            scrollbar-color: #000 #E0E0E0;
        }

        /* Webkit Scrollbar (Chrome/Edge/Safari) */
        .badge-grid-container::-webkit-scrollbar { width: 15px; }
        .badge-grid-container::-webkit-scrollbar-track { 
            background: #E0E0E0; border-radius: 10px; 
        }
        .badge-grid-container::-webkit-scrollbar-thumb { 
            background-color: #FFF; 
            border: 2px solid #000;
            border-radius: 10px; 
        }

        .badge-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4 Columns */
            gap: 40px;
            padding-bottom: 20px;
        }

        /* Individual Badge Item */
        .badge-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .badge-img {
            width: 120px;
            height: 120px;
            object-fit: contain;
            margin-bottom: 10px;
            transition: transform 0.2s;
        }
        
        .badge-item:hover .badge-img {
            transform: scale(1.1);
        }

        .badge-title {
            font-family: 'Courier New', monospace; /* Monospace for retro look */
            font-weight: 700;
            font-size: 18px;
            line-height: 1.2;
            color: #000;
            max-width: 120px;
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

    <div class="container">
        <div class="dashboard-card">
            
            <div class="card-header">
                <a href="${pageContext.request.contextPath}/gamification" class="back-btn">
                    <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M9 14L4 9l5-5"/>
                        <path d="M4 9h10c4 0 7 3 7 7v1"/>
                    </svg>
                </a>
                <h1>Achievement Dashboard</h1>
            </div>

            <div class="badge-grid-container">
                <div class="badge-grid">
                    
                    <div class="badge-item">
                        <img src="${pageContext.request.contextPath}/images/badge1.png" class="badge-img" alt="Badge">
                        <div class="badge-title">Wellness<br>Warrior</div>
                    </div>
                    <div class="badge-item">
                        <img src="${pageContext.request.contextPath}/images/badge2.png" class="badge-img" alt="Badge">
                        <div class="badge-title">Balanced<br>Mind</div>
                    </div>
                    <div class="badge-item">
                        <img src="${pageContext.request.contextPath}/images/badge3.png" class="badge-img" alt="Badge">
                        <div class="badge-title">Resilience<br>Builder</div>
                    </div>
                    <div class="badge-item">
                        <img src="${pageContext.request.contextPath}/images/badge4.png" class="badge-img" alt="Badge">
                        <div class="badge-title">Inner<br>Peace</div>
                    </div>

                    <div class="badge-item">
                        <img src="${pageContext.request.contextPath}/images/badge5.png" class="badge-img" alt="Badge">
                        <div class="badge-title">Tiny<br>Triumph</div>
                    </div>
                    <div class="badge-item">
                        <img src="${pageContext.request.contextPath}/images/badge6.png" class="badge-img" alt="Badge">
                        <div class="badge-title">Steady<br>Start</div>
                    </div>
                    <div class="badge-item">
                        <img src="${pageContext.request.contextPath}/images/badge7.png" class="badge-img" alt="Badge">
                        <div class="badge-title">Mind<br>Explorer</div>
                    </div>
                    <div class="badge-item">
                        <img src="${pageContext.request.contextPath}/images/badge6.png" class="badge-img" alt="Badge">
                        <div class="badge-title">First Step<br>Forward</div>
                    </div>

                    <div class="badge-item">
                        <img src="${pageContext.request.contextPath}/images/badge1.png" class="badge-img" alt="Badge">
                        <div class="badge-title">Consistent<br>Healer</div>
                    </div>
                    </div>
            </div>

        </div>
    </div>

</body>
</html>