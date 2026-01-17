<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback Review</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* Reusing your theme colors */
        :root { --bg-color: #FFF3E0; --card-bg: #FFFFFF; --primary-blue: #2F80ED; --text-dark: #333; }
        
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-color); margin: 0; padding: 20px; color: var(--text-dark); }
        
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
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logo-icon img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
        
        /* Stats Cards at top */
        .stats-row { display: flex; gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 20px; border-radius: 8px; flex: 1; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .stat-number { font-size: 28px; font-weight: bold; margin: 10px 0; }
        
        /* Table Styles */
        .feedback-table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; }
        th { text-align: left; padding: 15px; background: #f9f9f9; font-size: 12px; color: #666; text-transform: uppercase; }
        td { padding: 15px; border-bottom: 1px solid #eee; font-size: 14px; vertical-align: top; }
        
        /* Badges */
        .badge { padding: 4px 10px; border-radius: 20px; font-size: 12px; font-weight: 600; text-transform: uppercase; }
        .badge-pending { background: #333; color: white; }
        .badge-reviewed { background: #e0e0e0; color: #666; }
        
        /* Action Button */
        .btn-review { border: none; background: transparent; color: #333; font-weight: 600; cursor: pointer; }
        .btn-review:hover { text-decoration: underline; }

        /* --- MODAL (POPUP) STYLES --- */
        .modal-overlay {
            display: none; /* Hidden by default */
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            justify-content: center; align-items: center;
        }
        .modal-box {
            background: white; width: 500px; padding: 30px; border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .modal-label { font-size: 12px; color: #666; margin-bottom: 4px; display: block; }
        .modal-value { font-size: 16px; margin-bottom: 20px; font-weight: 500; }
        textarea { width: 100%; height: 100px; padding: 10px; margin-bottom: 20px; border: 1px solid #ddd; border-radius: 8px; }
        .modal-actions { display: flex; justify-content: flex-end; gap: 10px; }
        .btn-close { padding: 10px 20px; border: 1px solid #ddd; background: white; border-radius: 6px; cursor: pointer; }
        .btn-send { padding: 10px 20px; background: #666; color: white; border: none; border-radius: 6px; cursor: pointer; }
    </style>
</head>
<body>
<!-- Header Navigation -->
    <div class="header">
        <div class="nav-left">
            <a href="${pageContext.request.contextPath}/admin/home">Home</a>
            <a href="${pageContext.request.contextPath}/admin/modules">Module</a>
            <a href="${pageContext.request.contextPath}/admin/tips">Tips</a>
        </div>
        
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <div class="logo-icon">
                <img src="${pageContext.request.contextPath}/images/mindlink.png" alt="MindLink">
            </div>
            <span>MindLink</span>
        </a>
        
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/admin/chatbot">Chatbot</a>
            <a href="${pageContext.request.contextPath}/admin/forum/manage">Forum</a>
            <a href="${pageContext.request.contextPath}/admin/profile">Profile</a>
        </div>
    </div>

    <h1>Feedback Review</h1>

    <div class="stats-row">
        <div class="stat-card">
            <div class="modal-label">Pending Review</div>
            <div class="stat-number">${pendingCount}</div>
            <div class="modal-label">Items to review</div>
        </div>
        <div class="stat-card">
            <div class="modal-label">Critical Issues</div>
            <div class="stat-number">${criticalCount}</div>
            <div class="modal-label">Reported bugs</div>
        </div>
        <div class="stat-card">
            <div class="modal-label">Average Rating</div>
            <div class="stat-number">${avgRating} / 5.0</div>
            <div class="modal-label">Overall satisfaction</div>
        </div>
    </div>

    <table class="feedback-table">
        <thead>
            <tr>
                <th>Date</th>
                <th>User ID</th>
                <th>Module</th>
                <th>Rating</th>
                <th>Feedback</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${feedbackList}" var="item">
                <tr>
                    <td>${item.date}</td>
                    <td>${item.userId}</td>
                    <td>${item.module}</td>
                    <td>${item.rating} / 5</td>
                    <td style="max-width: 300px;">${item.comment}</td>
                    <td>
                        <span class="badge badge-${item.status}">${item.status}</span>
                    </td>
                    <td>
                        <button type="button" class="btn-review"
                            data-id="${item.id}"
                            data-user="${item.userId}"
                            data-module="${item.module}"
                            data-comment="${fn:escapeXml(item.comment)}" 
                            onclick="openModal(this)"> Review
                        </button>
                        <a href="/admin/feedback/delete?id=${item.id}" style="color:red; margin-left:10px; font-size:12px; text-decoration:none;">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="modal-overlay" id="reviewModal">
        <div class="modal-box">
            
            <form action="/admin/feedback/save" method="post">
                
                <h2>User Feedback</h2>
                
                <input type="hidden" id="hiddenId" name="id">

                <span class="modal-label">User ID</span>
                <div class="modal-value" id="mUser"></div>

                <span class="modal-label">Module</span>
                <div class="modal-value" id="mModule"></div>

                <span class="modal-label">Feedback</span>
                <div class="modal-value" id="mComment"></div>

                <h3>Admin Response</h3>
                <textarea name="response" placeholder="Type your response to the user..." required></textarea>
                
                <div class="modal-actions">
                    <button type="button" class="btn-close" onclick="closeModal()">Close</button>
                    
                    <button type="submit" class="btn-send">Send Response & Mark Reviewed</button>
                </div>

            </form>
            
        </div>
    </div>

    <script>
        function openModal(elem) {
            
            console.log("Clicked:", elem); 

            // 1. Get data from the 'elem' that was passed in
            var id = elem.getAttribute("data-id");
            var user = elem.getAttribute("data-user");
            var module = elem.getAttribute("data-module");
            var comment = elem.getAttribute("data-comment");

            // 2. Safety Check
            if (!id) {
                alert("Error: ID is missing. Check Feedback.java ID generation!");
                return;
            }

            // 3. Populate the Modal
            document.getElementById('hiddenId').value = id;
            document.getElementById('mUser').innerText = user;
            document.getElementById('mModule').innerText = module;
            document.getElementById('mComment').innerText = comment;

            // 4. Show the Modal
            document.getElementById('reviewModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('reviewModal').style.display = 'none';
        }
    </script>
</body>
</html>