<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forum Reports - Admin</title>
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
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 40px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
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

        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(135deg, #FF6B6B 0%, #E55A5A 100%);
            color: white;
        }

        th {
            padding: 18px 20px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        th:first-child {
            width: 100px;
        }

        th:last-child {
            width: 200px;
            text-align: center;
        }

        tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: background-color 0.2s;
        }

        tbody tr:hover {
            background-color: #fff5f5;
        }

        tbody tr:last-child {
            border-bottom: none;
        }

        td {
            padding: 18px 20px;
            font-size: 14px;
            color: #555;
            vertical-align: top;
        }

        .date-cell {
            color: #999;
            font-weight: 500;
        }

        .author-cell {
            font-weight: 700;
            color: var(--text-dark);
        }

        .content-cell {
            color: #666;
            line-height: 1.6;
            max-width: 400px;
        }

        .content-preview {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .reason-cell {
            max-width: 300px;
        }

        .reason-tag {
            display: inline-block;
            background: #FFEBEE;
            color: #D32F2F;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            line-height: 1.4;
            word-wrap: break-word;
            max-width: 100%;
        }

        .status-cell {
            text-align: center;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: #FFF3E0;
            color: #E67E22;
        }

        .status-resolved {
            background: #E8F5E9;
            color: #2E7D32;
        }

        .actions-cell {
            text-align: center;
        }

        .action-btn {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s;
            margin: 0 4px;
        }

        .btn-delete {
            background-color: var(--btn-red);
            color: white;
        }

        .btn-delete:hover {
            background-color: #e55a5a;
            transform: translateY(-2px);
        }

        .btn-dismiss {
            background-color: #E0E0E0;
            color: #333;
        }

        .btn-dismiss:hover {
            background-color: #d0d0d0;
            transform: translateY(-2px);
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
        }

        .empty-state p {
            font-size: 16px;
            color: #666;
            margin: 10px 0;
        }

        .empty-icon {
            font-size: 64px;
            margin-bottom: 20px;
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
        <a href="${pageContext.request.contextPath}/admin/forum/posts" class="back-btn" title="Back to Forum Posts">
            <i class="fas fa-arrow-left"></i>
        </a>

        <div class="page-header">
            <h1>Reported Posts</h1>
        </div>

        <div class="table-container">
            <c:choose>
                <c:when test="${empty reports}">
                    <div class="empty-state">
                        <div class="empty-icon">✅</div>
                        <p style="font-size: 20px; font-weight: 600; margin-bottom: 10px;">No reported posts found</p>
                        <p>Great job! There are no reported posts to review.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Author</th>
                                <th>Content</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${reports}" var="item">
                                <tr>
                                    <td class="date-cell">${item.date}</td>
                                    <td class="author-cell"><c:out value="${item.author}" /></td>
                                    <td class="content-cell">
                                        <div class="content-preview">
                                            <c:out value="${item.content}" />
                                        </div>
                                    </td>
                                    <td class="reason-cell">
                                        <span class="reason-tag">
                                            <c:choose>
                                                <c:when test="${not empty item.reason && item.reason != 'No reason provided' && item.reason != ''}">
                                                    <c:out value="${item.reason}" />
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #999; font-style: italic;">No reason provided</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>
                                    <td class="status-cell">
                                        <span class="status-badge ${item.status == 'Pending' ? 'status-pending' : 'status-resolved'}">
                                            ${item.status}
                                        </span>
                                    </td>
                                    <td class="actions-cell">
                                        <c:if test="${item.status == 'Pending'}">
                                            <a href="${pageContext.request.contextPath}/admin/forum/reports/delete?id=${item.id}" 
                                               class="action-btn btn-delete"
                                               onclick="return confirm('Are you sure you want to delete this post?\n\nThis action cannot be undone.');">
                                               Delete
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/forum/reports/dismiss?id=${item.id}" 
                                               class="action-btn btn-dismiss">
                                               Dismiss
                                            </a>
                                        </c:if>
                                        <c:if test="${item.status != 'Pending'}">
                                            <span style="color: #aaa; font-size: 12px;">No actions</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
