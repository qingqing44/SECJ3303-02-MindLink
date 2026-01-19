<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Admin Portal - MindLink</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
        <style>
            :root {
                --bg-color: #FFF3E0;
                --text-dark: #003049;
                --card-bg: #FFFFFF;
                --btn-yellow: #F2C94C;
                --btn-teal: #48C9B0;
                --btn-pink: #F497AA;
                --btn-blue: #00313e;
                --btn-purple: #9B59B6;
                --btn-orange: #E67E22;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--bg-color);
                margin: 0;
                padding: 0;
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
                max-width: 1400px;
                /* Increased width to give cards breathing room */
                margin: 60px auto;
                text-align: center;
                position: relative;
                z-index: 10;
                padding: 0 40px;
            }

            h1 {
                font-size: 48px;
                font-weight: 800;
                margin-bottom: 60px;
                color: var(--text-dark);
            }

            /* --- UPDATED GRID LAYOUT --- */
            .cards-grid {
                display: grid;
                /* 3 columns for 6 cards (2 rows) */
                grid-template-columns: repeat(3, 1fr);
                gap: 40px;
                /* Space between cards */
                width: 100%;
            }

            .admin-card {
                background: var(--card-bg);
                border-radius: 40px;
                padding: 50px 30px;
                width: auto;
                min-height: 400px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                text-align: center;
                transition: transform 0.2s;
                position: relative;
            }

            .admin-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
            }

            .card-icon {
                font-size: 64px;
                margin-bottom: 25px;
                line-height: 1;
            }

            .card-title {
                font-size: 32px;
                font-weight: 800;
                margin-bottom: 20px;
                color: var(--text-dark);
                line-height: 1.2;
            }

            .card-desc {
                font-size: 16px;
                color: #666;
                line-height: 1.8;
                margin-bottom: 35px;
                max-width: 280px;
            }

            .card-features {
                font-size: 14px;
                color: #888;
                margin-bottom: 35px;
                line-height: 1.8;
            }

            .card-features ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .card-features li {
                margin-bottom: 8px;
            }

            .card-features li:before {
                content: "✓ ";
                color: var(--btn-teal);
                font-weight: 700;
                margin-right: 8px;
            }

            /* Buttons */
            .btn {
                padding: 12px 50px;
                border-radius: 30px;
                border: none;
                color: white;
                font-size: 18px;
                font-weight: 600;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
            }

            .btn-yellow {
                background-color: var(--btn-yellow);
            }

            .btn-teal {
                background-color: var(--btn-teal);
            }

            .btn-pink {
                background-color: var(--btn-pink);
            }

            .btn-blue {
                background-color: var(--btn-blue);
            }

            .btn-purple {
                background-color: var(--btn-purple);
            }

            .btn-orange {
                background-color: var(--btn-orange);
            }

            .btn:hover {
                opacity: 0.9;
            }

            /* Decorative Background Shapes */
            .shape {
                position: absolute;
                z-index: 1;
                pointer-events: none;
            }

            .shape-left {
                top: 20%;
                left: -5%;
                width: 250px;
                opacity: 0.8;
            }

            .shape-right-bottom {
                bottom: -10%;
                right: -5%;
                width: 300px;
                opacity: 0.8;
            }

            /* Responsive: Switch to vertical stack only on small screens */
            @media (max-width: 900px) {
                .cards-grid {
                    grid-template-columns: 1fr;
                    /* 1 Column stack */
                    max-width: 400px;
                    margin: 0 auto;
                }
            }
        </style>
    </head>

    <body>
        <!-- Header Navigation -->
        <div class="header">
            <div class="nav-left">
                <a href="${pageContext.request.contextPath}/admin/home">Home</a>
                <a href="${pageContext.request.contextPath}/admin/modules/dashboard">Module</a>
            </div>

            <a href="${pageContext.request.contextPath}/admin/home" class="logo">
                <div class="logo-icon">
                    <img src="${pageContext.request.contextPath}/images/mindlink.png" alt="MindLink">
                </div>
                <span>MindLink</span>
            </a>

            <div class="nav-right">
                <a href="${pageContext.request.contextPath}/admin/user-management">User Management</a>
                <a href="${pageContext.request.contextPath}/admin/profile">Profile</a>
            </div>
        </div>

        <img src="${pageContext.request.contextPath}/images/assessment-left.png" class="shape shape-left" alt="">
        <img src="${pageContext.request.contextPath}/images/assessment-right.png" class="shape shape-right-bottom"
            alt="">

        <div class="container">

            <h1>Welcome back, Admin123!</h1>

            <div class="cards-grid">

                <div class="admin-card">
                    <div class="card-icon">📚</div>
                    <div class="card-title">Learning<br>Module</div>
                    <p class="card-desc">Practical tips on stress management, mindfulness, and emotional resilience for
                        students.</p>
                    <div class="card-features">
                        <ul>
                            <li>Create modules</li>
                            <li>Manage content</li>
                            <li>Track progress</li>
                        </ul>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/modules" class="btn btn-yellow">Update</a>
                </div>

                <div class="admin-card">
                    <div class="card-icon">📝</div>
                    <div class="card-title">Self<br>Assessment</div>
                    <p class="card-desc">Set up self assessment questions for students to evaluate their mental health
                        status.</p>
                    <div class="card-features">
                        <ul>
                            <li>Create questions</li>
                            <li>View results</li>
                            <li>Analyze data</li>
                        </ul>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/assessment/select-module"
                        class="btn btn-teal">Update</a>
                </div>

                <div class="admin-card">
                    <div class="card-icon">📊</div>
                    <div class="card-title">Analytics</div>
                    <p class="card-desc">Review comprehensive graphs and insights about user engagement and system
                        usage.</p>
                    <div class="card-features">
                        <ul>
                            <li>User statistics</li>
                            <li>Activity reports</li>
                            <li>Trend analysis</li>
                        </ul>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/analytics" class="btn btn-pink">Review</a>
                </div>

                <div class="admin-card">
                    <div class="card-icon">🤖</div>
                    <div class="card-title">Chatbot</div>
                    <p class="card-desc">Manage chatbot rules and responses to provide automated assistance to users.
                    </p>
                    <div class="card-features">
                        <ul>
                            <li>Add keywords</li>
                            <li>Edit responses</li>
                            <li>Monitor usage</li>
                        </ul>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/chatbot" class="btn btn-blue">Manage</a>
                </div>

                <div class="admin-card">
                    <div class="card-icon">💡</div>
                    <div class="card-title">Daily<br>Tips</div>
                    <p class="card-desc">Create and manage daily mental health tips to inspire and support students.</p>
                    <div class="card-features">
                        <ul>
                            <li>Create tips</li>
                            <li>Edit content</li>
                            <li>Schedule posts</li>
                        </ul>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/tips" class="btn btn-purple">Manage</a>
                </div>

                <div class="admin-card">
                    <div class="card-icon">💬</div>
                    <div class="card-title">Forum</div>
                    <p class="card-desc">Manage community forums, posts, comments, and handle reported content.</p>
                    <div class="card-features">
                        <ul>
                            <li>Manage forums</li>
                            <li>Review posts</li>
                            <li>Handle reports</li>
                        </ul>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/forum/manage" class="btn btn-orange">Manage</a>
                </div>

                <div class="admin-card">
                    <div class="card-icon">🏆</div>
                    <div class="card-title">Achievements</div>
                    <p class="card-desc">Manage achievement badges and criteria for student gamification.</p>
                    <div class="card-features">
                        <ul>
                            <li>View badges</li>
                            <li>Add criteria</li>
                            <li>Update goals</li>
                        </ul>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/achievements" class="btn btn-teal">Manage</a>
                </div>

            </div>

        </div>
        </div>

    </body>

    </html>