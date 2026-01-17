<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">
        <!--Admin view-->

        <head>
            <meta charset="UTF-8">
            <title>${assessment.id > 0 ? 'Edit' : 'Add'} Assessment Question</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
            <style>
                :root {
                    --bg-color: #FFF3E0;
                    --text-dark: #003049;
                    --card-bg: #FFFFFF;
                }

                body {
                    font-family: 'Segoe UI', sans-serif;
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
                    margin-bottom: 40px;
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

                .form-card {
                    background: white;
                    max-width: 800px;
                    margin: 0 auto 60px auto;
                    padding: 40px;
                    border-radius: 20px;
                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                }

                .form-group {
                    margin-bottom: 20px;
                }

                label {
                    display: block;
                    font-weight: 600;
                    margin-bottom: 8px;
                    font-size: 14px;
                    color: #555;
                }

                input[type="text"],
                input[type="number"],
                textarea,
                select {
                    width: 100%;
                    padding: 12px;
                    border: 1px solid #ddd;
                    border-radius: 8px;
                    font-size: 16px;
                    font-family: inherit;
                }

                .btn-save {
                    background: #48C9B0;
                    color: white;
                    border: none;
                    padding: 12px 30px;
                    border-radius: 20px;
                    width: 100%;
                    cursor: pointer;
                    font-size: 16px;
                    font-weight: 600;
                    margin-top: 20px;
                    transition: background 0.3s;
                }

                .btn-save:hover {
                    background: #3aa892;
                }

                .option-row {
                    display: flex;
                    gap: 10px;
                    margin-bottom: 10px;
                    align-items: center;
                }

                .btn-remove {
                    background: #FF6B6B;
                    color: white;
                    border: none;
                    width: 30px;
                    height: 30px;
                    border-radius: 50%;
                    cursor: pointer;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-weight: bold;
                }

                .btn-add {
                    background: #F2C94C;
                    color: #003049;
                    border: none;
                    padding: 8px 15px;
                    border-radius: 15px;
                    cursor: pointer;
                    font-weight: 600;
                    font-size: 14px;
                }

                h2 {
                    text-align: center;
                    margin-bottom: 30px;
                    font-weight: 800;
                    font-size: 28px;
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

            <div class="form-card">
                <h2>${assessment.id > 0 ? 'Edit' : 'Add'} Question</h2>

                <form
                    action="${pageContext.request.contextPath}/admin/assessment/${assessment.id > 0 ? 'update' : 'save'}"
                    method="post" id="assessmentForm">
                    <c:if test="${assessment.id > 0}">
                        <input type="hidden" name="id" value="${assessment.id}">
                    </c:if>

                    <div class="form-group">
                        <label>Assessment Title (Group)</label>
                        <input type="text" name="title" value="${assessment.title}"
                            placeholder="e.g. Stress Test, Happiness Check" required>
                    </div>

                    <div class="form-group">
                        <label>Question Text</label>
                        <input type="text" name="questionText" value="${assessment.questionText}"
                            placeholder="e.g. How often do you feel overwhelmed?" required>
                    </div>

                    <!-- Hidden field for question type for compatibility -->
                    <input type="hidden" name="questionType" value="multiple_choice">

                    <div class="form-group">
                        <label>Options (Text & Score)</label>
                        <div id="options-container">
                            <c:forEach items="${assessment.options}" var="opt" varStatus="status">
                                <div class="option-row" data-index="${status.index}">
                                    <input type="text" name="options[${status.index}].optionText"
                                        value="${opt.optionText}" placeholder="Option text" required style="flex:3">
                                    <input type="number" name="options[${status.index}].scoreValue"
                                        value="${opt.scoreValue}" placeholder="Score" required style="flex:1">
                                    <button type="button" class="btn-remove" onclick="removeOption(this)">×</button>
                                </div>
                            </c:forEach>
                        </div>
                        <button type="button" class="btn-add" onclick="addOption()">+ Add Option</button>
                    </div>

                    <c:if test="${moduleId != null}">
                        <input type="hidden" name="moduleId" value="${moduleId}" />
                    </c:if>
                    <button type="submit" class="btn-save">Save Question</button>
                    <a href="${pageContext.request.contextPath}/admin/assessment/list${moduleId != null ? '?moduleId=' : ''}${moduleId != null ? moduleId : ''}"
                        style="display:block; text-align:center; margin-top:20px; color:#666; text-decoration:none;">Cancel</a>
                </form>
            </div>

            <script>
                function addOption() {
                    const container = document.getElementById('options-container');
                    const index = container.children.length; // Simple index based on current count

                    const div = document.createElement('div');
                    div.className = 'option-row';
                    div.innerHTML = `
        <input type="text" name="options[` + index + `].optionText" placeholder="Option text" required style="flex:3">
        <input type="number" name="options[` + index + `].scoreValue" placeholder="Score" required style="flex:1">
        <button type="button" class="btn-remove" onclick="removeOption(this)">×</button>
    `;
                    container.appendChild(div);
                }

                function removeOption(btn) {
                    btn.parentElement.remove();
                    reindexOptions();
                }

                function reindexOptions() {
                    const rows = document.querySelectorAll('.option-row');
                    rows.forEach((row, index) => {
                        const inputs = row.querySelectorAll('input');
                        inputs[0].name = `options[` + index + `].optionText`;
                        inputs[1].name = `options[` + index + `].scoreValue`;
                    });
                }

                // Add one empty option if none exist
                if (document.querySelectorAll('.option-row').length === 0) {
                    addOption();
                }
            </script>
        </body>

        </html>