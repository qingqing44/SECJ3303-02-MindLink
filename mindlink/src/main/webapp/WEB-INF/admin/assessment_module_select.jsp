<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Select Module - Assessment</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
            <style>
                :root {
                    --bg-color: #FFF3E0;
                    --text-dark: #003049;
                    --accent: #48C9B0;
                    --danger: #FF6B6B;
                    --glass: rgba(255, 255, 255, 0.8);
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background-color: var(--bg-color);
                    margin: 0;
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
                    text-align: center;
                }

                /* Search Bar */
                .search-container {
                    margin-bottom: 40px;
                    display: flex;
                    justify-content: center;
                    gap: 10px;
                }

                .search-input-wrapper {
                    position: relative;
                    display: flex;
                    align-items: center;
                }

                .search-input {
                    padding: 12px 40px 12px 20px;
                    border-radius: 30px;
                    border: 2px solid #ddd;
                    width: 400px;
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
                    color: var(--danger);
                }

                .btn-search {
                    padding: 10px 25px;
                    background: var(--text-dark);
                    color: white;
                    border: none;
                    border-radius: 30px;
                    cursor: pointer;
                    font-size: 16px;
                    transition: opacity 0.3s;
                }

                .module-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                    gap: 25px;
                    margin-top: 20px;
                }

                .module-card {
                    background: var(--glass);
                    backdrop-filter: blur(10px);
                    padding: 30px;
                    border-radius: 20px;
                    text-align: left;
                    position: relative;
                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                    border: 1px solid rgba(255, 255, 255, 0.3);
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                }

                .module-card:hover {
                    transform: translateY(-8px);
                    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
                    border-color: var(--accent);
                }

                .card-content {
                    text-decoration: none;
                    color: inherit;
                    flex: 1;
                }

                .module-card h3 {
                    margin: 0 0 8px 0;
                    font-size: 22px;
                    font-weight: 700;
                }

                .module-card p {
                    font-size: 14px;
                    color: #666;
                    margin: 0 0 15px 0;
                }

                .question-count {
                    display: inline-block;
                    padding: 4px 12px;
                    background: rgba(72, 201, 176, 0.1);
                    color: var(--accent);
                    border-radius: 20px;
                    font-size: 12px;
                    font-weight: 700;
                }

                .card-actions {
                    margin-top: 20px;
                    display: flex;
                    gap: 15px;
                    border-top: 1px solid rgba(0, 0, 0, 0.05);
                    padding-top: 15px;
                }

                .btn-action {
                    background: none;
                    border: none;
                    cursor: pointer;
                    font-size: 18px;
                    color: #888;
                    transition: color 0.2s;
                    display: flex;
                    align-items: center;
                    gap: 5px;
                    font-size: 14px;
                    text-decoration: none;
                }

                .btn-action:hover {
                    color: var(--text-dark);
                }

                .btn-delete:hover {
                    color: var(--danger);
                }

                .btn-add-set {
                    display: inline-block;
                    background: var(--accent);
                    color: white;
                    padding: 15px 30px;
                    border-radius: 30px;
                    text-decoration: none;
                    font-weight: 700;
                    margin-bottom: 40px;
                    transition: all 0.3s;
                    box-shadow: 0 4px 15px rgba(72, 201, 176, 0.3);
                }

                .btn-add-set:hover {
                    transform: scale(1.05);
                    box-shadow: 0 6px 20px rgba(72, 201, 176, 0.4);
                }

                /* Modal Settings */
                .modal {
                    display: none;
                    position: fixed;
                    z-index: 1000;
                    left: 0;
                    top: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(0, 0, 0, 0.5);
                    backdrop-filter: blur(5px);
                    align-items: center;
                    justify-content: center;
                }

                .modal-content {
                    background: white;
                    padding: 40px;
                    border-radius: 20px;
                    width: 400px;
                    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
                }

                .modal-content h2 {
                    margin-top: 0;
                    margin-bottom: 20px;
                }

                .modal-input {
                    width: 100%;
                    padding: 12px;
                    border-radius: 10px;
                    border: 1px solid #ddd;
                    margin-bottom: 20px;
                    font-size: 16px;
                    box-sizing: border-box;
                }

                .modal-btns {
                    display: flex;
                    justify-content: flex-end;
                    gap: 10px;
                }

                .btn-modal {
                    padding: 10px 20px;
                    border-radius: 10px;
                    border: none;
                    cursor: pointer;
                    font-weight: 600;
                }

                .btn-cancel {
                    background: #eee;
                }

                .btn-confirm {
                    background: var(--accent);
                    color: white;
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
                <h1>Manage Assessment Sets</h1>
                <p style="color: #666; margin-bottom: 30px;">Refine, organize, and create mental health evaluation
                    groups.</p>

                <div class="search-container">
                    <form action="${pageContext.request.contextPath}/admin/assessment/select-module" method="get"
                        style="display: flex; gap: 10px; align-items: center; justify-content: center;">
                        <div class="search-input-wrapper">
                            <input type="text" name="search" id="searchInput" class="search-input" value="${search}"
                                placeholder="Search assessment titles...">
                            <span class="search-clear" id="searchClear" title="Clear search">&times;</span>
                        </div>
                        <button type="submit" class="btn-search">Search</button>
                    </form>
                </div>

                <a href="${pageContext.request.contextPath}/admin/assessment/add" class="btn-add-set">+ Create New
                    Assessment</a>

                <div class="module-grid">
                    <c:forEach items="${sets}" var="s">
                        <div class="module-card">
                            <a href="${pageContext.request.contextPath}/admin/assessment/list?moduleId=${s.set_id}"
                                class="card-content">
                                <h3>${s.assessment_title}</h3>
                                <div class="question-count">${s.question_count} Questions</div>
                            </a>
                            <div class="card-actions">
                                <button class="btn-action" data-id="${s.set_id}"
                                    data-title="<c:out value='${s.assessment_title}'/>"
                                    onclick="openRenameModal(this)">✎ Rename</button>
                                <a href="${pageContext.request.contextPath}/admin/assessment/set/delete?setId=${s.set_id}&title=${s.assessment_title}"
                                    class="btn-action btn-delete"
                                    onclick="return confirm('WARNING: This will delete ALL questions in this set. Continue?')">🗑
                                    Delete</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Rename Modal -->
            <div id="renameModal" class="modal">
                <div class="modal-content">
                    <h2>Rename Assessment</h2>
                    <form action="${pageContext.request.contextPath}/admin/assessment/set/update-title" method="post">
                        <input type="hidden" name="setId" id="modalSetId">
                        <input type="hidden" name="oldTitle" id="modalOldTitle">
                        <input type="text" name="newTitle" id="modalNewTitle" class="modal-input" required>
                        <div class="modal-btns">
                            <button type="button" class="btn-modal btn-cancel"
                                onclick="closeRenameModal()">Cancel</button>
                            <button type="submit" class="btn-modal btn-confirm">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                const searchInput = document.getElementById('searchInput');
                const searchClear = document.getElementById('searchClear');

                function toggleClearButton() {
                    searchClear.style.display = searchInput.value ? 'block' : 'none';
                }

                searchInput.addEventListener('input', toggleClearButton);
                toggleClearButton(); // Initial check

                searchClear.addEventListener('click', () => {
                    searchInput.value = '';
                    toggleClearButton();
                    searchInput.focus();
                    // Optionally submit form automatically to reset
                    searchInput.closest('form').submit();
                });

                function openRenameModal(btn) {
                    const id = btn.getAttribute('data-id');
                    const title = btn.getAttribute('data-title');
                    document.getElementById('modalSetId').value = id;
                    document.getElementById('modalOldTitle').value = title;
                    document.getElementById('modalNewTitle').value = title;
                    document.getElementById('renameModal').style.display = 'flex';
                }
                function closeRenameModal() {
                    document.getElementById('renameModal').style.display = 'none';
                }
            </script>
        </body>

        </html>