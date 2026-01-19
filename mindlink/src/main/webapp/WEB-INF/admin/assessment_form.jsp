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
                    --accent: #48C9B0;
                    --glass: rgba(255, 255, 255, 0.85);
                    --danger: #FF6B6B;
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
                    margin-bottom: 50px;
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
                    max-width: 800px;
                    margin: 0 auto 60px auto;
                    padding: 0 20px;
                }

                .form-card {
                    background: var(--glass);
                    backdrop-filter: blur(15px);
                    padding: 40px;
                    border-radius: 24px;
                    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.05);
                    border: 1px solid rgba(255, 255, 255, 0.4);
                }

                h2 {
                    margin-top: 0;
                    margin-bottom: 30px;
                    font-weight: 800;
                    font-size: 32px;
                    text-align: center;
                }

                .form-group {
                    margin-bottom: 25px;
                }

                label {
                    display: block;
                    font-weight: 600;
                    margin-bottom: 10px;
                    font-size: 14px;
                    color: var(--text-dark);
                    opacity: 0.8;
                }

                input[type="text"],
                input[type="number"],
                textarea,
                select {
                    width: 100%;
                    padding: 14px 18px;
                    border: 1px solid rgba(0, 0, 0, 0.1);
                    border-radius: 12px;
                    font-size: 16px;
                    font-family: inherit;
                    background: white;
                    transition: border-color 0.3s, box-shadow 0.3s;
                    box-sizing: border-box;
                }

                input:focus {
                    outline: none;
                    border-color: var(--accent);
                    box-shadow: 0 0 0 4px rgba(72, 201, 176, 0.1);
                }

                .option-row {
                    display: flex;
                    gap: 12px;
                    margin-bottom: 12px;
                    align-items: center;
                    background: rgba(255, 255, 255, 0.5);
                    padding: 10px;
                    border-radius: 15px;
                    border: 1px solid rgba(0, 0, 0, 0.02);
                }

                .btn-remove {
                    background: var(--danger);
                    color: white;
                    border: none;
                    width: 35px;
                    height: 35px;
                    border-radius: 50%;
                    cursor: pointer;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-weight: bold;
                    font-size: 18px;
                    transition: opacity 0.2s;
                }

                .btn-remove:hover {
                    opacity: 0.8;
                }

                .btn-add {
                    background: #F2C94C;
                    color: #003049;
                    border: none;
                    padding: 10px 20px;
                    border-radius: 12px;
                    cursor: pointer;
                    font-weight: 700;
                    font-size: 14px;
                    margin-top: 10px;
                    transition: transform 0.2s;
                }

                .btn-add:hover {
                    transform: translateY(-2px);
                }

                .btn-save {
                    background: var(--accent);
                    color: white;
                    border: none;
                    padding: 16px;
                    border-radius: 15px;
                    width: 100%;
                    cursor: pointer;
                    font-size: 18px;
                    font-weight: 700;
                    margin-top: 30px;
                    transition: all 0.3s;
                    box-shadow: 0 4px 15px rgba(72, 201, 176, 0.3);
                }

                .btn-save:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 6px 20px rgba(72, 201, 176, 0.4);
                }

                .btn-cancel {
                    display: block;
                    text-align: center;
                    margin-top: 20px;
                    color: #888;
                    text-decoration: none;
                    font-weight: 600;
                    font-size: 14px;
                    transition: color 0.2s;
                }

                .btn-cancel:hover {
                    color: var(--text-dark);
                }

                .helper-text {
                    font-size: 12px;
                    color: #888;
                    margin-top: 5px;
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
                <div class="form-card">
                    <c:choose>
                        <c:when test="${not empty isNewSet}">
                            <h2>Create New Assessment Set</h2>
                        </c:when>
                        <c:when test="${assessment.id > 0}">
                            <h2>Edit Question for
                                <c:out value="${assessment.title}" />
                            </h2>
                        </c:when>
                        <c:when test="${moduleId != null}">
                            <h2>Add Question for
                                <c:out value="${assessment.title}" />
                            </h2>
                        </c:when>
                        <c:otherwise>
                            <h2>Create New Assessment</h2>
                        </c:otherwise>
                    </c:choose>

                    <form
                        action="${pageContext.request.contextPath}/admin/assessment/${assessment.id > 0 ? 'update' : 'save'}"
                        method="post" id="assessmentForm">
                        <c:if test="${assessment.id > 0}">
                            <input type="hidden" name="id" value="${assessment.id}">
                        </c:if>

                        <div class="form-group">
                            <label>Assessment Title (Group)</label>
                            <input type="text" name="title" value="${assessment.title}"
                                placeholder="e.g. Stress Test, Happiness Check" required ${moduleId !=null
                                ? 'readonly style="background:#f8f9fa; cursor:not-allowed;"' : '' }>
                            <p class="helper-text">This title groups questions together as a "Set".</p>
                        </div>

                        <c:if test="${empty isNewSet}">
                            <div class="form-group">
                                <label>Question Text</label>
                                <textarea name="questionText" placeholder="e.g. How often do you feel overwhelmed?"
                                    required
                                    style="min-height: 80px; resize: vertical;">${assessment.questionText}</textarea>
                            </div>

                            <input type="hidden" name="questionType" value="multiple_choice">

                            <div class="form-group">
                                <label>Options (Text & Score)</label>
                                <div id="options-container">
                                    <c:forEach items="${assessment.options}" var="opt" varStatus="status">
                                        <div class="option-row">
                                            <input type="text" name="options[${status.index}].optionText"
                                                value="${opt.optionText}" placeholder="Option text" required
                                                style="flex:3">
                                            <input type="number" name="options[${status.index}].scoreValue"
                                                value="${opt.scoreValue}" placeholder="Score" required style="flex:1">
                                            <button type="button" class="btn-remove"
                                                onclick="removeOption(this)">×</button>
                                        </div>
                                    </c:forEach>
                                </div>
                                <button type="button" class="btn-add" onclick="addOption()">+ Add New Option</button>
                            </div>
                        </c:if>

                        <c:if test="${moduleId != null}">
                            <input type="hidden" name="moduleId" value="${moduleId}" />
                        </c:if>

                        <button type="submit" class="btn-save">${not empty isNewSet ? 'Create Assessment Set' : 'Save
                            Question'}</button>

                        <c:choose>
                            <c:when test="${not empty isNewSet}">
                                <a href="${pageContext.request.contextPath}/admin/assessment/select-module"
                                    class="btn-cancel">Cancel Creation</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/admin/assessment/list${moduleId != null ? '?moduleId=' : ''}${moduleId != null ? moduleId : ''}"
                                    class="btn-cancel">Cancel and Go Back</a>
                            </c:otherwise>
                        </c:choose>
                    </form>
                </div>
            </div>

            <script>
                function addOption() {
                    const container = document.getElementById('options-container');
                    if (!container) return; // Guard clause if options are hidden
                    const index = container.children.length;

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

                // Add options if none exist
                if (document.querySelectorAll('.option-row').length === 0) {
                    addOption();
                    addOption(); // Usually assessments have at least 2 options
                }
            </script>
        </body>

        </html>