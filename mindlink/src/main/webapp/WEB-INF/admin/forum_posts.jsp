<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forum Posts Management - Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg-color: #FFF3E0;
            --text-dark: #003049;
            --btn-red: #FF6B6B;
            --btn-blue: #00313e;
            --btn-green: #48C9B0;
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-color); 
            margin: 0; 
            padding: 0; 
            color: var(--text-dark); 
        }

        .header {
            padding: 20px 100px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            border-bottom: 1px solid #e0e0e0;
        }

        .nav-left, .nav-right {
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
        }

        .logo-icon img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 40px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: white;
            color: var(--text-dark);
            font-size: 18px;
            text-decoration: none;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
            transition: 0.2s;
        }

        .back-btn:hover {
            background: #F77F00;
            color: white;
            transform: translateX(-5px);
        }

        h1 {
            font-size: 36px;
            font-weight: 800;
            color: var(--text-dark);
            margin: 0;
        }

        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .filter-section label {
            font-weight: 600;
            margin-right: 10px;
        }

        .filter-section select {
            padding: 8px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            margin-right: 15px;
        }

        .search-input {
            flex: 1;
            min-width: 200px;
            padding: 8px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            font-family: 'Inter', sans-serif;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--btn-blue);
            box-shadow: 0 0 0 3px rgba(0, 49, 62, 0.1);
        }

        .clear-btn {
            padding: 8px 16px;
            background-color: #E0E0E0;
            color: #333;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.2s;
        }

        .clear-btn:hover {
            background-color: #d0d0d0;
        }

        .search-button {
            padding: 8px 20px;
            background-color: var(--btn-blue);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .search-button:hover {
            background-color: #004d61;
        }

        .post-id {
            display: inline-block;
            background: #E3F2FD;
            color: #1976D2;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 700;
            margin-right: 8px;
        }

        .btn {
            padding: 8px 20px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 14px;
            display: inline-block;
            transition: all 0.2s;
        }

        .btn-primary {
            background: var(--btn-blue);
            color: white;
        }

        .btn-primary:hover {
            background: #004d61;
        }

        .btn-danger {
            background: var(--btn-red);
            color: white;
        }

        .btn-danger:hover {
            background: #e55a5a;
        }

        .btn-small {
            padding: 6px 12px;
            font-size: 12px;
        }

        .posts-container {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        .post-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .post-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }

        .post-meta {
            flex: 1;
        }

        .post-author {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 6px;
        }

        .post-info {
            font-size: 13px;
            color: #666;
            margin-bottom: 4px;
        }

        .post-forum {
            display: inline-block;
            background: #E3F2FD;
            color: #1976D2;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-top: 8px;
        }

        .post-actions {
            display: flex;
            gap: 10px;
        }

        .post-content {
            font-size: 15px;
            color: #555;
            line-height: 1.7;
            margin-bottom: 20px;
            padding: 15px;
            background: #f9f9f9;
            border-radius: 8px;
            white-space: pre-wrap;
            word-wrap: break-word;
        }

        .comments-section {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #f0f0f0;
        }

        .comments-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
            font-size: 16px;
            font-weight: 600;
            color: var(--text-dark);
        }

        .comment-item {
            background: #f9f9f9;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 12px;
            border-left: 3px solid var(--btn-green);
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 8px;
        }

        .comment-author {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-dark);
        }

        .comment-info {
            font-size: 12px;
            color: #666;
        }

        .comment-content {
            font-size: 14px;
            color: #555;
            line-height: 1.6;
            margin-top: 8px;
        }

        .comment-actions {
            display: flex;
            gap: 8px;
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .empty-state p {
            font-size: 16px;
            color: #666;
            margin: 10px 0;
        }

        .stats {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            gap: 40px;
            font-size: 14px;
        }

        .stat-item {
            display: flex;
            flex-direction: column;
        }

        .stat-label {
            color: #666;
            font-size: 12px;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-value {
            font-size: 24px;
            font-weight: 700;
            color: var(--text-dark);
        }
    </style>
</head>
<body>
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

    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/forum/manage" class="back-btn" title="Back to Forums">
            <i class="fas fa-arrow-left"></i>
        </a>

        <div class="page-header">
            <h1>
                <c:choose>
                    <c:when test="${not empty forum}"><c:out value="${forum.title}" /> - Posts</c:when>
                    <c:otherwise>Forum Posts Management</c:otherwise>
                </c:choose>
            </h1>
        </div>

        <div class="filter-section">
            <form method="get" action="${pageContext.request.contextPath}/admin/forum/posts" style="display: flex; align-items: center; gap: 15px; flex-wrap: wrap;">
                <label for="forumId">Filter by Forum:</label>
                <select name="forumId" id="forumId" onchange="this.form.submit()">
                    <option value="">All Forums</option>
                    <c:forEach var="f" items="${forums}">
                        <option value="${f.id}" ${param.forumId == f.id ? 'selected' : ''}><c:out value="${f.title}" /></option>
                    </c:forEach>
                </select>
                <input type="text" name="search" placeholder="Search by Post ID..." value="${searchQuery != null ? searchQuery : ''}" class="search-input">
                <button type="submit" class="search-button">Search</button>
                <c:if test="${searchQuery != null && !searchQuery.isEmpty()}">
                    <a href="${pageContext.request.contextPath}/admin/forum/posts${param.forumId != null ? '?forumId=' : ''}${param.forumId != null ? param.forumId : ''}" class="clear-btn">Clear</a>
                </c:if>
            </form>
            <div style="display: flex; gap: 10px; margin-top: 15px;">
                <a href="${pageContext.request.contextPath}/admin/forum/posts" class="btn btn-primary">View All Posts</a>
                <a href="${pageContext.request.contextPath}/admin/forum/reports" class="btn btn-danger">⚠️ View Reported Posts</a>
                <a href="${pageContext.request.contextPath}/admin/forum/comments/reports" class="btn btn-danger">⚠️ View Reported Comments</a>
            </div>
        </div>

        <div class="stats">
            <div class="stat-item">
                <span class="stat-label">Total Posts</span>
                <span class="stat-value">${posts != null ? posts.size() : 0}</span>
            </div>
            <c:if test="${not empty forum}">
                <div class="stat-item">
                    <span class="stat-label">Forum</span>
                    <span class="stat-value" style="font-size: 18px;"><c:out value="${forum.title}" /></span>
                </div>
            </c:if>
        </div>

        <div class="posts-container">
            <c:choose>
                <c:when test="${empty posts}">
                    <div class="empty-state">
                        <p style="font-size: 48px; margin-bottom: 20px;">📭</p>
                        <p style="font-size: 20px; font-weight: 600; margin-bottom: 10px;">No posts found</p>
                        <p>There are no posts in ${not empty forum ? 'this forum' : 'any forum'} yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="post" items="${posts}">
                        <div class="post-card">
                            <div class="post-header">
                                <div class="post-meta">
                                    <div class="post-author">
                                        <span class="post-id">Post ID: ${post.id}</span>
                                        <c:out value="${post.userName}" />
                                        <c:if test="${post.anonymous}">
                                            <span style="background: #FFE6D0; color: #E67E22; padding: 2px 8px; border-radius: 12px; font-size: 11px; font-weight: 600; margin-left: 8px;">(Anonymous to users)</span>
                                        </c:if>
                                    </div>
                                    <div class="post-info">
                                        User ID: <c:out value="${post.userId}" />
                                        <c:if test="${post.anonymous}">
                                            <span style="color: #E67E22; margin-left: 8px;">• Posted anonymously to public</span>
                                        </c:if>
                                    </div>
                                    <c:if test="${not empty post.createdAt}">
                                        <div class="post-info">
                                            Posted: 
                                            <c:catch var="dateError">
                                                <fmt:parseDate value="${post.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
                                                <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy 'at' HH:mm" />
                                            </c:catch>
                                            <c:if test="${not empty dateError}">
                                                <c:out value="${post.createdAt}" />
                                            </c:if>
                                        </div>
                                    </c:if>
                                    <c:if test="${empty forum}">
                                        <c:forEach var="f" items="${forums}">
                                            <c:if test="${f.id == post.forumId}">
                                                <span class="post-forum"><c:out value="${f.title}" /></span>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </div>
                                <div class="post-actions">
                                    <c:set var="forumIdParam" value="${not empty param.forumId ? '&forumId=' : ''}${not empty param.forumId ? param.forumId : ''}" />
                                    <a href="${pageContext.request.contextPath}/admin/forum/posts/delete?id=${post.id}${forumIdParam}" 
                                       class="btn btn-danger btn-small"
                                       onclick="return confirm('Are you sure you want to delete this post? This will also delete all comments. This action cannot be undone.');">
                                       Delete Post
                                    </a>
                                </div>
                            </div>
                            <div class="post-content"><c:out value="${post.content}" /></div>
                            
                            <c:set var="postComments" value="${commentsMap[post.id]}" />
                            <c:choose>
                                <c:when test="${not empty postComments}">
                                    <div class="comments-section">
                                        <div class="comments-header">
                                            <span>💬 Comments (${postComments.size()})</span>
                                        </div>
                                        <c:forEach var="comment" items="${postComments}">
                                            <div class="comment-item">
                                                <div class="comment-header">
                                                    <div>
                                                        <div class="comment-author"><c:out value="${comment.userName}" /></div>
                                                        <div class="comment-info">User ID: <c:out value="${comment.userId}" /></div>
                                                        <c:if test="${not empty comment.createdAt}">
                                                            <div class="comment-info">
                                                                <c:catch var="dateError">
                                                                    <fmt:parseDate value="${comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
                                                                    <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy 'at' HH:mm" />
                                                                </c:catch>
                                                                <c:if test="${not empty dateError}">
                                                                    <c:out value="${comment.createdAt}" />
                                                                </c:if>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                    <div class="comment-actions">
                                                        <a href="${pageContext.request.contextPath}/admin/forum/comments/delete?id=${comment.id}${forumIdParam}" 
                                                           class="btn btn-danger btn-small"
                                                           onclick="return confirm('Are you sure you want to delete this comment? This action cannot be undone.');">
                                                           Delete
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="comment-content"><c:out value="${comment.content}" /></div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="comments-section">
                                        <div class="comments-header">
                                            <span>💬 No comments yet</span>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
