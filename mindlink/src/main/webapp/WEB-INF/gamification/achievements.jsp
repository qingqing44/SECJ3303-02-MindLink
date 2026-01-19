<%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>MindLink - Achievement Dashboard</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: #FFF3E0;
                color: #003049;
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

            /* Main Container */
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 40px 20px;
            }

            /* Top Bar */
            .top-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .back-btn,
            .share-btn {
                background: none;
                border: none;
                cursor: pointer;
                padding: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: transform 0.2s;
            }

            .back-btn img,
            .share-btn img {
                width: 40px;
                height: 40px;
            }

            .page-title {
                font-size: 24px;
                font-weight: 700;
                color: #003049;
            }


            /* Badge Grid */
            .badge-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 40px;
                margin-bottom: 50px;
            }

            .badge-card {
                background: white;
                padding: 30px 20px;
                border-radius: 20px;
                text-align: center;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            }

            .badge-card img {
                width: 100px;
                height: 100px;
                margin-bottom: 15px;
                transition: all 0.3s;
            }

            .badge-card.unlocked img {
                filter: none;
                opacity: 1;
                transform: scale(1.05);
            }

            .badge-card p {
                font-size: 14px;
                font-weight: 600;
                color: #003049;
            }

            @media (max-width: 768px) {
                .badge-grid {
                    grid-template-columns: repeat(2, 1fr);
                    gap: 20px;
                }

                .header {
                    padding: 20px;
                }
            }
        </style>
    </head>

    <body>

        <!-- Header Navigation -->
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
                <a href="${pageContext.request.contextPath}/forum/welcome">Forum</a>
                <a href="${pageContext.request.contextPath}/profile">Profile</a>
            </div>
        </div>

        <div class="container">
            <!-- Top Bar -->
            <div class="top-bar">
                <button class="back-btn" onclick="window.history.back()">
                    <img src="${pageContext.request.contextPath}/images/back-arrow.png" alt="Back">
                </button>
                <h1 class="page-title">Achievement Dashboard</h1>
                <button class="share-btn">
                    <img src="${pageContext.request.contextPath}/images/share_icon.png" alt="Share">
                </button>
            </div>

            <div class="badge-grid">
                <c:forEach var="ach" items="${achievements}">
                    <c:if test="${ach.unlocked}">
                        <div class="badge-card unlocked"
                            onclick="showDetail('${ach.title}', '${ach.description}', '${ach.iconPath}', '${ach.unlockedDate}')">
                            <img src="${pageContext.request.contextPath}/images/${ach.iconPath}" alt="${ach.title}">
                            <p>${ach.title}</p>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <div id="badgeModal"
            style="display:none; position:fixed; z-index:1000; left:0; top:0; width:100%; height:100%; background:rgba(0,0,0,0.8); align-items:center; justify-content:center;">
            <div
                style="background:white; padding:40px; border-radius:20px; text-align:center; max-width:400px; box-shadow: 0 5px 15px rgba(0,0,0,0.5);">
                <img id="modalIcon" src="" style="width:120px; margin-bottom:20px;">
                <h2 id="modalTitle" style="color:#003049; margin-bottom:10px;"></h2>
                <p id="modalDesc" style="color:#666; margin-bottom:20px;"></p>
                <div style="border-top: 1px solid #eee; padding-top:20px;">
                    <p style="font-size:0.9rem; color:#013B46;"><strong>Achieved on:</strong> <span
                            id="modalDate"></span></p>
                </div>
                <button onclick="document.getElementById('badgeModal').style.display='none'"
                    style="margin-top:25px; padding:10px 25px; background:#013B46; color:white; border:none; border-radius:5px; cursor:pointer;">
                    Close
                </button>
            </div>
        </div>

        <script>
            function showDetail(title, desc, icon, date) {
                document.getElementById('modalTitle').innerText = title;
                document.getElementById('modalDesc').innerText = desc;
                document.getElementById('modalIcon').src = "${pageContext.request.contextPath}/images/" + icon;
                document.getElementById('modalDate').innerText = (date && date !== "") ? date : "Recently Unlocked";
                document.getElementById('badgeModal').style.display = 'flex';
            }
        </script>
    </body>

    </html>