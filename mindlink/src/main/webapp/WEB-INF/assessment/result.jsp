<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Assessment Result</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --bg-color: #FFF3E0;
                    --text-dark: #003049;
                    --card-bg: #FFF9F2;
                    --circle-orange: #D9863D;
                    --circle-inner: #D4AF37;
                    --teal-box: #013B46;
                    --btn-dark: #013B46;
                }

                * {
                    box-sizing: border-box;
                    margin: 0;
                    padding: 0;
                }

                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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

                /* Main Center Container */
                .container {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: calc(100vh - 81px);
                    /* minus header */
                    padding: 40px;
                }

                /* THE SCROLLABLE CARD */
                .result-card {
                    background-color: var(--card-bg);
                    width: 100%;
                    max-width: 850px;
                    /* Reduced width */
                    margin-top: 600px;
                    /* Push down to avoid header overlap */
                    border-radius: 50px;
                    padding: 40px;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                    position: relative;
                    overflow: visible;
                    /* Remove scrollbar as requested */
                }

                /* Section Score */
                .section-score {
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                    align-items: center;
                    text-align: center;
                    margin-bottom: 60px;
                }

                h1 {
                    font-size: 32px;
                    font-weight: 800;
                    margin-bottom: 15px;
                }

                .hint-text {
                    color: #4CAF50;
                    /* Green text */
                    font-size: 16px;
                    font-weight: 600;
                    margin-bottom: 40px;
                }

                /* The Score Circle */
                .score-circle-outer {
                    width: 220px;
                    height: 220px;
                    background-color: var(--circle-orange);
                    border-radius: 50%;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }

                .score-circle-inner {
                    width: 160px;
                    height: 160px;
                    background-color: #CFB562;
                    /* Muted gold/yellow */
                    border-radius: 50%;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    font-size: 80px;
                    font-weight: 800;
                    color: white;
                }

                /* Section Suggestion */
                .section-suggestion {
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                    align-items: center;
                    padding-bottom: 40px;
                }

                .suggestion-grid {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    gap: 40px;
                    width: 100%;
                }

                .teacher-img {
                    width: 250px;
                    height: auto;
                }

                /* The Dark Box */
                .info-box {
                    background-color: var(--teal-box);
                    color: white;
                    padding: 40px;
                    border-radius: 30px;
                    width: 450px;
                    position: relative;
                    text-align: left;
                }

                .info-box h3 {
                    font-size: 20px;
                    margin-bottom: 5px;
                    font-weight: 700;
                }

                .info-box p {
                    font-size: 16px;
                    margin-bottom: 20px;
                    line-height: 1.4;
                }

                .suggestion-list {
                    margin-bottom: 20px;
                    padding-left: 20px;
                }

                .suggestion-list li {
                    margin-bottom: 8px;
                    font-size: 16px;
                    font-weight: 600;
                }

                .contact-info {
                    font-size: 16px;
                    font-weight: 700;
                    margin-top: 10px;
                }

                /* Done Button */
                .btn-done {
                    display: inline-block;
                    background-color: var(--btn-dark);
                    color: white;
                    padding: 12px 60px;
                    border-radius: 10px;
                    font-size: 20px;
                    font-weight: 700;
                    text-decoration: none;
                    margin-top: 40px;
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                }

                .btn-done:hover {
                    opacity: 0.9;
                }

                /* Navigation Arrows (Visual only to match screenshot) */
                .scroll-arrow-down {
                    margin-top: 20px;
                    font-size: 24px;
                    color: #000;
                    animation: bounce 2s infinite;
                }

                @keyframes bounce {

                    0%,
                    20%,
                    50%,
                    80%,
                    100% {
                        transform: translateY(0);
                    }

                    40% {
                        transform: translateY(-10px);
                    }

                    60% {
                        transform: translateY(-5px);
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
                <div class="result-card">

                    <div class="section-score">
                        <h1>Your Assessment is Complete!</h1>
                        <div class="hint-text">Scroll down to view your results 🍃</div>

                        <div class="score-circle-outer">
                            <div class="score-circle-inner">
                                ${score}
                            </div>
                        </div>

                        <div class="scroll-arrow-down">▼</div>
                    </div>

                    <div class="section-suggestion">
                        <h1 style="margin-bottom: 40px;">Result Interpretation :</h1>

                        <div class="suggestion-grid">
                            <img src="${pageContext.request.contextPath}/images/teacher-pointing.png" alt="Teacher"
                                class="teacher-img">

                            <div class="info-box">
                                <h3>${suggestionTitle}</h3>
                                <p>${interpretation}</p>

                                <p>Our Suggestions:</p>
                                <ul class="suggestion-list">
                                    <c:forEach var="sugg" items="${suggestions}">
                                        <li>${sugg}</li>
                                    </c:forEach>
                                </ul>

                                <div class="contact-info">
                                    You may contact:<br>
                                    Dr. Amirah (+60 12 - 345 6789)
                                </div>
                            </div>
                        </div>

                        <a href="${pageContext.request.contextPath}/assessment" class="btn-done">Done</a>
                    </div>

                </div>
            </div>

        </body>

        </html>