<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Manage Achievements</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
            <style>
                :root {
                    --bg-color: #FFF3E0;
                    --text-dark: #003049;
                    --accent: #48C9B0;
                    --glass: rgba(255, 255, 255, 0.8);
                    --danger: #FF6B6B;
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background-color: var(--bg-color);
                    margin: 0;
                    color: var(--text-dark);
                }

                /* Header Navigation */
                .header {
                    padding: 20px 100px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    background: white;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                    margin-bottom: 50px;
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
                    color: var(--accent);
                }

                .logo {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    font-weight: 700;
                    font-size: 32px;
                    text-decoration: none;
                    color: #00313e;
                }

                .logo-icon {
                    width: 40px;
                    height: 40px;
                }

                .logo-icon img {
                    width: 100%;
                    height: 100%;
                    object-fit: contain;
                }

                .container {
                    max-width: 1000px;
                    margin: 40px auto;
                    padding: 0 20px;
                }

                .page-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 30px;
                }

                .btn-add {
                    background: var(--accent);
                    color: white;
                    padding: 12px 24px;
                    border-radius: 30px;
                    text-decoration: none;
                    font-weight: 700;
                    transition: transform 0.2s;
                }

                .btn-add:hover {
                    transform: scale(1.05);
                }

                .achievement-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                    gap: 25px;
                }

                .achievement-card {
                    background: var(--glass);
                    backdrop-filter: blur(10px);
                    padding: 25px;
                    border-radius: 20px;
                    border: 1px solid rgba(255, 255, 255, 0.4);
                    transition: transform 0.2s;
                    position: relative;
                }

                .achievement-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                }

                .badge-icon {
                    width: 60px;
                    height: 60px;
                    background: #eee;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 24px;
                    margin-bottom: 15px;
                }

                .badge-icon img {
                    width: 100%;
                    height: 100%;
                    object-fit: contain;
                }

                .card-title {
                    font-size: 20px;
                    font-weight: 800;
                    margin-bottom: 5px;
                }

                .card-desc {
                    font-size: 14px;
                    color: #666;
                    margin-bottom: 15px;
                    line-height: 1.5;
                }

                .metadata {
                    font-size: 12px;
                    color: #888;
                    background: rgba(0, 0, 0, 0.05);
                    padding: 5px 10px;
                    border-radius: 10px;
                    display: inline-block;
                    margin-bottom: 15px;
                }

                .actions {
                    display: flex;
                    justify-content: flex-end;
                    gap: 10px;
                }

                .btn-action {
                    text-decoration: none;
                    color: #666;
                    font-size: 14px;
                    font-weight: 600;
                }

                .btn-delete {
                    color: var(--danger);
                }
            </style>
        </head>

        <body>
            <div class="header">
                <div class="nav-left">
                    <a href="${pageContext.request.contextPath}/admin/home">Home</a>
                    <a href="${pageContext.request.contextPath}/admin/achievements">Achievements</a>
                </div>
                <a href="${pageContext.request.contextPath}/admin/home" class="logo">
                    <div class="logo-icon"><img src="${pageContext.request.contextPath}/images/mindlink.png"></div>
                    <span>MindLink</span>
                </a>
                <div class="nav-right">
                    <a href="${pageContext.request.contextPath}/admin/user-management">Users</a>
                    <a href="${pageContext.request.contextPath}/admin/profile">Profile</a>
                </div>
            </div>

            <div class="container">
                <div class="page-header">
                    <h1>Achievement Badges</h1>
                    <a href="${pageContext.request.contextPath}/admin/achievements/add" class="btn-add">+ Create New
                        Badge</a>
                </div>

                <div class="achievement-grid">
                    <c:forEach items="${achievements}" var="a">
                        <div class="achievement-card">
                            <div class="badge-icon">
                                <img src="${pageContext.request.contextPath}/images/${a.iconPath}" alt="icon"
                                    onerror="this.src='https://via.placeholder.com/60?text=🏆'">
                            </div>
                            <div class="card-title">${a.title}</div>
                            <div class="metadata">ID: ${a.achievementType} | Target: ${a.targetValue}</div>
                            <div class="card-desc">${a.description}</div>

                            <div class="actions">
                                <a href="${pageContext.request.contextPath}/admin/achievements/edit?type=${a.achievementType}"
                                    class="btn-action">Edit</a>
                                <a href="${pageContext.request.contextPath}/admin/achievements/delete?type=${a.achievementType}"
                                    class="btn-action btn-delete"
                                    onclick="return confirm('Delete this achievement?')">Delete</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </body>

        </html>