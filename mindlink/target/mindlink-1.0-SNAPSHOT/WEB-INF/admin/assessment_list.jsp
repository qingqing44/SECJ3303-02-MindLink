<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">
        <!--Admin view-->

        <head>
            <meta charset="UTF-8">
            <title>Manage Assessment</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
            <style>
                :root {
                    --bg-color: #FFF3E0;
                    --text-dark: #003049;
                    --card-bg: #FFFFFF;
                    --btn-yellow: #F2C94C;
                    --btn-teal: #48C9B0;
                    --btn-pink: #F497AA;
                }

                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background-color: var(--bg-color);
                    margin: 0;
                    padding: 0;
                    color: var(--text-dark);
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

                .container {
                    max-width: 1000px;
                    margin: 60px auto;
                    padding: 0 40px;
                }

                .header-title-section {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 30px;
                }

                .btn-add {
                    background: transparent;
                    border: none;
                    font-size: 32px;
                    cursor: pointer;
                    color: #000;
                }

                .question-card {
                    background: #FFF5F5;
                    /* Light pinkish background from screenshot */
                    border-radius: 20px;
                    padding: 30px;
                    margin-bottom: 20px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
                    position: relative;
                }

                .question-text {
                    font-size: 20px;
                    font-weight: 800;
                    margin-bottom: 10px;
                    color: #000;
                }

                .options-text {
                    font-size: 14px;
                    color: #666;
                    font-weight: 600;
                }

                .actions {
                    position: absolute;
                    top: 20px;
                    right: 20px;
                    display: flex;
                    gap: 10px;
                }

                .action-icon {
                    text-decoration: none;
                    font-size: 20px;
                    color: #000;
                    padding: 5px;
                    border-radius: 5px;
                    transition: background 0.2s;
                }

                .action-icon:hover {
                    background: rgba(0, 0, 0, 0.1);
                }

                .delete-icon {
                    color: #d32f2f;
                }
            </style>
        </head>

        <body>
            <!-- Standard Admin Header -->
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

                <div class="header-title-section">
                    <div>
                        <c:if test="${moduleId != null && selectedModule != null}">
                            <a href="${pageContext.request.contextPath}/admin/assessment/select-module" 
                               style="text-decoration: none; color: #666; font-size: 14px; margin-bottom: 10px; display: inline-block;">
                                ← Back to Module Selection
                            </a>
                            <h1>${selectedModule.title} - Assessment</h1>
                        </c:if>
                        <c:if test="${moduleId == null || selectedModule == null}">
                            <h1>Mental Health Assessment</h1>
                        </c:if>
                    </div>
                    <div style="display: flex; align-items: center; gap: 15px;">
                        <a href="${pageContext.request.contextPath}/admin/assessment/add${moduleId != null ? '?moduleId=' : ''}${moduleId != null ? moduleId : ''}" class="btn-add"
                            style="text-decoration:none;">+</a>
                    </div>
                </div>

                <c:forEach items="${questions}" var="q">
                    <div class="question-card">
                        <div
                            style="margin-bottom: 5px; color: #888; text-transform: uppercase; font-size: 12px; font-weight: 700;">
                            ${q.title}</div>
                        <div class="question-text">${q.questionText}</div>
                        <div class="options-text">
                            <c:choose>
                                <c:when test="${not empty q.options}">
                                    ${q.options.size()} options available
                                </c:when>
                                <c:otherwise>
                                    No options defined
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="actions">
                            <a href="${pageContext.request.contextPath}/admin/assessment/edit?id=${q.id}${moduleId != null ? '&moduleId=' : ''}${moduleId != null ? moduleId : ''}"
                                class="action-icon">✎</a>

                            <a href="${pageContext.request.contextPath}/admin/assessment/delete?id=${q.id}${moduleId != null ? '&moduleId=' : ''}${moduleId != null ? moduleId : ''}"
                                class="action-icon delete-icon" onclick="return confirm('Delete this question?')">🗑</a>
                        </div>
                    </div>
                </c:forEach>

            </div>
        </body>

        </html>