<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Assessment History - MindLink</title>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <style>
                    :root {
                        --text-dark: #003049;
                        --teal-dark: #013B46;
                        --highlight: #4E8692;
                        --btn-green: #86E393;
                        --btn-red: #FF6B6B;
                    }

                    /* Glassmorphism & Modern Styling */
                    * {
                        box-sizing: border-box;
                        margin: 0;
                        padding: 0;
                    }

                    body {
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        background: linear-gradient(135deg, #FFF3E0 0%, #FFE0B2 100%);
                        color: var(--text-dark);
                        min-height: 100vh;
                    }

                    .header {
                        padding: 20px 100px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        background: white;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                    }

                    .nav-left,
                    .nav-right {
                        display: flex;
                        align-items: center;
                        justify-content: space-evenly;
                        flex: 1;
                    }

                    .nav-left a,
                    .nav-right a {
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

                    .logo-icon img {
                        width: 40px;
                        height: 40px;
                    }

                    .container {
                        max-width: 1000px;
                        margin: 60px auto;
                        padding: 0 20px;
                        animation: fadeIn 0.8s ease-out;
                    }

                    @keyframes fadeIn {
                        from {
                            opacity: 0;
                            transform: translateY(20px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    .page-header h1 {
                        font-size: 42px;
                        font-weight: 800;
                        background: linear-gradient(to right, var(--text-dark), var(--teal-dark));
                        -webkit-background-clip: text;
                        background-clip: text;
                        -webkit-text-fill-color: transparent;
                        margin-bottom: 15px;
                    }

                    /* History List */
                    .history-list {
                        display: flex;
                        flex-direction: column;
                        gap: 25px;
                    }

                    .history-card {
                        background: rgba(255, 255, 255, 0.6);
                        backdrop-filter: blur(10px);
                        -webkit-backdrop-filter: blur(10px);
                        padding: 35px;
                        border-radius: 35px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03);
                        border: 1px solid rgba(255, 255, 255, 0.4);
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                    }

                    .history-card:hover {
                        transform: translateY(-8px) scale(1.01);
                        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
                        background: rgba(255, 255, 255, 0.8);
                    }

                    .history-info h2 {
                        font-size: 26px;
                        font-weight: 700;
                        color: var(--text-dark);
                        margin-bottom: 8px;
                    }

                    .history-date {
                        font-size: 14px;
                        color: #777;
                        font-weight: 600;
                        letter-spacing: 0.5px;
                    }

                    .history-score-box {
                        display: flex;
                        align-items: center;
                        gap: 25px;
                    }

                    /* Dynamic Score Badges */
                    .score-badge {
                        padding: 12px 28px;
                        border-radius: 20px;
                        font-weight: 800;
                        font-size: 20px;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                        transition: transform 0.2s;
                    }

                    .score-stable {
                        background: linear-gradient(135deg, #86E393 0%, #4CAF50 100%);
                        color: white;
                    }

                    .score-stress {
                        background: linear-gradient(135deg, #FFB74D 0%, #F57C00 100%);
                        color: white;
                    }

                    .score-urgent {
                        background: linear-gradient(135deg, #FF8A80 0%, #D32F2F 100%);
                        color: white;
                    }

                    .interpretation {
                        font-weight: 700;
                        font-size: 16px;
                        text-align: right;
                    }

                    .status-stable {
                        color: #2E7D32;
                    }

                    .status-stress {
                        color: #E65100;
                    }

                    .status-urgent {
                        color: #C62828;
                    }

                    /* Details Section */
                    .details-toggle {
                        background: white;
                        border: none;
                        color: var(--teal-dark);
                        padding: 12px 20px;
                        border-radius: 15px;
                        cursor: pointer;
                        font-weight: 700;
                        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
                        transition: all 0.2s;
                    }

                    .details-toggle:hover {
                        background: var(--teal-dark);
                        color: white;
                        transform: scale(1.05);
                    }

                    .details-content {
                        background: rgba(255, 255, 255, 0.4);
                        backdrop-filter: blur(5px);
                        margin-top: -15px;
                        margin-bottom: 25px;
                        padding: 40px;
                        border-radius: 0 0 35px 35px;
                        border: 1px solid rgba(255, 255, 255, 0.3);
                        border-top: none;
                        animation: slideDown 0.4s cubic-bezier(0.22, 1, 0.36, 1);
                    }

                    @keyframes slideDown {
                        from {
                            opacity: 0;
                            transform: translateY(-20px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    .answers-grid {
                        display: grid;
                        gap: 20px;
                    }

                    .answer-item {
                        padding: 20px;
                        background: rgba(255, 255, 255, 0.7);
                        border-radius: 20px;
                        border: 1px solid rgba(255, 255, 255, 0.5);
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
                        transition: transform 0.2s;
                    }

                    .answer-item:hover {
                        transform: translateX(10px);
                    }

                    .q-text {
                        font-weight: 700;
                        font-size: 17px;
                        margin-bottom: 8px;
                        color: var(--text-dark);
                    }

                    .q-ans {
                        font-size: 15px;
                        color: #555;
                    }

                    .q-ans strong {
                        color: var(--teal-dark);
                        font-weight: 800;
                    }

                    .btn-back {
                        display: inline-block;
                        margin-top: 50px;
                        color: var(--teal-dark);
                        text-decoration: none;
                        font-weight: 800;
                        font-size: 18px;
                        transition: transform 0.2s;
                    }

                    .btn-back:hover {
                        transform: translateX(-10px);
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
                    <div class="page-header">
                        <h1>Assessment History</h1>
                        <p class="subtitle">Your previous mental health assessment results</p>
                    </div>
                    <br><br>
                    <div class="history-list">
                        <c:forEach var="item" items="${historyList}" varStatus="status">
                            <div class="history-card">
                                <div class="history-info">
                                    <h2>${item.assessmentTitle}</h2>
                                    <div class="history-date">
                                        Completed on:
                                        <fmt:formatDate value="${item.completedAt}" pattern="MMM dd, yyyy - HH:mm" />
                                    </div>
                                </div>
                                <div class="history-score-box">
                                    <c:choose>
                                        <c:when test="${item.score < 10}">
                                            <div class="interpretation status-stable">${item.interpretation}</div>
                                            <div class="score-badge score-stable">Score: ${item.score}</div>
                                        </c:when>
                                        <c:when test="${item.score < 20}">
                                            <div class="interpretation status-stress">${item.interpretation}</div>
                                            <div class="score-badge score-stress">Score: ${item.score}</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="interpretation status-urgent">${item.interpretation}</div>
                                            <div class="score-badge score-urgent">Score: ${item.score}</div>
                                        </c:otherwise>
                                    </c:choose>
                                    <button class="details-toggle" data-index="${status.index}">View Details</button>
                                </div>
                            </div>
                            <div id="details-${status.index}" class="details-content" style="display: none;">
                                <h3>Detailed Responses</h3>
                                <div class="answers-grid">
                                    <c:forEach var="ans" items="${item.answers}">
                                        <div class="answer-item">
                                            <div class="q-text">${ans.questionText}</div>
                                            <div class="q-ans">Answer: <strong>${ans.selectedOption}</strong> (Score:
                                                ${ans.score})</div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>

                        <c:if test="${empty historyList}">
                            <div class="no-history">
                                <p>You haven't completed any assessments yet.</p>
                                <a href="${pageContext.request.contextPath}/assessment" class="btn-back">Start your
                                    first assessment now &rarr;</a>
                            </div>
                        </c:if>
                    </div>

                    <a href="${pageContext.request.contextPath}/assessment" class="btn-back">&larr; Back to
                        Assessment</a>
                </div>
                <script>
                    document.addEventListener('click', function (e) {
                        if (e.target && e.target.classList.contains('details-toggle')) {
                            const index = e.target.getAttribute('data-index');
                            const content = document.getElementById('details-' + index);
                            if (content.style.display === 'none') {
                                content.style.display = 'block';
                                e.target.innerText = 'Hide Details';
                            } else {
                                content.style.display = 'none';
                                e.target.innerText = 'View Details';
                            }
                        }
                    });
                </script>
            </body>

            </html>