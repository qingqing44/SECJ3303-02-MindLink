<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forum Detail - Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #FFF3E0;
            --text-dark: #003049;
            --card-bg: #FFFFFF;
            --btn-blue: #00313e;
            --btn-grey: #E0E0E0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            margin: 0;
            padding: 20px;
            color: var(--text-dark);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .logo {
            font-size: 24px;
            font-weight: 800;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
        }

        .btn-secondary {
            background-color: var(--btn-grey);
            color: #333;
        }

        .btn-secondary:hover {
            background-color: #d0d0d0;
        }

        .forum-info-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .forum-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 15px;
            color: var(--text-dark);
        }

        .forum-description {
            font-size: 16px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .forum-meta {
            font-size: 14px;
            color: #999;
            display: flex;
            gap: 20px;
        }

        .posts-section {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .section-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--text-dark);
        }

        .post-card {
            background: #f9f9f9;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
        }

        .post-author {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-dark);
        }

        .post-content {
            font-size: 14px;
            color: #555;
            line-height: 1.6;
            margin-bottom: 10px;
        }

        .post-meta {
            font-size: 12px;
            color: #999;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #666;
        }
    </style>
</head>
<body>

    <div class="header">
        <div class="logo">MindLink Admin - Forum Detail</div>
        <a href="${pageContext.request.contextPath}/admin/forum/manage" class="btn btn-secondary">←</a>
    </div>

    <c:if test="${not empty forum}">
        <div class="forum-info-card">
            <div class="forum-title">${forum.title}</div>
            <div class="forum-description">${forum.description}</div>
            <div class="forum-meta">
                <span>Created by: <b>${forum.createdBy}</b></span>
                <c:if test="${not empty forum.createdAt}">
                    <span>• 
                        <fmt:formatDate value="${forum.createdAt}" pattern="MMM dd, yyyy 'at' HH:mm" />
                    </span>
                </c:if>
                <span>• Status: <b>${forum.status}</b></span>
                <span>• Posts: <b>${postCount}</b></span>
            </div>
        </div>

        <div class="posts-section">
            <div class="section-title">Posts (${postCount})</div>
            
            <c:choose>
                <c:when test="${empty posts || postCount == 0}">
                    <div class="empty-state">
                        <p>No posts in this forum yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="post" items="${posts}">
                        <div class="post-card">
                            <div class="post-author">${post.userName} (${post.userId})</div>
                            <div class="post-content">${post.content}</div>
                            <div class="post-meta">
                                <c:if test="${not empty post.createdAt}">
                                    <fmt:formatDate value="${post.createdAt}" pattern="MMM dd, yyyy 'at' HH:mm" />
                                </c:if>
                                <c:if test="${not empty post.status}">
                                    • Status: <b>${post.status}</b>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

</body>
</html>

