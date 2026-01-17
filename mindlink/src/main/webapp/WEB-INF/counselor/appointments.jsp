<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Schedule | MindLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root {
            --bg-color: #FFF3E0; 
            --text-dark: #003049; 
            --card-bg: rgba(255, 255, 255, 0.9); /* Slightly transparent */
            --btn-orange: #F77F00;
            --btn-hover: #D62828;
            --text-grey: #555;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            /* FANCY BACKGROUND */
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(247, 127, 0, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 90% 80%, rgba(72, 201, 176, 0.1) 0%, transparent 50%);
            margin: 0;
            padding: 0;
            color: var(--text-dark);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /*  ANIMATED BLOBS (Consistent with Dashboard) */
        .blob {
            position: absolute;
            filter: blur(60px);
            z-index: -1;
            opacity: 0.6;
            animation: float 10s ease-in-out infinite;
        }
        .blob-1 {
            top: 100px; left: -50px;
            width: 400px; height: 400px;
            background: rgba(247, 127, 0, 0.15);
            border-radius: 40% 60% 70% 30%;
        }
        .blob-2 {
            bottom: 50px; right: -50px;
            width: 500px; height: 500px;
            background: rgba(72, 201, 176, 0.15);
            border-radius: 60% 40% 30% 70%;
            animation-direction: reverse;
        }
        @keyframes float {
            0% { transform: translate(0, 0) rotate(0deg); }
            50% { transform: translate(20px, 20px) rotate(5deg); }
            100% { transform: translate(0, 0) rotate(0deg); }
        }

        /* --- Navbar --- */
        .header {
            position: fixed;
            top: 0; left: 0; width: 100%;
            z-index: 1000;
            padding: 15px 50px;
            display: flex; justify-content: space-between; align-items: center;
            background: rgba(255, 255, 255, 0.95); /* Slight blur for navbar */
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            box-sizing: border-box;
        }

        .nav-left, .nav-right {
            display: flex; align-items: center; justify-content: space-evenly; flex: 1; gap: 0;
        }

        .nav-left a, .nav-right a {
            text-decoration: none; color: #00313e; font-size: 16px; font-weight: 500; transition: color 0.3s;
        }
        .nav-left a:hover, .nav-right a:hover { color: var(--btn-orange); }

        .logo {
            display: flex; align-items: center; gap: 10px;
            font-weight: 700; color: #00313e; font-size: 32px; text-decoration: none;
        }
        .logo-icon { width: 40px; height: 40px; }
        .logo-icon img { width: 100%; height: 100%; object-fit: contain; }

        /* --- Main Container --- */
        .container { 
            max-width: 850px; 
            margin: 0 auto; 
            padding: 130px 20px 80px; 
        }
        
        .page-header { margin-bottom: 30px; text-align: center; }
        .page-header h1 { 
            font-size: 42px; font-weight: 800; margin: 0; 
            background: -webkit-linear-gradient(45deg, #003049, #F77F00);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        /* --- Search Form --- */
        .search-form {
            margin-bottom: 35px; 
            display: flex; gap: 10px;
            background: white;
            padding: 8px 8px 8px 25px;
            border-radius: 50px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.05);
            border: 1px solid rgba(0,0,0,0.02);
            transition: transform 0.2s;
        }
        .search-form:focus-within { transform: scale(1.01); box-shadow: 0 10px 30px rgba(0,0,0,0.08); }

        .search-input {
            flex: 1; border: none; background: transparent;
            font-family: 'Inter', sans-serif; font-size: 16px; outline: none; color: #333;
        }

        .btn-search {
            background: var(--text-dark); color: white; border: none; 
            padding: 12px 35px; border-radius: 50px; cursor: pointer;
            font-weight: 600; font-size: 15px; transition: background 0.2s;
        }
        .btn-search:hover { background: #004d73; }

        /* --- TABS --- */
        .tab-container {
            display: flex; justify-content: center; gap: 30px;
            margin-bottom: 40px;
        }

        .tab-btn {
            background: transparent; border: none;
            font-family: 'Inter', sans-serif; font-weight: 600; font-size: 18px;
            color: #999; cursor: pointer; padding: 10px 10px;
            position: relative; transition: all 0.3s;
        }

        .tab-btn::after {
            content: ''; position: absolute; bottom: 0; left: 50%; width: 0; height: 3px;
            background: var(--btn-orange); transition: all 0.3s ease; transform: translateX(-50%);
            border-radius: 3px;
        }

        .tab-btn:hover { color: var(--text-dark); }
        .tab-btn.active { color: var(--text-dark); font-weight: 700; }
        .tab-btn.active::after { width: 100%; }

        /* --- APPOINTMENT CARDS --- */
        .tab-section { display: none; }
        .tab-section.active-section { display: block; }
        
        .appt-card {
            background: var(--card-bg);
            backdrop-filter: blur(5px);
            border-radius: 16px;
            padding: 25px 35px;
            margin-bottom: 20px;
            display: flex; justify-content: space-between; align-items: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            border: 1px solid rgba(255,255,255,0.8);
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            position: relative; overflow: hidden;
            animation: slideUp 0.5s ease-out forwards;
            opacity: 0; transform: translateY(20px);
        }

        /* Stagger animation for items */
        .appt-card:nth-child(1) { animation-delay: 0.1s; }
        .appt-card:nth-child(2) { animation-delay: 0.2s; }
        .appt-card:nth-child(3) { animation-delay: 0.3s; }
        .appt-card:nth-child(4) { animation-delay: 0.4s; }

        @keyframes slideUp { to { opacity: 1; transform: translateY(0); } }

        .appt-card:hover { transform: translateY(-5px); box-shadow: 0 15px 30px rgba(0,0,0,0.1); }

        /* Colored Strip Indicator */
        .appt-card::before {
            content: ''; position: absolute; left: 0; top: 0; bottom: 0; width: 6px;
            background: var(--btn-orange);
        }
        .history-card::before { background: #B0BEC5; }

        .card-left { display: flex; gap: 25px; align-items: center; }
        
        /* Date Box Icon */
        .date-box {
            width: 60px; height: 60px;
            background: #FFF; 
            color: var(--btn-orange);
            border-radius: 14px;
            display: flex; flex-direction: column; 
            align-items: center; justify-content: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            font-weight: 800; font-size: 20px;
        }
        .date-label { font-size: 10px; text-transform: uppercase; font-weight: 600; color: #999; margin-top: -2px; }
        
        .history-card .date-box { color: #777; }
        
        /* Typography */
        .student-name { margin: 0 0 6px 0; font-size: 19px; font-weight: 700; color: var(--text-dark); }
        .session-meta { color: var(--text-grey); font-size: 14px; font-weight: 500; display: flex; align-items: center; gap: 8px; }

        .btn-view {
            background: white; color: var(--text-dark);
            border: 2px solid #EEE;
            padding: 10px 25px; border-radius: 50px; 
            text-decoration: none; font-weight: 600; font-size: 14px;
            transition: all 0.2s;
        }
        .btn-view:hover { 
            background: var(--text-dark); color: white; border-color: var(--text-dark);
        }

        .empty-state {
            text-align: center; padding: 60px; color: #888;
            background: rgba(255,255,255,0.4); border-radius: 20px;
            border: 2px dashed #E0E0E0;
        }

    </style>
</head>
<body>

    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

    <div class="header">
        <div class="nav-left">
            <a href="${pageContext.request.contextPath}/counselor/dashboard">Home</a>
            <a href="${pageContext.request.contextPath}/counselor/appointments" style="color:var(--btn-orange);">Appointment</a>
        </div>

        <a href="${pageContext.request.contextPath}/counselor/dashboard" class="logo">
            <div class="logo-icon">
                <img src="${pageContext.request.contextPath}/images/mindlink.png" alt="MindLink">
            </div>
            <span>MindLink</span>
        </a>

        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/counselor/profile">Profile</a>
            <a href="${pageContext.request.contextPath}/logout" style="color: #D62828;">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="page-header">
            <h1>My Schedule</h1>
        </div>

        <form action="${pageContext.request.contextPath}/counselor/appointments" method="get" class="search-form">
            <input type="text" name="search" placeholder="Search by Student Name or Date..." 
                   value="${currentSearch}" class="search-input">
            <button type="submit" class="btn-search"><i class="fas fa-search"></i> Search</button>
            <c:if test="${not empty currentSearch}">
                <a href="${pageContext.request.contextPath}/counselor/appointments" 
                   style="display:flex; align-items:center; color:#D62828; text-decoration:none; padding-right: 15px; font-weight: 600; margin-left: 10px;">
                   <i class="fas fa-times"></i>
                </a>
            </c:if>
        </form>

        <div class="tab-container">
            <button class="tab-btn active" onclick="switchTab('upcoming')">Upcoming</button>
            <button class="tab-btn" onclick="switchTab('history')">History</button>
        </div>

        <div id="tab-upcoming" class="tab-section active-section">
            <c:set var="hasUpcoming" value="false" />
            
            <c:forEach items="${appointments}" var="app">
                <c:if test="${app.upcoming}">
                    <c:set var="hasUpcoming" value="true" />
                    
                    <div class="appt-card">
                        <div class="card-left">
                            <div class="date-box">
                                <i class="far fa-calendar" style="font-size: 22px;"></i>
                            </div>
                            <div>
                                <h3 class="student-name">
                                    ${app.studentName != null ? app.studentName : 'Unknown Student'}
                                </h3>
                                <div class="session-meta">
                                    <span><i class="far fa-clock"></i> ${app.date} at ${app.time}</span>
                                    <span style="color: #DDD;">|</span>
                                    <span>${app.type}</span>
                                </div>
                            </div>
                        </div>

                        <a href="${pageContext.request.contextPath}/counselor/appointment?id=${app.id}" class="btn-view">
                            Details <i class="fas fa-arrow-right" style="margin-left: 5px;"></i>
                        </a>
                    </div>
                </c:if>
            </c:forEach>

            <c:if test="${not hasUpcoming}">
                <div class="empty-state">
                    <i class="fas fa-mug-hot" style="font-size: 40px; margin-bottom: 15px; color: #CCC; display:block;"></i>
                    No upcoming sessions. Enjoy your free time!
                </div>
            </c:if>
        </div>

        <div id="tab-history" class="tab-section">
            <c:set var="hasHistory" value="false" />

            <c:forEach items="${appointments}" var="app">
                <c:if test="${!app.upcoming}">
                    <c:set var="hasHistory" value="true" />

                    <div class="appt-card history-card">
                        <div class="card-left">
                            <div class="date-box">
                                <i class="fas fa-history"></i>
                            </div>
                            <div>
                                <h3 class="student-name" style="color: #666;">
                                    ${app.studentName != null ? app.studentName : 'Unknown Student'}
                                </h3>
                                <div class="session-meta">
                                    <span>${app.date}</span>
                                    <span style="color: #DDD;">|</span>
                                    <span>${app.status}</span>
                                </div>
                            </div>
                        </div>

                        <a href="${pageContext.request.contextPath}/counselor/appointment?id=${app.id}" class="btn-view">
                            Summary
                        </a>
                    </div>
                </c:if>
            </c:forEach>

            <c:if test="${not hasHistory}">
                <div class="empty-state">
                    <i class="fas fa-folder-open" style="font-size: 40px; margin-bottom: 15px; color: #CCC; display:block;"></i>
                    No past session history found.
                </div>
            </c:if>
        </div>

    </div>

    <script>
        function switchTab(tabName) {
            // Hide all sections
            document.querySelectorAll('.tab-section').forEach(el => el.classList.remove('active-section'));
            // Deactivate all buttons
            document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));

            // Show selected
            document.getElementById('tab-' + tabName).classList.add('active-section');

            // Highlight button
            if(tabName === 'upcoming') {
                document.querySelector('.tab-btn:nth-child(1)').classList.add('active');
            } else {
                document.querySelector('.tab-btn:nth-child(2)').classList.add('active');
            }
        }
    </script>

</body>
</html>