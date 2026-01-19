<%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>My Activities</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap"
                rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Cutive+Mono&display=swap" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">

            <style>
                :root {
                    --bg-color: #FFF3E0;
                    --text-dark: #003049;
                    --card-bg: #FFFCF7;
                    --bar-bg: #013B46;
                    --bar-fill: #63A4B2;
                }

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background-color: var(--bg-color);
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

                .nav-left a,
                .nav-right a {
                    text-decoration: none;
                    color: #00313e;
                    font-size: 16px;
                    font-weight: 500;
                    transition: color 0.3s;
                }

                .nav-left a:hover,
                .nav-right a:hover {
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
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 40px 20px;
                }

                /* Top Bar */
                .top-bar {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 30px;
                }

                .back-btn {
                    background: none;
                    border: none;
                    cursor: pointer;
                    padding: 0;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    transition: transform 0.2s;
                }

                .back-btn img {
                    width: 40px;
                    height: 40px;
                }

                .page-title {
                    font-size: 28px;
                    font-weight: 700;
                    color: #003049;
                }

                /* Points Display Card */
                .points-card {
                    background: linear-gradient(135deg, #6B8E99 0%, #8AA9B5 100%);
                    border-radius: 30px;
                    padding: 40px 50px;
                    margin-bottom: 40px;
                    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                }

                .points-display {
                    display: flex;
                    flex-direction: column;
                    gap: 10px;
                }

                .points-number {
                    font-family: 'Press Start 2P', cursive;
                    font-size: 80px;
                    color: white;
                    text-shadow: 4px 4px 0px rgba(0, 0, 0, 0.3);
                    letter-spacing: 2px;
                    margin-left: 100px;
                }

                .points-label {
                    font-family: 'Press Start 2P', cursive;
                    font-size: 14px;
                    color: rgba(255, 255, 255, 0.9);
                    text-transform: uppercase;
                    letter-spacing: 3px;
                    margin-left: 230px;
                }

                .progress-bars-container {
                    display: flex;
                    flex-direction: column;
                    gap: 25px;
                    flex: 1;
                    max-width: 500px;
                    margin-left: 80px;
                }

                .mini-progress-item {
                    display: flex;
                    align-items: center;
                    gap: 15px;
                }

                .progress-emoji {
                    font-size: 32px;
                    min-width: 40px;
                    text-align: center;
                }

                .mini-progress-content {
                    flex: 1;
                    display: flex;
                    flex-direction: column;
                    gap: 5px;
                }

                .mini-progress-label {
                    font-size: 12px;
                    color: rgba(255, 255, 255, 0.8);
                    font-weight: 600;
                }

                .mini-progress-bar-bg {
                    background: rgba(0, 0, 0, 0.3);
                    border-radius: 20px;
                    height: 18px;
                    overflow: hidden;
                    position: relative;
                }

                .mini-progress-fill {
                    background: linear-gradient(90deg, #4ECDC4 0%, #44A08D 100%);
                    height: 100%;
                    border-radius: 20px;
                    transition: width 0.8s ease-out;
                    position: relative;
                }

                .mini-progress-fill::after {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: linear-gradient(90deg,
                            transparent 0%,
                            rgba(255, 255, 255, 0.3) 50%,
                            transparent 100%);
                    animation: shimmer 2s infinite;
                }

                @keyframes shimmer {
                    0% {
                        transform: translateX(-100%);
                    }

                    100% {
                        transform: translateX(100%);
                    }
                }

                /* Progress Section */
                .progress-section {
                    background: white;
                    padding: 40px;
                    border-radius: 20px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
                }

                .progress-section h3 {
                    font-size: 22px;
                    font-weight: 700;
                    color: #003049;
                    margin-bottom: 30px;
                }

                .activity-item {
                    margin-bottom: 30px;
                }

                .activity-text {
                    font-family: 'Cutive Mono', monospace;
                    font-size: 16px;
                    color: #4A5568;
                    margin-bottom: 8px;
                    display: flex;
                    justify-content: space-between;
                }

                .bar-container {
                    display: flex;
                    align-items: center;
                    gap: 20px;
                }

                .progress-track {
                    flex: 1;
                    height: 35px;
                    background-color: var(--bar-bg);
                    border-radius: 20px;
                    overflow: hidden;
                    position: relative;
                }

                .progress-fill2 {
                    height: 100%;
                    background-color: var(--bar-fill);
                    border-radius: 20px 0 0 20px;
                    transition: width 1s ease-out;
                }

                .reward-icon {
                    width: 45px;
                    height: 45px;
                    object-fit: contain;
                }

                @media (max-width: 768px) {
                    .points-card {
                        flex-direction: column;
                        text-align: center;
                        gap: 30px;
                    }

                    .progress-bars-container {
                        margin-left: 0;
                        width: 100%;
                    }

                    .points-number {
                        font-size: 40px;
                    }
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
                <!-- Top Bar -->
                <div class="top-bar">
                    <button class="back-btn" onclick="window.history.back()">
                        <img src="${pageContext.request.contextPath}/images/back-arrow.png" alt="Back">
                    </button>
                    <h1 class="page-title">My Activities</h1>
                    <div style="width: 40px;"></div> <!-- Spacer for alignment -->
                </div>

                <!-- Points Display Card -->
                <div class="points-card">
                    <div class="points-display">
                        <div class="points-number">${totalPoints}</div>
                        <div class="points-label">POINTS</div>
                    </div>

                    <div class="progress-bars-container">
                        <div class="mini-progress-item">
                            <div class="progress-emoji">👤</div>
                            <div class="mini-progress-content">
                                <div class="mini-progress-label">${achievedCount} / 15</div>
                                <div class="mini-progress-bar-bg">
                                    <div class="mini-progress-fill"
                                        style="--w: ${(achievedCount / 15) * 100}%; width: var(--w);">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mini-progress-item">
                            <div class="progress-emoji">👑</div>
                            <div class="mini-progress-content">
                                <div class="mini-progress-label">${achievedCount} / 15</div>
                                <div class="mini-progress-bar-bg">
                                    <div class="mini-progress-fill"
                                        style="--w: ${(achievedCount / 15) * 100}%; width: var(--w);">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Progress Section -->
                <div class="progress-section">
                    <h3>Achievement Progress</h3>

                    <c:forEach var="ach" items="${achievements}">
                        <div class="activity-item">
                            <div class="activity-text">
                                <span>${ach.title}: ${ach.description}</span>
                                <span>${ach.cappedProgress} / ${ach.targetValue}</span>
                            </div>
                            <div class="bar-container">
                                <div class="progress-track">
                                    <c:set var="percent" value="${(ach.currentProgress / ach.targetValue) * 100}" />
                                    <div class="progress-fill2" style="--w: ${ach.progressPercent}%; width: var(--w);">
                                    </div>
                                </div>
                                <img src="${pageContext.request.contextPath}/images/${ach.iconPath}"
                                    class="reward-icon ${ach.unlocked ? '' : 'locked-style'}" alt="${ach.title}">
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

        </body>

        </html>