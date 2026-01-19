<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>MindLink - ${title}</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --bg-color: #FFF3E0;
                    --text-dark: #003049;
                    --input-bg: #013B46;
                    --highlight: #4E8692;
                    --btn-green: #86E393;
                    --btn-red: #FF6B6B;

                    --current-page: $ {
                        currentPage
                    }

                    ;

                    --total-pages: $ {
                        totalPages
                    }

                    ;
                }

                * {
                    box-sizing: border-box;
                    margin: 0;
                    padding: 0;
                }

                /* Glassmorphism & Animations */
                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background: linear-gradient(135deg, #FFF3E0 0%, #FFE0B2 100%);
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

                /* Container & Card */
                .container {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    min-height: calc(100vh - 81px);
                    padding: 40px;
                }

                .assessment-card {
                    background: rgba(255, 255, 255, 0.7);
                    backdrop-filter: blur(15px);
                    -webkit-backdrop-filter: blur(15px);
                    width: 100%;
                    max-width: 750px;
                    border-radius: 40px;
                    padding: 50px;
                    position: relative;
                    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                    border: 1px solid rgba(255, 255, 255, 0.3);
                    animation: cardEntry 0.6s cubic-bezier(0.22, 1, 0.36, 1);
                }

                @keyframes cardEntry {
                    from {
                        opacity: 0;
                        transform: translateY(30px) scale(0.95);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0) scale(1);
                    }
                }

                .close-btn {
                    position: absolute;
                    top: 30px;
                    left: 30px;
                    width: 36px;
                    height: 36px;
                    background-color: var(--btn-red);
                    border-radius: 50%;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    color: white;
                    text-decoration: none;
                    font-weight: bold;
                    transition: transform 0.2s;
                    z-index: 10;
                }

                .close-btn:hover {
                    transform: rotate(90deg) scale(1.1);
                }

                /* Progress Bar */
                .progress-container {
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 8px;
                    background: rgba(0, 0, 0, 0.05);
                    border-radius: 40px 40px 0 0;
                    overflow: hidden;
                }

                .progress-fill {
                    height: 100%;
                    background: linear-gradient(90deg, var(--input-bg), var(--highlight));
                    width: calc((var(--current-page) / var(--total-pages)) * 100%);
                    transition: width 0.5s cubic-bezier(0.4, 0, 0.2, 1);
                }

                .progress-text {
                    position: absolute;
                    top: 40px;
                    right: 40px;
                    font-weight: 700;
                    color: var(--input-bg);
                    font-size: 14px;
                    letter-spacing: 1px;
                }

                .card-header {
                    text-align: center;
                    margin-bottom: 45px;
                }

                h1 {
                    font-size: 34px;
                    font-weight: 800;
                    margin-bottom: 12px;
                    background: linear-gradient(to right, var(--text-dark), var(--input-bg));
                    -webkit-background-clip: text;
                    background-clip: text;
                    -webkit-text-fill-color: transparent;
                }

                .question-block {
                    margin-bottom: 40px;
                    padding: 25px;
                    background: rgba(255, 255, 255, 0.4);
                    border-radius: 20px;
                    border: 1px solid rgba(255, 255, 255, 0.5);
                    transition: all 0.3s;
                }

                .question-block:hover {
                    transform: translateX(10px);
                    background: rgba(255, 255, 255, 0.6);
                }

                .question-text {
                    font-size: 19px;
                    font-weight: 700;
                    margin-bottom: 25px;
                    display: block;
                    color: var(--text-dark);
                }

                .options-group {
                    display: flex;
                    flex-direction: column;
                    gap: 12px;
                }

                .option-label {
                    background: white;
                    padding: 18px 25px;
                    border-radius: 15px;
                    cursor: pointer;
                    display: flex;
                    align-items: center;
                    gap: 15px;
                    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                    border: 1px solid transparent;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.02);
                }

                .option-label:hover {
                    transform: scale(1.02);
                    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.05);
                    border-color: var(--highlight);
                    background: #fdfdfd;
                }

                .option-label input[type="radio"] {
                    width: 20px;
                    height: 20px;
                    accent-color: var(--input-bg);
                }

                .option-label span {
                    font-size: 16px;
                    font-weight: 500;
                }

                .option-label:has(input:checked) {
                    background: var(--input-bg);
                    color: white;
                    border-color: var(--input-bg);
                }

                .option-label:has(input:checked) span {
                    color: white;
                }

                /* Footer Actions */
                .footer-nav {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-top: 40px;
                }

                .back-arrow {
                    width: 60px;
                    height: 60px;
                    border-radius: 50%;
                    background: white;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    text-decoration: none;
                    color: var(--input-bg);
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
                    transition: all 0.2s;
                    font-size: 24px;
                }

                .back-arrow:hover {
                    transform: translateX(-5px);
                    background: var(--input-bg);
                    color: white;
                }

                .submit-btn {
                    background: var(--input-bg);
                    color: white;
                    padding: 16px 50px;
                    border-radius: 20px;
                    font-weight: 800;
                    font-size: 17px;
                    border: none;
                    cursor: pointer;
                    transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                    box-shadow: 0 10px 20px rgba(1, 59, 70, 0.2);
                }

                .submit-btn:hover {
                    transform: translateY(-3px) scale(1.05);
                    box-shadow: 0 15px 30px rgba(1, 59, 70, 0.3);
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
                <div class="assessment-card">
                    <div class="progress-container">
                        <div class="progress-fill"></div>
                    </div>
                    <div class="progress-text">
                        STEP ${currentPage} / ${totalPages}
                    </div>

                    <a href="${pageContext.request.contextPath}/assessment/select-module" class="close-btn">✕</a>

                    <div class="card-header">
                        <h1>${title}</h1>
                        <p class="subtitle">Please answer the following questions honestly.</p>
                    </div>

                    <form action="${pageContext.request.contextPath}/assessment/submit" method="post">
                        <input type="hidden" name="title" value="${title}">
                        <input type="hidden" name="currentPage" value="${currentPage}">
                        <input type="hidden" name="totalPages" value="${totalPages}">

                        <c:forEach var="q" items="${questions}" varStatus="status">
                            <div class="question-block">
                                <input type="hidden" name="qt_${q.id}" value="${q.questionText}">
                                <span class="question-text">${q.questionText}</span>
                                <div class="options-group">
                                    <c:forEach var="opt" items="${q.options}">
                                        <label class="option-label">
                                            <input type="radio" name="qa_${q.id}"
                                                value="${opt.optionText}|${opt.scoreValue}" required>
                                            <span>${opt.optionText}</span>
                                        </label>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>

                        <div class="footer-nav">
                            <c:choose>
                                <c:when test="${currentPage > 1}">
                                    <a href="${pageContext.request.contextPath}/assessment/questions?title=${title}&page=${currentPage - 1}"
                                        class="back-arrow">&larr;</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/assessment/select-module"
                                        class="back-arrow">&larr;</a>
                                </c:otherwise>
                            </c:choose>

                            <button type="submit" class="submit-btn">
                                <c:choose>
                                    <c:when test="${currentPage == totalPages}">Submit Assessment</c:when>
                                    <c:otherwise>Next Page &rarr;</c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </body>

        </html>