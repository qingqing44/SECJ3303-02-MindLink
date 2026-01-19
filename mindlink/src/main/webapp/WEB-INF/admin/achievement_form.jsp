<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>${isEdit ? 'Edit' : 'Create'} Achievement</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
            <style>
                :root {
                    --bg-color: #FFF3E0;
                    --text-dark: #003049;
                    --accent: #48C9B0;
                    --glass: rgba(255, 255, 255, 0.9);
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background-color: var(--bg-color);
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    min-height: 100vh;
                    margin: 0;
                    color: var(--text-dark);
                }

                .form-card {
                    background: var(--glass);
                    padding: 40px;
                    border-radius: 24px;
                    width: 500px;
                    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.05);
                }

                h2 {
                    text-align: center;
                    margin-bottom: 30px;
                }

                .form-group {
                    margin-bottom: 20px;
                }

                label {
                    display: block;
                    margin-bottom: 8px;
                    font-weight: 600;
                    font-size: 14px;
                }

                input,
                textarea {
                    width: 100%;
                    padding: 12px;
                    border: 1px solid #ddd;
                    border-radius: 10px;
                    font-family: inherit;
                    box-sizing: border-box;
                }

                .btn-submit {
                    background: var(--accent);
                    color: white;
                    width: 100%;
                    padding: 15px;
                    border: none;
                    border-radius: 12px;
                    font-weight: 700;
                    font-size: 16px;
                    cursor: pointer;
                    margin-top: 10px;
                }

                .btn-cancel {
                    display: block;
                    text-align: center;
                    margin-top: 15px;
                    color: #888;
                    text-decoration: none;
                    font-size: 14px;
                }
            </style>
        </head>

        <body>

            <div class="form-card">
                <h2>${isEdit ? 'Edit Badge' : 'New Badge'}</h2>

                <form action="${pageContext.request.contextPath}/admin/achievements/${isEdit ? 'update' : 'save'}"
                    method="post">

                    <div class="form-group">
                        <label>Achievement ID (Unique Code)</label>
                        <input type="text" name="achievementType" value="${achievement.achievementType}"
                            placeholder="e.g. SUPER_READER" required ${isEdit ? 'readonly style="background:#f0f0f0"'
                            : '' }>
                    </div>

                    <div class="form-group">
                        <label>Display Title</label>
                        <input type="text" name="title" value="${achievement.title}" placeholder="e.g. Super Reader"
                            required>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" rows="3" required>${achievement.description}</textarea>
                    </div>

                    <div class="form-group">
                        <label>Icon Filename</label>
                        <input type="text" name="iconPath" value="${achievement.iconPath}"
                            placeholder="e.g. badge1.png">
                    </div>

                    <div class="form-group">
                        <label>Target Value</label>
                        <input type="number" name="targetValue" value="${achievement.targetValue}" min="1" required>
                    </div>

                    <button type="submit" class="btn-submit">${isEdit ? 'Update Badge' : 'Create Badge'}</button>
                    <a href="${pageContext.request.contextPath}/admin/achievements" class="btn-cancel">Cancel</a>
                </form>
            </div>

        </body>

        </html>