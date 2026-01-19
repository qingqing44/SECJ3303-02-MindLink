<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Select Module - MindLink</title>
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
                    background: #FFE6D0;
                    padding: 60px 100px;
                    /* Match the home page height calc */
                    min-height: calc(100vh - 81px);
                    position: relative;
                    overflow: hidden;

                    /* Use Assessment Images as background, matching Home pattern */
                    background-image: url('${pageContext.request.contextPath}/images/assessment-left.png'),
                    url('${pageContext.request.contextPath}/images/assessment-right.png');

                    /* Adjust positions to look good (similar to left bottom/right bottom but tailored for these images) */
                    background-position: left center, right center;
                    background-repeat: no-repeat, no-repeat;
                    /* Adjust size if needed, 'contain' or specific width might be better depending on image */
                    background-size: 35% auto, 35% auto;

                    display: flex;
                    justify-content: center;
                    align-items: center;
                }

                /* Welcome Content */
                .welcome-content {
                    text-align: center;
                    position: relative;
                    z-index: 2;
                    max-width: 800px;
                }

                .welcome-title {
                    font-size: 64px;
                    color: #003049;
                    font-weight: 800;
                    margin-bottom: 50px;
                    line-height: 1.2;
                }

                .btn-start {
                    display: inline-block;
                    background-color: #003049;
                    color: white;
                    padding: 18px 50px;
                    border-radius: 40px;
                    font-size: 18px;
                    font-weight: 600;
                    text-decoration: none;
                    transition: transform 0.2s, background-color 0.3s;
                }

                .btn-start:hover {
                    transform: scale(1.05);
                    background-color: #004566;
                }

                /* Responsive */
                @media (max-width: 1200px) {
                    .header {
                        padding: 20px 50px;
                    }

                    .container {
                        padding: 50px;
                        /* Fade out background images on smaller screens if they crowd text */
                        background-size: 20% auto, 20% auto;
                    }
                }

                @media (max-width: 768px) {
                    .header {
                        flex-direction: column;
                        gap: 15px;
                    }

                    .nav-left,
                    .nav-right {
                        gap: 20px;
                    }

                    .welcome-title {
                        font-size: 40px;
                    }

                    .container {
                        background-image: none;
                        /* Hide images on mobile for clarity */
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

            <!-- Main Container -->
            <div class="container">
                <!-- Center Content -->
                <div class="welcome-content">
                    <h1 class="welcome-title">Select an <br> Assessment Module</h1>
                    <div class="module-list" style="display: flex; gap: 20px; flex-direction: column;">
                        <c:forEach var="module" items="${modules}">
                            <a href="${pageContext.request.contextPath}/assessment/questions?title=${module}"
                                class="btn-start" style="width: 100%; text-align: center;">
                                ${module} &nbsp; &rarr;
                            </a>
                        </c:forEach>

                        <c:if test="${empty modules}">
                            <p style="text-align: center; color: #666;">No assessment modules available at this time.
                            </p>
                        </c:if>
                    </div>
                </div>
            </div>

            <script>
                // Copy smooth animation script from home page for consistency
                window.addEventListener('load', function () {
                    const container = document.querySelector('.welcome-content'); // Animate content
                    container.style.opacity = '0';
                    setTimeout(function () {
                        container.style.transition = 'opacity 0.8s';
                        container.style.opacity = '1';
                    }, 100);
                });
            </script>
        </body>

        </html>