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
                    --accent: #48C9B0;
                    --glass: rgba(255, 255, 255, 0.8);
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background-color: var(--bg-color);
                    margin: 0;
                    padding: 0;
                    color: var(--text-dark);
                    line-height: 1.6;
                }

                /* Header Navigation */
                .header {
                    padding: 20px 100px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    background: white;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
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
                    max-width: 1000px;
                    margin: 40px auto;
                    padding: 0 40px;
                }

                .header-title-section {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 30px;
                    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
                    padding-bottom: 20px;
                }

                .back-link {
                    text-decoration: none;
                    color: #888;
                    font-size: 14px;
                    display: flex;
                    align-items: center;
                    gap: 5px;
                    margin-bottom: 10px;
                    transition: color 0.2s;
                }

                .back-link:hover {
                    color: var(--text-dark);
                }

                .btn-add {
                    background: var(--accent);
                    color: white;
                    font-size: 24px;
                    font-weight: bold;
                    width: 45px;
                    height: 45px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    text-decoration: none;
                    box-shadow: 0 4px 10px rgba(72, 201, 176, 0.3);
                    transition: transform 0.2s;
                }

                .btn-add:hover {
                    transform: scale(1.1);
                }

                /* Search Bar */
                .search-container {
                    margin-bottom: 30px;
                    display: flex;
                    gap: 10px;
                }

                .search-input-wrapper {
                    position: relative;
                    display: flex;
                    align-items: center;
                    flex: 1;
                }

                .search-input {
                    width: 100%;
                    padding: 12px 40px 12px 20px;
                    border-radius: 30px;
                    border: 2px solid #ddd;
                    font-size: 16px;
                    outline: none;
                    transition: border-color 0.3s;
                }

                .search-input:focus {
                    border-color: var(--accent);
                }

                .search-clear {
                    position: absolute;
                    right: 15px;
                    cursor: pointer;
                    color: #999;
                    font-size: 20px;
                    display: none;
                    transition: color 0.3s;
                }

                .search-clear:hover {
                    color: #FF6B6B;
                }

                .btn-search {
                    padding: 10px 25px;
                    background: var(--text-dark);
                    color: white;
                    border: none;
                    border-radius: 30px;
                    cursor: pointer;
                    font-size: 16px;
                }

                .question-card {
                    background: var(--glass);
                    backdrop-filter: blur(10px);
                    border-radius: 20px;
                    padding: 25px;
                    margin-bottom: 20px;
                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
                    position: relative;
                    border: 1px solid rgba(255, 255, 255, 0.4);
                    transition: transform 0.2s;
                }

                .question-card:hover {
                    transform: translateY(-3px);
                    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.06);
                }

                .question-meta {
                    margin-bottom: 8px;
                    color: var(--accent);
                    text-transform: uppercase;
                    font-size: 12px;
                    font-weight: 700;
                    letter-spacing: 1px;
                }

                .question-text {
                    font-size: 20px;
                    font-weight: 700;
                    margin-bottom: 12px;
                    color: var(--text-dark);
                    padding-right: 80px;
                }

                .options-badge {
                    display: inline-block;
                    padding: 4px 12px;
                    background: #eee;
                    color: #666;
                    border-radius: 15px;
                    font-size: 12px;
                    font-weight: 600;
                }

                .actions {
                    position: absolute;
                    top: 25px;
                    right: 25px;
                    display: flex;
                    gap: 10px;
                }

                .action-icon {
                    text-decoration: none;
                    font-size: 18px;
                    color: #888;
                    width: 35px;
                    height: 35px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border-radius: 50%;
                    transition: background 0.2s, color 0.2s;
                }

                .action-icon:hover {
                    background: rgba(0, 0, 0, 0.05);
                    color: var(--text-dark);
                }

                .delete-icon:hover {
                    color: #FF6B6B;
                    background: rgba(255, 107, 107, 0.1);
                }
            </style>
        </head>

        <body>
            <div class="header">
                <div class="nav-left">
                    <a href="${pageContext.request.contextPath}/admin/home">Home</a>
                    <a href="${pageContext.request.contextPath}/admin/assessment/select-module">Assessment</a>
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
                <div class="header-title-section">
                    <div>
                        <a href="${pageContext.request.contextPath}/admin/assessment/select-module" class="back-link">
                            ← Back to Selection
                        </a>
                        <c:choose>
                            <c:when test="${moduleId != null}">
                                <h1>${selectedModuleTitle}</h1>
                            </c:when>
                            <c:otherwise>
                                <h1>All Questions</h1>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/assessment/add${moduleId != null ? '?moduleId=' : ''}${moduleId != null ? moduleId : ''}"
                        class="btn-add" title="Add Question">+</a>
                </div>

                <div class="search-container">
                    <form action="${pageContext.request.contextPath}/admin/assessment/list" method="get"
                        style="display: flex; gap: 10px; width: 100%; align-items: center; justify-content: center;">
                        <input type="hidden" name="moduleId" value="${moduleId}">
                        <div class="search-input-wrapper">
                            <input type="text" name="search" id="searchInput" class="search-input" value="${search}"
                                placeholder="Search questions in this set...">
                            <span class="search-clear" id="searchClear" title="Clear search">&times;</span>
                        </div>
                        <button type="submit" class="btn-search">Search</button>
                    </form>
                </div>

                <c:forEach items="${questions}" var="q">
                    <div class="question-card">
                        <div class="question-meta">${q.title}</div>
                        <div class="question-text">${q.questionText}</div>
                        <div class="options-badge">
                            <c:choose>
                                <c:when test="${not empty q.options}">${q.options.size()} options</c:when>
                                <c:otherwise>No options</c:otherwise>
                            </c:choose>
                        </div>

                        <div class="actions">
                            <a href="${pageContext.request.contextPath}/admin/assessment/edit?id=${q.id}${moduleId != null ? '&moduleId=' : ''}${moduleId != null ? moduleId : ''}"
                                class="action-icon" title="Edit">✎</a>

                            <a href="${pageContext.request.contextPath}/admin/assessment/delete?id=${q.id}${moduleId != null ? '&moduleId=' : ''}${moduleId != null ? moduleId : ''}"
                                class="action-icon delete-icon" onclick="return confirm('Delete this question?')"
                                title="Delete">🗑</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <script>
                const searchInput = document.getElementById('searchInput');
                const searchClear = document.getElementById('searchClear');

                function toggleClearButton() {
                    searchClear.style.display = searchInput.value ? 'block' : 'none';
                }

                searchInput.addEventListener('input', toggleClearButton);
                toggleClearButton();

                searchClear.addEventListener('click', () => {
                    searchInput.value = '';
                    toggleClearButton();
                    searchInput.focus();
                    searchInput.closest('form').submit();
                });
            </script>
        </body>

        </html>
        </body>

        </html>