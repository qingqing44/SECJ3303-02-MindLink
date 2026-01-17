<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Daily Tips</title>
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
            background: linear-gradient(135deg, #00313e 0%, #004d61 100%);
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
            width: 60px;
            text-align: center;
        }

        th:last-child {
            width: 150px;
            text-align: center;
        }

        tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: background-color 0.2s;
        }

        tbody tr:hover {
            background-color: #f9f9f9;
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

        td:first-child {
            text-align: center;
            color: #999;
            font-weight: 600;
        }

        .title-cell {
            font-weight: 700;
            color: var(--text-dark);
            font-size: 15px;
            max-width: 300px;
        }

        .content-cell {
            color: #666;
            line-height: 1.6;
            max-width: 600px;
        }

        .content-preview {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .actions-cell {
            text-align: center;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 16px;
            transition: all 0.2s;
            margin: 0 4px;
        }

        .btn-edit {
            background-color: var(--btn-green);
            color: white;
        }

        .btn-edit:hover {
            background-color: #3ab89a;
            transform: translateY(-2px);
        }

        .btn-delete {
            background-color: var(--btn-red);
            color: white;
        }

        .btn-delete:hover {
            background-color: #e55a5a;
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
            <h1>Daily Tips Management</h1>
            <a href="${pageContext.request.contextPath}/admin/tips/add" class="btn btn-primary">+ Add New Tip</a>
        </div>

        <form method="get" action="${pageContext.request.contextPath}/admin/tips" class="search-container">
            <input type="text" 
                   name="search" 
                   class="search-input" 
                   placeholder="Search by ID or title..." 
                   value="${searchQuery}">
            <button type="submit" class="search-btn">🔍 Search</button>
            <c:if test="${not empty searchQuery}">
                <a href="${pageContext.request.contextPath}/admin/tips" class="clear-btn">Clear</a>
            </c:if>
        </form>

        <div class="table-container">
            <c:choose>
                <c:when test="${empty tips}">
                    <div class="empty-state">
                        <div class="empty-icon">💡</div>
                        <p style="font-size: 20px; font-weight: 600; margin-bottom: 10px;">No daily tips found</p>
                        <p>Click "Add New Tip" to create your first daily tip.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Content</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="tip" items="${tips}">
                                <tr>
                                    <td>${tip.id}</td>
                                    <td class="title-cell">
                                        <c:out value="${tip.title != null ? tip.title : 'Untitled Tip'}" />
                                    </td>
                                    <td class="content-cell">
                                        <div class="content-preview">
                                            <c:out value="${tip.content}" />
                                        </div>
                                    </td>
                                    <td class="actions-cell">
                                        <a href="${pageContext.request.contextPath}/admin/tips/edit?id=${tip.id}" 
                                           class="action-btn btn-edit" 
                                           title="Edit Tip">✏️</a>
                                        <c:set var="tipTitle" value="${tip.title != null ? tip.title : 'Untitled Tip'}" />
                                        <a href="${pageContext.request.contextPath}/admin/tips/delete?id=${tip.id}" 
                                           class="action-btn btn-delete" 
                                           title="Delete Tip"
                                           onclick="return confirm('Are you sure you want to delete this tip?\n\nTitle: ${tipTitle}\n\nThis action cannot be undone.');">🗑️</a>
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
