<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Appointment History | MindLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #003049;
            --accent-pink: #F497AA;
            --accent-orange: #F77F00;
            --bg-color: #FFF3E0;
            --glass-white: rgba(255, 255, 255, 0.9);
            --text-grey: #555;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            /* 🟢 Pink & Orange Gradient Background */
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(244, 151, 170, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 90% 80%, rgba(247, 127, 0, 0.1) 0%, transparent 50%);
            margin: 0; 
            padding: 40px 20px;
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
        .blob-1 { top: -50px; left: -50px; width: 400px; height: 400px; background: rgba(244, 151, 170, 0.2); border-radius: 40% 60% 70% 30%; }
        .blob-2 { bottom: -50px; right: -50px; width: 600px; height: 600px; background: rgba(247, 127, 0, 0.15); border-radius: 60% 40% 30% 70%; animation-direction: reverse; }
        
        @keyframes float {
            0% { transform: translate(0, 0) rotate(0deg); }
            50% { transform: translate(20px, 20px) rotate(5deg); }
            100% { transform: translate(0, 0) rotate(0deg); }
        }

        /* CONTAINER */
        .container { max-width: 1000px; margin: 0 auto; position: relative; z-index: 1; }

        /* 🟢 BACK BUTTON (Icon Style) */
        .btn-back { 
            display: inline-flex; align-items: center; justify-content: center;
            width: 45px; height: 45px; border-radius: 50%;
            background: white; color: var(--primary);
            font-size: 18px; text-decoration: none;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            transition: 0.2s; margin-bottom: 20px;
        }
        .btn-back:hover { background: var(--accent-pink); color: white; transform: translateX(-5px); }

        /* HEADER */
        h1 { font-size: 32px; font-weight: 800; margin-bottom: 10px; text-align: center; color: var(--primary); }
        .subtitle { color: var(--text-grey); margin-bottom: 40px; font-size: 16px; text-align: center; }

        /* HISTORY LIST */
        .history-list { display: flex; flex-direction: column; gap: 20px; }

        /* 🟢 GLASS CARD */
        .history-card {
            background: var(--glass-white);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            display: grid;
            grid-template-columns: 1fr auto;
            align-items: center;
            transition: transform 0.2s;
            border: 1px solid rgba(255,255,255,0.6);
            /* Pink accent border on the left */
            border-left: 6px solid var(--accent-pink);
        }
        .history-card:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); }

        .card-content { display: flex; flex-direction: column; gap: 8px; }

        .counselor-name { font-size: 18px; font-weight: 700; color: var(--primary); display: flex; align-items: center; gap: 10px; }
        
        /* Badge style */
        .badge { 
            background: #FFF0F3; /* Light Pink */
            color: #D81B60;      /* Dark Pink */
            padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; 
        }

        .details-row { font-size: 14px; color: #555; display: flex; gap: 20px; align-items: center; margin-top: 5px; }
        .details-row i { color: var(--accent-pink); width: 20px; text-align: center; }

        .booking-id { font-size: 12px; color: #999; margin-top: 5px; font-family: monospace; }

        /* BUTTON */
        .btn-view {
            background-color: var(--primary);
            color: white;
            text-decoration: none;
            padding: 12px 25px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 14px;
            transition: 0.2s;
            box-shadow: 0 4px 10px rgba(0, 48, 73, 0.2);
        }
        .btn-view:hover { background-color: var(--accent-orange); transform: translateY(-2px); }
        
        /* Empty State */
        .empty-state { 
            text-align: center; padding: 50px; 
            background: rgba(255,255,255,0.6); 
            border-radius: 16px; color: #888; 
            border: 2px dashed #ddd;
        }

        @media (max-width: 600px) {
            .history-card { grid-template-columns: 1fr; gap: 20px; }
            .details-row { flex-wrap: wrap; gap: 10px; }
        }
    </style>
</head>
<body>

    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

    <div class="container">
        
        <a href="${pageContext.request.contextPath}/counseling/home" class="btn-back" title="Back to Dashboard">
            <i class="fas fa-arrow-left"></i>
        </a>

        <h1>Appointment History</h1>
        <p class="subtitle">View details of your past counseling sessions.</p>

        <div class="history-list">
            
            <c:forEach items="${appointments}" var="app">
                <div class="history-card">
                    
                    <div class="card-content">
                        <div class="counselor-name">
                            ${app.counselorName}
                            <span class="badge">Completed</span>
                        </div>
                        
                        <div class="details-row">
                            <span><i class="far fa-calendar-alt"></i> ${app.date}</span>
                            <span><i class="far fa-clock"></i> ${app.time}</span>
                            <span>
                                <c:choose>
                                    <c:when test="${app.venue.startsWith('http')}">
                                        <i class="fas fa-video"></i> Online
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-map-marker-alt"></i> Physical
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        
                        <div class="booking-id">ID: ${app.id}</div>
                    </div>

                    <div>
                        <a href="${pageContext.request.contextPath}/counseling/history/view?id=${app.id}" class="btn-view">
                            View Details <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty appointments}">
                <div class="empty-state">
                    <i class="fas fa-history" style="font-size: 40px; margin-bottom: 15px; color: var(--accent-pink);"></i>
                    <p>No appointment history found.</p>
                    <a href="${pageContext.request.contextPath}/counseling/booking" 
                       style="color: var(--accent-orange); font-weight: 600; text-decoration: none;">
                       Book a Session
                    </a>
                </div>
            </c:if>

        </div>
    </div>

</body>
</html>