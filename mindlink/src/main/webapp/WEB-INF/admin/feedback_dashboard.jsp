<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback Management | MindLink Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg-body: #FFF3E0;
            --bg-card: #FFFFFF;
            --primary: #003049;
            --secondary: #666666;
            --accent-orange: #F77F00;
            --accent-pink: #F497AA;
            --success-teal: #48C9B0;
            --shadow: 0 10px 30px rgba(0, 48, 73, 0.05);
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background: var(--bg-body); 
            padding: 0; margin: 0; 
            color: var(--primary); 
            overflow-x: hidden;
        }
        
        /* HEADER (Unchanged) */
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

        /* CONTAINER */
        .container { 
            max-width: 900px; 
            margin: 50px auto 0 auto; 
            padding: 10 40px;
            animation: slideUp 0.6s ease-out;
        }
        @keyframes slideUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        
        /* 3. BACK BUTTON (Icon Only) */
        .btn-back {
            display: inline-flex; align-items: center; justify-content: center;
            width: 45px; height: 45px; border-radius: 50%;
            background: white; color: var(--primary); font-size: 18px;
            text-decoration: none; box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px; transition: 0.2s;
        }
        .btn-back:hover { background: var(--accent-orange); color: white; transform: translateX(-5px); }

        h1 { margin: 0 0 30px 0; font-weight: 800; font-size: 36px; color: var(--primary); letter-spacing: -1px; }

        /* FILTER BAR (Floating) */
        .filter-bar {
            background: var(--bg-card); padding: 15px 30px; border-radius: 50px;
            display: flex; gap: 20px; align-items: center; margin-bottom: 35px;
            box-shadow: var(--shadow); border: 1px solid rgba(255,255,255,0.5);
        }
        .filter-label { font-weight: 700; color: var(--primary); font-size: 14px; display: flex; align-items: center; gap: 8px; white-space: nowrap; }
        .filter-select {
            padding: 10px 20px; border: 1px solid #E0E0E0; border-radius: 30px;
            font-size: 14px; color: var(--primary); outline: none; cursor: pointer; transition: 0.2s;
            background-color: #FAFAFA; font-family: inherit; font-weight: 500; width: 100%;
        }
        .filter-select:hover { border-color: var(--accent-orange); background: white; }

        /* TABS */
        .tabs { display: flex; gap: 30px; margin-bottom: 25px; border-bottom: 2px solid rgba(0,0,0,0.05); padding-bottom: 0; }
        .tab-btn {
            background: none; border: none; padding: 12px 10px;
            font-size: 16px; font-weight: 600; color: #888; cursor: pointer;
            border-bottom: 3px solid transparent; transition: all 0.2s; 
            font-family: inherit; position: relative; top: 2px;
        }
        .tab-btn:hover { color: var(--primary); }
        .tab-btn.active { color: var(--primary); border-bottom-color: var(--accent-orange); }
        .badge { background: #F0F0F0; padding: 2px 10px; border-radius: 10px; font-size: 12px; margin-left: 8px; color: #666; }
        .tab-btn.active .badge { background: var(--primary); color: white; }

        .tab-content { display: none; animation: fadeIn 0.4s ease; }
        .tab-content.active { display: block; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

        /* FEEDBACK CARD */
        .feedback-card {
            background: var(--bg-card); border-radius: 16px; margin-bottom: 20px;
            box-shadow: var(--shadow); overflow: hidden;
            border-left: 6px solid transparent; cursor: pointer;
            transition: all 0.3s ease;
        }
        .feedback-card:hover { transform: translateY(-3px); }

        .pending-card { border-left-color: var(--accent-pink); }
        .completed-card { border-left-color: var(--success-teal); }

        .card-header { padding: 25px 30px; display: flex; justify-content: space-between; align-items: center; }
        .subject { font-weight: 700; font-size: 18px; color: var(--primary); display: block; margin-bottom: 5px; }
        .category-badge { background: #F4F7FE; padding: 5px 12px; border-radius: 20px; font-size: 12px; color: var(--secondary); font-weight: 600; text-transform: uppercase; }
        .meta-info { display: flex; align-items: center; gap: 25px; font-size: 14px; color: var(--secondary); font-weight: 500; }
        .star-rating { color: #FFB547; font-weight: 700; }
        .chevron { width: 30px; height: 30px; border-radius: 50%; background: #F4F7FE; display: flex; align-items: center; justify-content: center; transition: transform 0.3s, background 0.3s; color: var(--primary); }
        .feedback-card.active .chevron { transform: rotate(180deg); background: var(--primary); color: white; }

        /* CARD DETAILS */
        .card-details { display: none; padding: 0 30px 30px 30px; border-top: 1px solid #F0F0F0; background: #FAFAFA; }
        
        .message-box { 
            margin-top: 25px; color: #444; line-height: 1.6; font-size: 15px; 
            background: white; padding: 25px; border-radius: 12px; 
            border: 1px solid #EAEAEA;
        }
        
        .reply-section { margin-top: 25px; }
        .reply-container { position: relative; border: 1px solid #E0E0E0; border-radius: 12px; background: white; padding: 5px; }
        .reply-container:focus-within { border-color: var(--primary); }
        .reply-form textarea { width: 100%; padding: 15px; border: none; border-radius: 12px; font-family: inherit; resize: vertical; outline: none; font-size: 15px; min-height: 100px; }
        
        .btn-reply {
            background: var(--primary); color: white; border: none; 
            padding: 10px 25px; border-radius: 30px; cursor: pointer; 
            font-weight: 600; font-size: 14px; transition: 0.2s;
            display: flex; align-items: center; gap: 8px; 
            margin-left: auto; margin-right: 10px; margin-bottom: 10px;
        }
        .btn-reply:hover { background: var(--accent-orange); }

        .reply-display { 
            background: #E0F2F1; color: #004D40; padding: 20px; border-radius: 12px; 
            font-size: 15px; border-left: 4px solid var(--success-teal); line-height: 1.6;
        }
        
        .empty-state { text-align: center; color: #999; margin-top: 60px; font-style: italic; }
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
    
    <a href="${pageContext.request.contextPath}/admin/home" class="btn-back">
        <i class="fas fa-arrow-left"></i>
    </a>

    <h1>Feedback Management</h1>

    <div class="filter-bar">
        <span class="filter-label"><i class="fas fa-filter"></i> Filter By:</span>
        <select id="filterCategory" class="filter-select" onchange="applyFilters()">
            <option value="all">All Categories</option>
            <option value="counselor behavior">Counselor Behavior</option>
            <option value="facility">Facility</option>
            <option value="system issue">System Issue</option>
            <option value="other">Other</option>
        </select>
        <select id="filterRating" class="filter-select" onchange="applyFilters()">
            <option value="all">All Ratings</option>
            <option value="5">5 Stars</option>
            <option value="4">4 Stars</option>
            <option value="3">3 Stars</option>
            <option value="2">2 Stars</option>
            <option value="1">1 Star</option>
        </select>
    </div>

    <div class="tabs">
        <button class="tab-btn active" onclick="openTab('pending')">
            Pending Review <span class="badge" id="pendingCount">${pendingList.size()}</span>
        </button>
        <button class="tab-btn" onclick="openTab('completed')">
            Completed <span class="badge" id="completedCount">${completedList.size()}</span>
        </button>
    </div>

    <div id="pending" class="tab-content active">
        <c:forEach items="${pendingList}" var="fb">
            <div class="feedback-card pending-card" onclick="toggleCard(this)"
                 data-category="${fb.category}" data-rating="${fb.rating}">
                <div class="card-header">
                    <div>
                        <span class="subject">${fb.subject}</span>
                        <span class="category-badge">${fb.category}</span>
                    </div>
                    <div class="meta-info">
                        <span class="star-rating"><i class="fas fa-star"></i> ${fb.rating}.0</span>
                        <span class="date">${fb.createdAt}</span>
                        <div class="chevron"><i class="fas fa-chevron-down"></i></div>
                    </div>
                </div>
                <div class="card-details" onclick="event.stopPropagation()">
                    <div class="message-box">
                        <strong style="display:block; margin-bottom: 8px; color: #003049; font-size: 13px; text-transform: uppercase;">
                            <i class="fas fa-comment-alt"></i> Student Message
                        </strong>
                        "${fb.message}"
                    </div>
                    <div class="reply-section">
                        <form action="${pageContext.request.contextPath}/admin/feedback/reply" method="post" class="reply-form">
                            <input type="hidden" name="id" value="${fb.id}">
                            <div class="reply-container">
                                <textarea name="reply" placeholder="Type your official response here..." required></textarea>
                                <button type="submit" class="btn-reply"><i class="fas fa-paper-plane"></i> Send Response</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty pendingList}">
            <div class="empty-state">
                <i class="fas fa-check-circle" style="font-size: 40px; margin-bottom: 15px; color: #E0E0E0;"></i>
                <p>All caught up! No pending reviews.</p>
            </div>
        </c:if>
    </div>

    <div id="completed" class="tab-content">
        <c:forEach items="${completedList}" var="fb">
            <div class="feedback-card completed-card" onclick="toggleCard(this)"
                 data-category="${fb.category}" data-rating="${fb.rating}">
                <div class="card-header">
                    <div>
                        <span class="subject">${fb.subject}</span>
                        <span class="category-badge">${fb.category}</span>
                    </div>
                    <div class="meta-info">
                        <span class="star-rating"><i class="fas fa-star"></i> ${fb.rating}.0</span>
                        <span class="date">${fb.createdAt}</span>
                        <div class="chevron"><i class="fas fa-chevron-down"></i></div>
                    </div>
                </div>
                <div class="card-details" onclick="event.stopPropagation()">
                    <div class="message-box">
                        <strong style="display:block; margin-bottom: 8px; color: #003049; font-size: 13px; text-transform: uppercase;">
                            <i class="fas fa-comment-alt"></i> Student Message
                        </strong>
                        "${fb.message}"
                    </div>
                    <div class="reply-section">
                        <div class="reply-display">
                            <strong style="display: block; margin-bottom: 8px; color: #00695C;">
                                <i class="fas fa-check-double"></i> Admin Response
                            </strong>
                            ${fb.adminReply}
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty completedList}"><p class="empty-state">No completed reviews yet.</p></c:if>
    </div>
</div>

<script>
    function toggleCard(card) {
        const isActive = card.classList.contains('active');
        document.querySelectorAll('.feedback-card').forEach(c => {
            c.classList.remove('active');
            c.querySelector('.card-details').style.display = 'none';
        });

        if (!isActive) {
            card.classList.add('active');
            const details = card.querySelector('.card-details');
            details.style.display = "block";
        }
    }

    function openTab(tabName) {
        document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        document.getElementById(tabName).classList.add('active');
        event.currentTarget.classList.add('active');
    }

    function applyFilters() {
        let category = document.getElementById('filterCategory').value.toLowerCase();
        let rating = document.getElementById('filterRating').value;
        let cards = document.querySelectorAll('.feedback-card');
        
        cards.forEach(card => {
            let cardCat = card.getAttribute('data-category').toLowerCase();
            let cardRate = card.getAttribute('data-rating');
            let matchCat = (category === 'all' || cardCat === category);
            let matchRate = (rating === 'all' || cardRate === rating);
            card.style.display = (matchCat && matchRate) ? 'block' : 'none';
        });
    }
</script>

</body>
</html>