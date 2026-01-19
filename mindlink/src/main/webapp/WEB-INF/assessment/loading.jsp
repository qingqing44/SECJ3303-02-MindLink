<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Calculating Score...</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
        <style>
            :root {
                --bg-color: #FFF3E0;
                --text-dark: #003049;
                --text-green: #4CAF50;
                /* Green color for the subtext */
                --card-bg: #FFF8F0;
                /* Slightly lighter beige for card */
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-color);
                color: var(--text-dark);
            }

            /* Navbar */
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

            .navbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 40px;
            }

            .nav-links a {
                text-decoration: none;
                color: var(--text-dark);
                margin: 0 15px;
                font-weight: 600;
            }

            .logo {
                font-size: 32px;
                font-weight: 800;
                color: var(--text-dark);
            }

            /* Container */
            .container {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 80vh;
            }

            /* The Card */
            .loading-card {
                background-color: #FFF9F2;
                /* Very light beige card */
                width: 100%;
                max-width: 600px;
                /* Made smaller as requested */
                padding: 60px 40px;
                border-radius: 60px;
                /* Very round corners like screenshot */
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                text-align: center;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
            }

            /* Typography */
            h1 {
                font-size: 36px;
                font-weight: 800;
                margin-bottom: 15px;
                color: #000;
            }

            .subtext {
                font-size: 18px;
                color: var(--text-green);
                font-weight: 500;
                margin-bottom: 40px;
            }

            /* Image Animation */
            .loading-img {
                width: 200px;
                height: auto;
                opacity: 0.9;
                /* Optional: Add a subtle pulse animation */
                animation: pulse 2s infinite ease-in-out;
            }

            @keyframes pulse {
                0% {
                    transform: scale(1);
                    opacity: 0.9;
                }

                50% {
                    transform: scale(1.05);
                    opacity: 1;
                }

                100% {
                    transform: scale(1);
                    opacity: 0.9;
                }
            }
        </style>
    </head>

    <body>

        <!-- Header Navigation -->
        <div class="header"
            style="padding: 20px 100px; display: flex; justify-content: space-between; align-items: center; background: white;">
            <div class="nav-left" style="display: flex; align-items: center; justify-content: space-evenly; flex: 1;">
                <a href="${pageContext.request.contextPath}/home"
                    style="text-decoration: none; color: #00313e; font-size: 16px; font-weight: 500;">Home</a>
                <a href="${pageContext.request.contextPath}/learning"
                    style="text-decoration: none; color: #00313e; font-size: 16px; font-weight: 500; margin-left: 20px;">Learning</a>
            </div>

            <a href="${pageContext.request.contextPath}/home" class="logo"
                style="display: flex; align-items: center; gap: 10px; font-weight: 700; color: #00313e; font-size: 32px; text-decoration: none;">
                <div class="logo-icon"
                    style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
                    <img src="${pageContext.request.contextPath}/images/mindlink.png" alt="MindLink"
                        style="width: 100%; height: 100%; object-fit: contain;">
                </div>
                <span>MindLink</span>
            </a>

            <div class="nav-right" style="display: flex; align-items: center; justify-content: space-evenly; flex: 1;">
                <a href="${pageContext.request.contextPath}/forum/welcome"
                    style="text-decoration: none; color: #00313e; font-size: 16px; font-weight: 500;">Forum</a>
                <a href="${pageContext.request.contextPath}/profile"
                    style="text-decoration: none; color: #00313e; font-size: 16px; font-weight: 500; margin-left: 20px;">Profile</a>
            </div>
        </div>
        <br><br>
        <div class="container">
            <div class="loading-card">

                <h1>Please wait for a while...</h1>
                <div class="subtext">We're calculating your score 🍃</div>

                <img src="${pageContext.request.contextPath}/images/thinking-statue.png" alt="Thinking..."
                    class="loading-img">

            </div>
        </div>

        <script>
            // Wait for 3000 milliseconds (3 seconds), then go to result page
            setTimeout(function () {
                window.location.href = "${pageContext.request.contextPath}/assessment/result";
            }, 3000);
        </script>

    </body>

    </html>