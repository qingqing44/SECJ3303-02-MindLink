<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Forums - Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg-color: #FFF3E0;
            --text-dark: #003049;
            --btn-blue: #00313e;
            --btn-green: #48C9B0;
            --btn-red: #FF6B6B;
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
            margin-bottom: 30px;
        }

        h1 {
            font-size: 36px;
            font-weight: 800;
            color: var(--text-dark);
            margin: 0;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
            display: inline-block;
        }

        .btn-primary {
            background-color: var(--btn-blue);
            color: white;
        }

        .btn-primary:hover {
            background-color: #004d61;
        }

        .btn-back {
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

        .btn-back:hover {
            background: #F77F00;
            color: white;
            transform: translateX(-5px);
        }

        .btn-edit {
            background-color: var(--btn-green);
            color: white;
            padding: 8px 16px;
            font-size: 13px;
        }

        .btn-edit:hover {
            background-color: #3ab89a;
        }

        .btn-view {
            background-color: var(--btn-blue);
            color: white;
            padding: 8px 16px;
            font-size: 13px;
        }

        .btn-view:hover {
            background-color: #004d61;
        }

        .btn-delete {
            background-color: var(--btn-red);
            color: white;
            padding: 8px 16px;
            font-size: 13px;
        }

        .btn-delete:hover {
            background-color: #e55a5a;
        }

        .forums-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .forum-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .forum-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        .forum-info {
            flex: 1;
        }

        .forum-title {
            font-size: 22px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 8px;
        }

        .forum-description {
            font-size: 14px;
            color: #666;
            margin-bottom: 12px;
            line-height: 1.6;
        }

        .forum-meta {
            font-size: 12px;
            color: #999;
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .forum-status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }

        .status-active {
            background: #E8F5E9;
            color: #2E7D32;
        }

        .status-closed {
            background: #FFF3E0;
            color: #E67E22;
        }

        .status-archived {
            background: #F3E5F5;
            color: #7B1FA2;
        }

        .forum-actions {
            display: flex;
            gap: 10px;
            align-items: center;
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

        .search-container {
            display: flex;
            gap: 12px;
            align-items: center;
            margin-bottom: 20px;
            background: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .search-input {
            flex: 1;
            padding: 10px 15px;
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

        .search-btn {
            padding: 10px 20px;
            background-color: var(--btn-blue);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .search-btn:hover {
            background-color: #004d61;
        }

        .clear-btn {
            padding: 10px 20px;
            background-color: #E0E0E0;
            color: #333;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.2s;
        }

        .clear-btn:hover {
            background-color: #d0d0d0;
        }

        .forum-id {
            display: inline-block;
            background: #E3F2FD;
            color: #1976D2;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 700;
            margin-right: 8px;
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
        <a href="${pageContext.request.contextPath}/admin/home" class="btn-back" title="Back">
            <i class="fas fa-arrow-left"></i>
        </a>

        <div class="page-header">
            <h1>Manage Forums</h1>
            <a href="${pageContext.request.contextPath}/admin/forum/create-form" class="btn btn-primary">+ Create New Forum</a>
        </div>

        <form method="get" action="${pageContext.request.contextPath}/admin/forum/manage" class="search-container">
            <input type="text" 
                   name="search" 
                   class="search-input" 
                   placeholder="Search by ID or forum name..." 
                   value="${searchQuery}">
            <button type="submit" class="search-btn">🔍 Search</button>
            <c:if test="${not empty searchQuery}">
                <a href="${pageContext.request.contextPath}/admin/forum/manage" class="clear-btn">Clear</a>
            </c:if>
        </form>

        <div class="forums-container">
            <c:choose>
                <c:when test="${empty forums}">
                    <div class="empty-state">
                        <p style="font-size: 48px; margin-bottom: 20px;">📭</p>
                        <p style="font-size: 20px; font-weight: 600; margin-bottom: 10px;">No forums found</p>
                        <p>Click "Create New Forum" to get started.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="forum" items="${forums}">
                        <div class="forum-card">
                            <div class="forum-info">
                                <div class="forum-title">
                                    <span class="forum-id">ID: ${forum.id}</span>
                                    <c:out value="${forum.title}" />
                                </div>
                                <div class="forum-description"><c:out value="${forum.description}" /></div>
                                <div class="forum-meta">
                                    <span>Created by: <b><c:out value="${forum.createdBy}" /></b></span>
                                    <c:if test="${not empty forum.createdAt}">
                                        <span>• 
                                            <%
                                                com.mindlink.forum.model.Forum f = (com.mindlink.forum.model.Forum) pageContext.findAttribute("forum");
                                                if (f != null && f.getCreatedAt() != null) {
                                                    out.print(f.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy")));
                                                }
                                            %>
                                        </span>
                                    </c:if>
                                    <c:set var="status" value="${forum.status != null ? forum.status : 'active'}" />
                                    <span class="forum-status status-${status}"><c:out value="${status}" /></span>
                                </div>
                            </div>
                            <div class="forum-actions">
                                <a href="${pageContext.request.contextPath}/admin/forum/posts?forumId=${forum.id}" class="btn btn-view">View Posts</a>
                                <a href="${pageContext.request.contextPath}/admin/forum/edit-form?id=${forum.id}" class="btn btn-edit">Edit</a>
                                <a href="${pageContext.request.contextPath}/admin/forum/delete?id=${forum.id}" 
                                   class="btn btn-delete"
                                   onclick="return confirm('Are you sure you want to delete this forum? This will also delete all posts and comments. This action cannot be undone.');">
                                   Delete</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
