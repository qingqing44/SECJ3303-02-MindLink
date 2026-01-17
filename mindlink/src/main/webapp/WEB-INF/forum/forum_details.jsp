<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Anxiety & Stress Support Forum - MindLink</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #FFE6D0; /* soft peach, matches design */
            min-height: 100vh;
            overflow-x: hidden; /* ensure page fits laptop browser width */
        }

        /* Header */
        .header {
            padding: 20px 100px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            border-bottom: 1px solid #e0e0e0;
        }

        .nav-left,
        .nav-right {
            display: flex;
            align-items: center;
            justify-content: space-evenly; /* distribute header links equally */
            flex: 1;
            gap: 0;
        }

        .nav-left a, .nav-right a {
            text-decoration: none;
            color: #00313e;
            font-size: 16px;
            font-weight: 500;
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

        /* Container */
        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 40px 20px 60px;
        }

        /* Back Button row */
        .top-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 30px;
            color: #00313e;
        }

        .back-btn {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: none;
            background: transparent;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 22px;
            transition: transform 0.2s ease;
        }

        .back-btn:hover {
            transform: translateX(-4px);
        }

        .forum-emoji {
            font-size: 34px;
            margin-right: 6px;
        }

        /* Forum Title */
        .forum-title-wrapper {
            display: flex;
            flex-direction: column;
        }

        .forum-title {
            font-size: 36px;
            color: #00313e;
            font-weight: 700;
        }

        .forum-subtitle {
            color: #555;
            font-size: 14px;
            margin-top: 6px;
        }

        .new-discussion-btn {
            background: #00313e;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 999px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .new-discussion-btn:hover {
            background: #0d4e57;
            transform: translateY(-2px);
        }

        /* Section headers with button */
        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 18px;
        }

        .section-title {
            font-size: 24px;
            color: #00313e;
            font-weight: 700;
        }

        /* Pinned Post Card */
        .pinned-card {
            background: #FFEFD9;
            border-radius: 24px;
            border: 2px solid #F3C9A4;
            padding: 26px 32px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.06);
        }

        .pinned-main {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 20px;
            color: #00313e;
            font-weight: 600;
            margin-bottom: 16px;
        }

        .pinned-meta {
            font-size: 14px;
            color: #555;
            line-height: 1.6;
        }

        /* Recent Discussion Card */
        .discussion-card {
            background: #FFEFD9;
            border-radius: 24px;
            border: 2px solid #F3C9A4;
            padding: 28px 32px 22px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.06);
            position: relative;
        }

        .discussion-title {
            font-size: 20px;
            color: #00313e;
            font-weight: 700;
            margin-bottom: 8px;
            text-align: center;
        }

        .discussion-meta {
            font-size: 13px;
            color: #666;
            text-align: center;
            margin-bottom: 18px;
        }

        .discussion-body {
            font-size: 14px;
            color: #555;
            text-align: center;
            margin-bottom: 18px;
        }

        .discussion-stats {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 18px;
            font-size: 13px;
            color: #555;
            margin-bottom: 18px;
        }

        .stat {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .more-btn {
            position: absolute;
            top: 22px;
            right: 22px;
            width: 34px;
            height: 34px;
            border-radius: 999px;
            border: none;
            background: #00313e;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 18px;
        }

        /* Input Area inside card */
        .input-section {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .input-field {
            flex: 1;
            padding: 12px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 25px;
            font-size: 14px;
            outline: none;
        }

        .input-field:focus {
            border-color: #00313e;
        }

        .post-btn {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: none;
            background: #00313e;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 18px;
        }

        .report-btn {
            background: transparent;
            border: none;
            color: #00313e;
            font-size: 13px;
            cursor: pointer;
            text-decoration: underline;
        }

        .comment-menu-btn {
            background: none;
            border: none;
            font-size: 18px;
            cursor: pointer;
            color: #666;
            padding: 4px 8px;
            transition: color 0.2s;
        }

        .comment-menu-btn:hover {
            color: #00313e;
        }

        .comment-menu {
            position: absolute;
            right: 0;
            top: 25px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            z-index: 100;
            min-width: 120px;
        }

        .comment-menu button {
            width: 100%;
            padding: 10px 15px;
            border: none;
            background: white;
            text-align: left;
            cursor: pointer;
            font-size: 13px;
            color: #00313e;
            transition: background-color 0.2s;
        }

        .comment-menu button:hover {
            background-color: #f5f5f5;
        }

        /* Report Modal Overlay */
        .report-modal,
        .report-success-modal {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.4);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 1200;
        }

        .report-modal.active,
        .report-success-modal.active {
            display: flex;
        }

        .report-card {
            background: #fff;
            border-radius: 20px;
            padding: 30px 40px;
            width: 420px;
            box-shadow: 0 10px 35px rgba(0,0,0,0.25);
            font-size: 14px;
        }

        .report-title {
            font-weight: 700;
            color: #00313e;
            margin-bottom: 18px;
            text-align: center;
        }

        .report-options {
            margin-bottom: 14px;
        }

        .report-option {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 6px;
        }

        .report-option input {
            width: 14px;
            height: 14px;
        }

        .report-textarea {
            width: 100%;
            border-radius: 8px;
            border: 1px solid #ccc;
            padding: 8px 10px;
            font-family: inherit;
            font-size: 13px;
            margin-bottom: 18px;
        }

        .report-confirm-btn {
            width: 100%;
            padding: 10px 0;
            background: #00313e;
            color: #fff;
            border-radius: 999px;
            border: none;
            cursor: pointer;
            font-weight: 600;
        }

        .success-card {
            background: #fff;
            border-radius: 20px;
            padding: 26px 40px;
            width: 400px;
            text-align: center;
            box-shadow: 0 10px 35px rgba(0,0,0,0.25);
        }

        .success-icon {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            border: 4px solid #00313e;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            margin: 0 auto 18px;
        }

        .success-text {
            font-size: 14px;
            color: #333;
            margin-bottom: 20px;
        }

        .success-confirm-btn {
            width: 70%;
            padding: 10px 0;
            background: #00313e;
            color: #fff;
            border-radius: 999px;
            border: none;
            cursor: pointer;
            font-weight: 600;
        }

        /* Chat Button */
        .chat-button {
            position: fixed;
            bottom: 60px;
            right: 60px;
            background: white;
            padding: 15px;
            border-radius: 50%;
            cursor: pointer;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            z-index: 1000;
            text-decoration: none;
            width: 80px;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .chat-button-icon {
            width: 50px;
            height: 50px;
            object-fit: contain;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                padding: 20px;
            }

            .container {
                padding: 20px 15px;
            }

            .discussion-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="nav-left">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/learning">Learning</a>
        </div>
        
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <div class="logo-icon">
                <img src="${pageContext.request.contextPath}/images/mindlink.png" alt="MindLink">
            </div>
            <span>MindLink</span>
        </a>
        
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/forum/welcome" style="color: #0d4e57; font-weight: 600;">Forum</a>
            <a href="${pageContext.request.contextPath}/profile">Profile</a>
        </div>
    </div>

    <!-- Container -->
    <div class="container">
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        
        <!-- Back + Title row -->
        <div class="top-row">
            <button class="back-btn" onclick="window.location.href='${pageContext.request.contextPath}/forum/available'">←</button>
            <div class="forum-emoji">💬</div>
            <div class="forum-title-wrapper">
                <c:if test="${not empty forum}">
                    <div class="forum-title">${forum.title}</div>
                    <div class="forum-subtitle">${forum.description}</div>
                </c:if>
            </div>
        </div>

        <c:if test="${not empty forum}">
            <!-- Pinned Posts -->
            <div style="margin-bottom: 32px;">
                <div class="section-header">
                    <h2 class="section-title">Pinned Posts</h2>

                <div class="pinned-card">
                    <div class="pinned-main">
                        <span>📌</span>
                        <span>Forum Guidelines &amp; Support Resources</span>
                    </div>
                    <div class="pinned-meta">
                        • Please read before posting<br>
                        • Be kind, respectful, and keep conversations supportive.
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Recent Discussions / Posts -->
        <div>
            <div class="section-header">
                <h2 class="section-title">Discussions</h2>
                <c:if test="${not empty forum}">
                    <a href="${pageContext.request.contextPath}/forum/create?forumId=${forum.id}" class="new-discussion-btn">+ New Discussion</a>
                </c:if>
            </div>

            <!-- Search Bar -->
            <form method="get" action="${pageContext.request.contextPath}/forum/detail" style="margin-bottom: 20px; display: flex; gap: 12px; align-items: center; background: white; padding: 15px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                <input type="hidden" name="id" value="${forum.id}">
                <input type="text" 
                       name="search" 
                       placeholder="Search posts by content..." 
                       value="${searchQuery != null ? searchQuery : ''}" 
                       style="flex: 1; padding: 12px 18px; border: 1px solid #ddd; border-radius: 25px; font-size: 14px; outline: none; font-family: 'Poppins', sans-serif;">
                <button type="submit" 
                        style="padding: 12px 25px; background-color: #003B46; color: white; border: none; border-radius: 25px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s;">
                    🔍 Search
                </button>
                <c:if test="${searchQuery != null && !searchQuery.isEmpty()}">
                    <a href="${pageContext.request.contextPath}/forum/detail?id=${forum.id}" 
                       style="padding: 12px 20px; background-color: #f0f0f0; color: #666; text-decoration: none; border-radius: 25px; font-size: 14px; font-weight: 500; transition: background-color 0.3s;">
                        Clear
                    </a>
                </c:if>
            </form>

            <c:choose>
                <c:when test="${empty posts || postCount == 0}">
                    <div class="discussion-card">
                        <div class="discussion-title" style="color: #999; font-weight: 400;">
                            <c:choose>
                                <c:when test="${searchQuery != null && !searchQuery.isEmpty()}">
                                    No posts found matching "${searchQuery}"
                                </c:when>
                                <c:otherwise>
                                    No posts yet
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="discussion-body" style="color: #999;">
                            <c:choose>
                                <c:when test="${searchQuery != null && !searchQuery.isEmpty()}">
                                    Try a different search term or <a href="${pageContext.request.contextPath}/forum/detail?id=${forum.id}" style="color: #003B46; text-decoration: underline;">view all posts</a>.
                                </c:when>
                                <c:otherwise>
                                    Be the first to start a discussion in this forum!
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <c:if test="${not empty forum && (searchQuery == null || searchQuery.isEmpty())}">
                            <div style="text-align: center; margin-top: 20px;">
                                <a href="${pageContext.request.contextPath}/forum/create?forumId=${forum.id}" class="new-discussion-btn">Create First Post</a>
                            </div>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="post" items="${posts}">
                        <div class="discussion-card" style="margin-bottom: 20px;">
                            <div class="discussion-title">${post.anonymous ? 'Anonymous' : post.userName}</div>
                            <div class="discussion-meta">
                                By: ${post.anonymous ? 'Anonymous' : post.userName}${post.anonymous ? '' : ' ('}${post.anonymous ? '' : post.userId}${post.anonymous ? '' : ')'}
                                <c:if test="${not empty post.createdAt}">
                                    • 
                                    <c:catch var="dateError">
                                        <fmt:parseDate value="${post.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
                                        <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy HH:mm" />
                                    </c:catch>
                                    <c:if test="${not empty dateError}">
                                        ${post.createdAt}
                                    </c:if>
                                </c:if>
                            </div>

                            <div class="discussion-body">
                                ${post.content}
                            </div>

                            <div class="discussion-stats">
                                <span class="stat">💬 ${commentsMap[post.id] != null ? commentsMap[post.id].size() : 0} comments</span>
                            </div>

                            <!-- Comments Section -->
                            <div style="margin-top: 20px; padding-top: 20px; border-top: 1px solid #eee;">
                                <h4 style="font-size: 16px; font-weight: 600; color: #00313e; margin-bottom: 15px;">Comments</h4>
                                
                                <!-- Display existing comments -->
                                <c:if test="${not empty commentsMap[post.id]}">
                                    <div style="margin-bottom: 15px;">
                                        <c:forEach var="comment" items="${commentsMap[post.id]}">
                                            <div style="background: #f9f9f9; padding: 12px; border-radius: 8px; margin-bottom: 10px; position: relative;">
                                                <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                                                    <div style="flex: 1;">
                                                        <div style="font-weight: 600; font-size: 13px; color: #00313e; margin-bottom: 5px;">
                                                            ${comment.userName} (${comment.userId})
                                                        </div>
                                                        <div style="font-size: 13px; color: #555; margin-bottom: 5px;">
                                                            ${comment.content}
                                                        </div>
                                                        <div style="font-size: 11px; color: #999;">
                                                            <c:if test="${not empty comment.createdAt}">
                                                                <c:catch var="dateError">
                                                                    <fmt:parseDate value="${comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
                                                                    <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy HH:mm" />
                                                                </c:catch>
                                                                <c:if test="${not empty dateError}">
                                                                    ${comment.createdAt}
                                                                </c:if>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                    <div style="position: relative;">
                                                        <button class="comment-menu-btn" onclick="toggleCommentMenu(${comment.id})" style="background: none; border: none; font-size: 18px; cursor: pointer; color: #666; padding: 4px 8px;">⋯</button>
                                                        <div id="commentMenu${comment.id}" class="comment-menu" style="display: none; position: absolute; right: 0; top: 25px; background: white; border: 1px solid #ddd; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); z-index: 100; min-width: 120px;">
                                                            <button onclick="openCommentReportModal(${comment.id})" style="width: 100%; padding: 10px 15px; border: none; background: white; text-align: left; cursor: pointer; font-size: 13px; color: #00313e; border-radius: 8px 8px 0 0;">Report</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:if>
                                <c:if test="${empty commentsMap[post.id]}">
                                    <div style="color: #999; font-size: 13px; margin-bottom: 15px; font-style: italic;">
                                        No comments yet. Be the first to comment!
                                    </div>
                                </c:if>

                                <!-- Comment Input Section -->
                                <div class="input-section">
                                    <form action="${pageContext.request.contextPath}/forum/comment" method="POST" style="display: flex; gap: 12px; width: 100%;">
                                        <input type="hidden" name="postId" value="${post.id}">
                                        <input type="hidden" name="userId" value="S001">
                                        <input type="hidden" name="userName" value="Student User">
                                        <input type="text" name="content" class="input-field" placeholder="Type comment here...." required>
                                        <button type="submit" class="post-btn">➤</button>
                                    </form>
                                </div>

                                <!-- Report Button -->
                                <div style="margin-top: 12px; text-align: right; font-size: 13px;">
                                    <button class="report-btn" onclick="openReportModal('${post.id}')">Report</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Report reason modal for posts -->
    <div class="report-modal" id="reportModal">
        <div class="report-card">
            <div class="report-title">Please select a reason for reporting this post:</div>
            <div class="report-options">
                <label class="report-option">
                    <input type="checkbox" name="reason" value="spam">
                    <span>Spam or advertisement</span>
                </label>
                <label class="report-option">
                    <input type="checkbox" name="reason" value="harassment">
                    <span>Harassment or bullying</span>
                </label>
                <label class="report-option">
                    <input type="checkbox" name="reason" value="language">
                    <span>Inappropriate language</span>
                </label>
                <label class="report-option">
                    <input type="checkbox" name="reason" value="misinformation">
                    <span>Misinformation</span>
                </label>
            </div>
            <div style="font-size: 13px; margin-bottom: 6px;">Other:</div>
            <textarea class="report-textarea" id="reportOther" placeholder="Type here..."></textarea>
            <button class="report-confirm-btn" onclick="submitReport()">Confirm</button>
        </div>
    </div>

    <!-- Report reason modal for comments -->
    <div class="report-modal" id="commentReportModal">
        <div class="report-card">
            <div class="report-title">Please select a reason for reporting this comment:</div>
            <div class="report-options">
                <label class="report-option">
                    <input type="checkbox" name="commentReason" value="spam">
                    <span>Spam or advertisement</span>
                </label>
                <label class="report-option">
                    <input type="checkbox" name="commentReason" value="harassment">
                    <span>Harassment or bullying</span>
                </label>
                <label class="report-option">
                    <input type="checkbox" name="commentReason" value="language">
                    <span>Inappropriate language</span>
                </label>
                <label class="report-option">
                    <input type="checkbox" name="commentReason" value="misinformation">
                    <span>Misinformation</span>
                </label>
            </div>
            <div style="font-size: 13px; margin-bottom: 6px;">Other:</div>
            <textarea class="report-textarea" id="commentReportOther" placeholder="Type here..."></textarea>
            <button class="report-confirm-btn" onclick="submitCommentReport()">Confirm</button>
        </div>
    </div>

    <!-- Success modal -->
    <div class="report-success-modal" id="reportSuccessModal">
        <div class="success-card">
            <div class="success-icon">✔</div>
            <div class="success-text">
                Thank you! Your report has been submitted for review.
            </div>
            <button class="success-confirm-btn" onclick="closeSuccessModal()">Confirm</button>
        </div>
    </div>

    <!-- Chat Button -->
    <a href="${pageContext.request.contextPath}/ai/chatbot" class="chat-button">
        <img src="${pageContext.request.contextPath}/images/chatbot.png" alt="Chat" class="chat-button-icon">
    </a>
    <script>
        let currentPostId = null;
        let currentCommentId = null;

        function openReportModal(postId) {
            currentPostId = postId;
            document.getElementById('reportModal').classList.add('active');
        }

        function toggleCommentMenu(commentId) {
            // Close all other menus
            document.querySelectorAll('.comment-menu').forEach(menu => {
                if (menu.id !== 'commentMenu' + commentId) {
                    menu.style.display = 'none';
                }
            });
            // Toggle current menu
            const menu = document.getElementById('commentMenu' + commentId);
            menu.style.display = menu.style.display === 'none' ? 'block' : 'none';
        }

        function openCommentReportModal(commentId) {
            currentCommentId = commentId;
            // Close the dropdown menu
            document.getElementById('commentMenu' + commentId).style.display = 'none';
            // Open the report modal
            document.getElementById('commentReportModal').classList.add('active');
        }

        function submitCommentReport() {
            if (!currentCommentId) {
                return;
            }

            // Get all selected reasons with their labels
            const selectedReasons = Array.from(document.querySelectorAll('input[name="commentReason"]:checked')).map(cb => {
                const labelElement = cb.closest('label');
                if (labelElement) {
                    const spanElement = labelElement.querySelector('span');
                    if (spanElement) {
                        return spanElement.textContent.trim();
                    }
                }
                return cb.value;
            });
            
            const otherReason = document.getElementById('commentReportOther').value.trim();
            
            // Combine all reasons
            let reason = '';
            if (selectedReasons.length > 0) {
                reason = selectedReasons.join(', ');
            }
            if (otherReason) {
                reason += (reason ? '; ' : '') + 'Other: ' + otherReason;
            }
            if (!reason) {
                reason = 'No reason provided';
            }

            // Submit report to server
            const formData = new FormData();
            formData.append('commentId', currentCommentId);
            formData.append('reason', reason);

            fetch('${pageContext.request.contextPath}/forum/comment/report', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    document.getElementById('commentReportModal').classList.remove('active');
                    document.getElementById('reportSuccessModal').classList.add('active');
                    // Reset form
                    document.querySelectorAll('input[name="commentReason"]').forEach(input => input.checked = false);
                    document.getElementById('commentReportOther').value = '';
                } else {
                    alert('Error submitting report. Please try again.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Network error. Please try again.');
            });

            currentCommentId = null;
        }

        function submitReport() {
            if (!currentPostId) {
                return;
            }

            // Get all selected reasons with their labels
            const selectedReasons = Array.from(document.querySelectorAll('input[name="reason"]:checked')).map(cb => {
                const labelElement = cb.closest('label');
                if (labelElement) {
                    const spanElement = labelElement.querySelector('span');
                    if (spanElement) {
                        return spanElement.textContent.trim();
                    }
                }
                // Fallback to value if label structure is different
                return cb.value;
            });
            
            const otherReason = document.getElementById('reportOther').value.trim();
            
            // Combine all reasons
            let reason = '';
            if (selectedReasons.length > 0) {
                reason = selectedReasons.join(', ');
            }
            if (otherReason) {
                reason += (reason ? '; ' : '') + 'Other: ' + otherReason;
            }
            if (!reason) {
                reason = 'No reason provided';
            }
            
            console.log('Report reason:', reason); // Debug log

            // Submit report to server
            const formData = new FormData();
            formData.append('postId', currentPostId);
            formData.append('reason', reason);

            fetch('${pageContext.request.contextPath}/forum/report', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    document.getElementById('reportModal').classList.remove('active');
                    document.getElementById('reportSuccessModal').classList.add('active');
                    // Reset form
                    document.querySelectorAll('input[name="reason"]').forEach(input => input.checked = false);
                    document.getElementById('reportOther').value = '';
                } else {
                    alert('Error submitting report. Please try again.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Network error. Please try again.');
            });

            currentPostId = null;
        }

        function closeSuccessModal() {
            document.getElementById('reportSuccessModal').classList.remove('active');
        }

        // close modals when clicking outside card
        document.getElementById('reportModal').addEventListener('click', function (e) {
            if (e.target === this) {
                this.classList.remove('active');
                currentPostId = null;
            }
        });
        document.getElementById('commentReportModal').addEventListener('click', function (e) {
            if (e.target === this) {
                this.classList.remove('active');
                currentCommentId = null;
            }
        });
        document.getElementById('reportSuccessModal').addEventListener('click', function (e) {
            if (e.target === this) this.classList.remove('active');
        });

        // Close comment menus when clicking outside
        document.addEventListener('click', function(e) {
            if (!e.target.closest('.comment-menu-btn') && !e.target.closest('.comment-menu')) {
                document.querySelectorAll('.comment-menu').forEach(menu => {
                    menu.style.display = 'none';
                });
            }
        });
    </script>
</body>
</html>