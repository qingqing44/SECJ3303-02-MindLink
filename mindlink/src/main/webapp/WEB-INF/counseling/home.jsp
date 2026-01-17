<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Counseling Dashboard | MindLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root { 
            --bg-color: #FFF3E0; 
            --primary: #003049; 
            --accent-pink: #F497AA; /* Pink */
            --accent-orange: #F77F00;
            --white: #ffffff;
            --card-bg-glass: rgba(255, 255, 255, 0.85);
        }
        
        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-color); 
            /* 🟢 Pink & Orange Background Gradient */
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(244, 151, 170, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 90% 80%, rgba(247, 127, 0, 0.1) 0%, transparent 50%);
            margin: 0; 
            padding: 0; 
            color: var(--primary); 
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* 🟢 ANIMATED BLOBS */
        .blob {
            position: absolute; filter: blur(60px); z-index: -1; opacity: 0.7;
            animation: float 10s ease-in-out infinite;
        }
        /* Pink Blob */
        .blob-1 { top: 120px; left: -50px; width: 400px; height: 400px; background: rgba(244, 151, 170, 0.25); border-radius: 40% 60% 70% 30%; }
        /* Orange Blob */
        .blob-2 { bottom: 50px; right: -50px; width: 500px; height: 500px; background: rgba(247, 127, 0, 0.15); border-radius: 60% 40% 30% 70%; animation-direction: reverse; }
        
        @keyframes float {
            0% { transform: translate(0, 0) rotate(0deg); }
            50% { transform: translate(20px, 20px) rotate(5deg); }
            100% { transform: translate(0, 0) rotate(0deg); }
        }
        
        /* 🟢 HEADER NAVIGATION */
        .header-nav {
            position: fixed; top: 0; left: 0; width: 100%; z-index: 1000;
            padding: 15px 50px; display: flex; justify-content: space-between; align-items: center;
            background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); box-sizing: border-box;
        }
        .nav-left, .nav-right { display: flex; align-items: center; justify-content: space-evenly; flex: 1; gap: 0; }
        .nav-left a, .nav-right a { text-decoration: none; color: #00313e; font-size: 16px; font-weight: 500; transition: color 0.3s; }
        .nav-left a:hover, .nav-right a:hover { color: var(--accent-orange); }
        .logo { display: flex; align-items: center; gap: 10px; font-weight: 700; color: #00313e; font-size: 32px; text-decoration: none; }
        .logo-icon { width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; }
        .logo-icon img { width: 100%; height: 100%; object-fit: contain; }

        /* MAIN CONTAINER */
        .container { 
            max-width: 1100px; 
            margin: 0 auto; 
            /* Top padding to clear fixed header */
            padding: 140px 20px 60px; 
        }
        
        /* 🟢 ICON ONLY BACK BUTTON */
        .back-btn {
            display: inline-flex; align-items: center; justify-content: center;
            text-decoration: none; color: var(--primary); 
            background: white;
            width: 45px; height: 45px;
            border-radius: 50%;
            font-size: 18px;
            margin-bottom: 20px; 
            transition: all 0.2s;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        .back-btn:hover { background: var(--accent-pink); color: white; transform: translateX(-5px); }

        /* DASHBOARD HEADER */
        .dashboard-header { margin-bottom: 40px; }
        .dashboard-header h1 { 
            font-size: 42px; /* Larger */
            font-weight: 800; /* Bolder */
            margin: 0; 
            color: var(--primary);
            letter-spacing: -1px;
        }
        .dashboard-header p { color: #555; margin-top: 5px; font-size: 18px; }

        /* DASHBOARD CARDS */
        .dashboard-grid { 
            display: grid; 
            grid-template-columns: repeat(3, 1fr); 
            gap: 25px; 
            margin-bottom: 50px; 
        }

        .action-card {
            background: var(--card-bg-glass); /* Glass Effect */
            backdrop-filter: blur(5px);
            padding: 30px;
            border-radius: 20px;
            text-decoration: none;
            color: var(--primary);
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: transform 0.2s, box-shadow 0.2s;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            justify-content: space-between;
            height: 160px;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.6);
        }

        .action-card:hover { transform: translateY(-8px); box-shadow: 0 15px 30px rgba(0,0,0,0.1); }
        
        .card-icon { 
            font-size: 32px; 
            margin-bottom: 15px; 
            padding: 15px; 
            border-radius: 15px; 
        }

        .action-card h3 { margin: 0; font-size: 20px; font-weight: 700; z-index: 1; }
        .action-card p { margin: 5px 0 0 0; font-size: 14px; color: #666; z-index: 1; }
        
        /* Specific Card Styles with Pink Accents */
        .card-book { border-bottom: 5px solid var(--accent-pink); }
        .card-book .card-icon { background: #FCE4EC; color: #D81B60; } /* Pinkish Red */
        
        .card-browse { border-bottom: 5px solid #4FC3F7; }
        .card-browse .card-icon { background: #e1f5fe; color: #0288d1; }
        
        .card-history { border-bottom: 5px solid #AED581; }
        .card-history .card-icon { background: #f1f8e9; color: #689f38; }

        /* UPCOMING SESSIONS SECTION */
        .section-title { 
            font-size: 24px; 
            font-weight: 800; 
            margin-bottom: 25px; 
            border-left: 6px solid var(--accent-pink); /* Pink border */
            padding-left: 15px; 
            color: var(--primary);
        }

        .app-grid { display: grid; gap: 20px; }
        
        .app-card {
            background: rgba(255,255,255,0.9); 
            border-radius: 16px; 
            padding: 25px;
            display: flex; justify-content: space-between; align-items: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03); 
            border-left: 6px solid var(--primary);
            transition: transform 0.2s;
        }
        .app-card:hover { transform: scale(1.01); }
        
        .app-info h3 { margin: 0 0 5px 0; font-size: 18px; font-weight: 700; }
        .app-detail { color: #666; font-size: 14px; margin-top: 5px; }
        .app-detail i { width: 20px; text-align: center; color: var(--accent-pink); }

        .app-actions { display: flex; gap: 10px; }
        
        .btn-cancel {
            background: #ffebee; color: #c62828; padding: 10px 20px; border-radius: 50px;
            text-decoration: none; font-size: 13px; font-weight: 600; transition: 0.2s;
        }
        .btn-cancel:hover { background: #ffcdd2; }
        
        .btn-join {
            background: var(--primary); color: white; padding: 10px 20px; border-radius: 50px;
            text-decoration: none; font-size: 13px; font-weight: 600; transition: 0.2s;
        }
        .btn-join:hover { background: #005075; }

        /* Empty State */
        .empty-state { text-align: center; background: rgba(255,255,255,0.6); padding: 50px; border-radius: 16px; color: #888; border: 2px dashed #ddd; }
        
        /* Mobile Resp */
        @media (max-width: 900px) {
            .dashboard-grid { grid-template-columns: 1fr; }
            .header-nav { flex-direction: column; padding: 15px; }
            .container { padding-top: 160px; }
            .app-card { flex-direction: column; align-items: flex-start; gap: 15px; }
            .app-actions { width: 100%; justify-content: space-between; }
        }
    </style>
</head>
<body>

    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

    <div class="header-nav">
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
        
        <a href="${pageContext.request.contextPath}/learning" class="back-btn" title="Back">
            <i class="fas fa-arrow-left"></i>
        </a>

        <div class="dashboard-header">
            <h1>Counseling Dashboard</h1>
            <p>Manage your mental well-being journey.</p>
        </div>

        <div class="dashboard-grid">
            <a href="${pageContext.request.contextPath}/counseling/booking" class="action-card card-book">
                <div class="card-icon"><i class="far fa-calendar-plus"></i></div>
                <div>
                    <h3>Book Session</h3>
                    <p>Schedule a new appointment.</p>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/counseling/browse" class="action-card card-browse">
                <div class="card-icon"><i class="fas fa-user-md"></i></div>
                <div>
                    <h3>Browse Counselors</h3>
                    <p>View profiles & specialties.</p>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/counseling/history" class="action-card card-history">
                <div class="card-icon"><i class="fas fa-history"></i></div>
                <div>
                    <h3>Session History</h3>
                    <p>View past appointments.</p>
                </div>
            </a>
        </div>

        <div class="section-title">Upcoming Sessions</div>

        <c:if test="${empty appointments}">
            <div class="empty-state">
                <i class="far fa-calendar-check" style="font-size: 40px; margin-bottom: 15px; color: #F497AA;"></i>
                <p>You have no upcoming sessions scheduled.</p>
            </div>
        </c:if>

        <div class="app-grid">
            <c:forEach items="${appointments}" var="app">
                <div class="app-card">
                    <div class="app-info">
                        <h3>${app.counselorName}</h3>
                        <div class="app-detail">
                            <i class="far fa-calendar-alt"></i> ${app.date} &nbsp;|&nbsp; 
                            <i class="far fa-clock"></i> ${app.time}
                        </div>
                        <div class="app-detail">
                            <i class="fas fa-map-marker-alt"></i> ${app.venue}
                        </div>
                    </div>
                    
                    <div class="app-actions">
                        <a href="${pageContext.request.contextPath}/counseling/view?id=${app.id}" 
                           class="btn-join" style="margin-right: 5px;">
                            View
                        </a>

                        <c:if test="${app.venue.startsWith('http')}">
                            <a href="${app.venue}" target="_blank" class="btn-join">
                                Join <i class="fas fa-external-link-alt"></i>
                            </a>
                        </c:if>

                        <a href="${pageContext.request.contextPath}/counseling/booking/cancel?id=${app.id}" 
                           class="btn-cancel"
                           onclick="return confirm('Are you sure you want to cancel this session?');">
                            Cancel
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>

    </div>

</body>
</html>