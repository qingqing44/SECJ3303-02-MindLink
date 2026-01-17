<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reported Comments - Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg-color: #FFF3E0;
            --text-dark: #003049;
            --btn-blue: #00313e;
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
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 40px;
        }

        .page-header {
            display: flex;
            align-items: center;
            gap: 16px;
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
            margin: 0;
            font-size: 34px;
            font-weight: 800;
        }

        .table-container {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.06);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: var(--btn-blue);
            color: white;
        }

        th, td {
            padding: 14px 16px;
            text-align: left;
            vertical-align: top;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
        }

        .content-preview {
            max-width: 520px;
            white-space: normal;
            line-height: 1.45;
            color: #333;
        }

        .reason-tag {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 999px;
            background: #FFF3CD;
            color: #856404;
            font-weight: 700;
            font-size: 12px;
        }

        .action-btn {
            display: inline-block;
            padding: 10px 14px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            margin-right: 8px;
            transition: all 0.2s;
        }

        .btn-delete {
            background: var(--btn-red);
            color: white;
        }

        .btn-dismiss {
            background: #f0f0f0;
            color: #333;
        }

        .action-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.10);
        }

        .empty-state {
            padding: 40px;
            text-align: center;
            color: #777;
        }

        .meta {
            font-size: 12px;
            color: #666;
            margin-top: 6px;
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
        <div class="page-header">
            <a href="${pageContext.request.contextPath}/admin/forum/posts" class="back-btn" title="Back to Forum Posts">←</a>
            <h1>Reported Comments</h1>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Author</th>
                        <th>Comment</th>
                        <th>Post Context</th>
                        <th>Reason</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty reports}">
                        <tr>
                            <td colspan="6">
                                <div class="empty-state">No reported comments.</div>
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach items="${reports}" var="item">
                        <tr>
                            <td><c:out value="${item.date}" /></td>
                            <td><b><c:out value="${item.author}" /></b></td>
                            <td><div class="content-preview"><c:out value="${item.content}" /></div></td>
                            <td>
                                <div class="content-preview"><c:out value="${item.postContent}" /></div>
                                <div class="meta">Post ID: <c:out value="${item.postId}" /></div>
                            </td>
                            <td><span class="reason-tag"><c:out value="${item.reason}" /></span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/forum/comments/reports/delete?id=${item.id}"
                                   class="action-btn btn-delete"
                                   onclick="return confirm('Delete this comment? This action cannot be undone.');">
                                   Delete
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/forum/comments/reports/dismiss?id=${item.id}"
                                   class="action-btn btn-dismiss">
                                   Dismiss
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>


