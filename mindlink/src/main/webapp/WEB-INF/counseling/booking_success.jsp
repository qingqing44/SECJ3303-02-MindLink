<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Successful | MindLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #003049;
            --accent-pink: #F497AA;
            --accent-orange: #F77F00;
            --success-green: #48C9B0;
            --bg-color: #FFF3E0;
            --glass-white: rgba(255, 255, 255, 0.95);
            --text-grey: #666;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            /* 🟢 Interactive Gradient Background */
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(244, 151, 170, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 90% 80%, rgba(247, 127, 0, 0.1) 0%, transparent 50%);
            margin: 0; padding: 40px 20px;
            color: var(--primary);
            min-height: 100vh;
            display: flex; flex-direction: column; align-items: center;
            position: relative; overflow-x: hidden;
        }

        /* 🟢 ANIMATED BACKGROUND BLOBS */
        .blob {
            position: absolute; filter: blur(60px); z-index: -1; opacity: 0.6;
            animation: float 10s ease-in-out infinite;
        }
        .blob-1 { top: -50px; left: -50px; width: 400px; height: 400px; background: rgba(244, 151, 170, 0.2); border-radius: 40% 60% 70% 30%; }
        .blob-2 { bottom: -50px; right: -50px; width: 500px; height: 500px; background: rgba(72, 201, 176, 0.15); border-radius: 60% 40% 30% 70%; animation-direction: reverse; }
        
        @keyframes float {
            0% { transform: translate(0, 0) rotate(0deg); }
            50% { transform: translate(20px, 20px) rotate(5deg); }
            100% { transform: translate(0, 0) rotate(0deg); }
        }

        /* 🟢 BACK ICON */
        .back-nav {
            position: absolute; top: 40px; left: 40px;
        }
        .back-btn {
            display: inline-flex; align-items: center; justify-content: center;
            width: 45px; height: 45px; border-radius: 50%;
            background: rgba(255, 255, 255, 0.8);
            color: var(--primary); font-size: 18px; text-decoration: none;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05); transition: 0.2s;
        }
        .back-btn:hover { transform: translateX(-3px); background: white; color: var(--accent-orange); }

        /* MAIN CARD */
        .success-card {
            background: var(--glass-white);
            backdrop-filter: blur(10px);
            border-radius: 30px;
            padding: 50px;
            max-width: 700px; width: 100%;
            box-shadow: 0 20px 50px rgba(0,0,0,0.08);
            text-align: center;
            border: 1px solid rgba(255,255,255,0.8);
            animation: slideUp 0.5s ease-out;
            margin-top: 40px;
        }

        @keyframes slideUp { from { transform: translateY(20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }

        /* 🟢 ANIMATED CHECKMARK */
        .success-icon-wrapper {
            width: 80px; height: 80px; margin: 0 auto 20px;
            background: #E0F2F1; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            animation: popIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275) 0.2s both;
        }
        .success-icon { font-size: 40px; color: var(--success-green); }

        @keyframes popIn { from { transform: scale(0); } to { transform: scale(1); } }

        h1 { font-size: 32px; font-weight: 800; margin: 0 0 10px 0; color: var(--primary); }
        .subtitle { color: var(--text-grey); font-size: 16px; margin-bottom: 40px; }

        /* DETAILS GRID */
        .details-box {
            background: #FAFAFA; border-radius: 20px; padding: 30px;
            border: 1px solid #eee; margin-bottom: 40px;
            text-align: left;
        }
        
        .grid-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px; }
        .grid-item { display: flex; flex-direction: column; }
        
        .label { font-size: 12px; text-transform: uppercase; letter-spacing: 0.5px; color: #888; font-weight: 600; margin-bottom: 5px; }
        .value { font-size: 16px; font-weight: 700; color: var(--primary); display: flex; align-items: center; gap: 8px; }
        .value i { color: var(--accent-pink); width: 20px; text-align: center; }

        .full-width { grid-column: span 2; border-top: 1px solid #eee; padding-top: 20px; }

        /* BUTTONS */
        .btn-group { display: flex; gap: 15px; justify-content: center; flex-wrap: wrap; }
        
        .btn {
            padding: 14px 30px; border-radius: 50px; font-weight: 700; font-size: 14px;
            cursor: pointer; text-decoration: none; transition: 0.2s; display: inline-flex; align-items: center; gap: 8px; border: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #F497AA, #F77F00);
            color: white; box-shadow: 0 8px 20px rgba(244, 151, 170, 0.4);
        }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 12px 25px rgba(244, 151, 170, 0.5); }

        .btn-secondary { background: white; border: 2px solid #eee; color: var(--primary); }
        .btn-secondary:hover { border-color: var(--primary); background: white; }

        .btn-danger { background: #FFF5F5; color: #E53935; }
        .btn-danger:hover { background: #FFEBEE; }

        /* EMPTY STATE */
        .error-state { color: #E53935; font-weight: 600; margin-bottom: 20px; }

        @media (max-width: 600px) {
            .grid-row { grid-template-columns: 1fr; }
            .full-width { grid-column: span 1; }
            .back-nav { top: 20px; left: 20px; }
            .success-card { padding: 30px 20px; margin-top: 60px; }
        }
    </style>
</head>
<body>

    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

    <div class="back-nav">
        <a href="${pageContext.request.contextPath}/counseling/home" class="back-btn" title="Back to Dashboard">
            <i class="fas fa-arrow-left"></i>
        </a>
    </div>

    <div class="success-card">
        
        <c:if test="${not empty bookingId}">
            <div class="success-icon-wrapper">
                <i class="fas fa-check success-icon"></i>
            </div>

            <h1>Booking Confirmed!</h1>
            <p class="subtitle">Your appointment has been successfully scheduled. We've sent a confirmation email to you.</p>

            <div class="details-box">
                <div class="grid-row">
                    <div class="grid-item">
                        <span class="label">Counselor</span>
                        <span class="value"><i class="fas fa-user-md"></i> ${counselorName}</span>
                    </div>
                    <div class="grid-item">
                        <span class="label">Booking ID</span>
                        <span class="value"><i class="fas fa-hashtag"></i> ${bookingId}</span>
                    </div>
                </div>
                
                <div class="grid-row">
                    <div class="grid-item">
                        <span class="label">Date</span>
                        <span class="value"><i class="far fa-calendar-alt"></i> ${date}</span>
                    </div>
                    <div class="grid-item">
                        <span class="label">Time</span>
                        <span class="value"><i class="far fa-clock"></i> ${time}</span>
                    </div>
                </div>

                <div class="grid-row">
                    <div class="grid-item full-width">
                        <span class="label">Venue / Link</span>
                        <c:choose>
                            <c:when test="${venue.startsWith('http')}">
                                <span class="value">
                                    <i class="fas fa-video"></i> 
                                    <a href="${venue}" target="_blank" style="color: #007bff; text-decoration: none; border-bottom: 1px dotted #007bff;">
                                        Join Online Meeting
                                    </a>
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="value"><i class="fas fa-map-marker-alt"></i> ${venue}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/counseling/home" class="btn btn-primary">
                    Go to Dashboard <i class="fas fa-arrow-right"></i>
                </a>

                <a href="${pageContext.request.contextPath}/counseling/booking?rescheduleId=${bookingId}" class="btn btn-secondary">
                    Reschedule
                </a>

                <a href="${pageContext.request.contextPath}/counseling/booking/cancel?id=${bookingId}" 
                   class="btn btn-danger" 
                   onclick="return confirm('Are you sure you want to cancel this booking?');">
                    Cancel
                </a>
            </div>
        </c:if>

        <c:if test="${empty bookingId}">
            <div class="error-state">
                <i class="fas fa-exclamation-circle" style="font-size: 40px; margin-bottom: 10px; display:block;"></i>
                No booking details found.
            </div>
            <p class="subtitle">It seems you haven't made a booking yet or the session expired.</p>
            <a href="${pageContext.request.contextPath}/counseling/booking" class="btn btn-primary">
                Book an Appointment
            </a>
        </c:if>

    </div>

</body>
</html>