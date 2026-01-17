<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Session Details | MindLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #003049;
            --accent-pink: #F497AA;
            --accent-orange: #F77F00;
            --success-green: #66BB6A;
            --bg-color: #FFF3E0;
            --glass-white: rgba(255, 255, 255, 0.9);
            --text-grey: #555;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            /* 🟢 MindLink Gradient Background */
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(244, 151, 170, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 90% 80%, rgba(247, 127, 0, 0.1) 0%, transparent 50%);
            margin: 0; padding: 40px 20px;
            color: var(--primary);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* 🟢 Animated Blobs */
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

        .container { max-width: 800px; margin: 0 auto; position: relative; z-index: 1; }
        
        /* 🟢 Icon Back Button */
        .btn-back { 
            display: inline-flex; align-items: center; justify-content: center;
            width: 45px; height: 45px; border-radius: 50%;
            background: white; color: var(--primary);
            font-size: 18px; text-decoration: none;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            transition: 0.2s; margin-bottom: 20px;
        }
        .btn-back:hover { background: var(--accent-pink); color: white; transform: translateX(-5px); }

        h1 { font-size: 32px; font-weight: 800; margin-bottom: 10px; color: var(--primary); }
        
        /* Status Badge */
        .status-badge {
            display: inline-flex; align-items: center; gap: 8px;
            background: #E8F5E9; color: var(--success-green); 
            padding: 6px 16px; border-radius: 20px; font-size: 14px; font-weight: 700; margin-bottom: 30px;
            border: 1px solid #C8E6C9;
        }

        /* 🟢 Main Glass Card */
        .card {
            background: var(--glass-white);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.05);
            border: 1px solid rgba(255,255,255,0.6);
            /* Top border accent */
            border-top: 6px solid var(--success-green);
        }

        .details-grid {
            display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-bottom: 40px;
            border-bottom: 1px solid rgba(0,0,0,0.05); padding-bottom: 30px;
        }
        
        .detail-item { margin-bottom: 20px; }
        .label { display: block; font-size: 12px; color: #888; margin-bottom: 5px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; }
        .value { font-size: 17px; font-weight: 600; color: #333; display: flex; align-items: center; gap: 10px; }
        .value i { color: var(--accent-pink); width: 20px; text-align: center; }

        /* BUTTONS */
        .action-area { display: flex; justify-content: center; margin-top: 20px; }

        .btn-feedback {
            background: linear-gradient(135deg, #F497AA, #F77F00);
            color: white; padding: 14px 35px; border-radius: 50px;
            text-decoration: none; font-weight: 700; font-size: 15px;
            display: flex; align-items: center; gap: 10px;
            box-shadow: 0 8px 20px rgba(244, 151, 170, 0.3);
            transition: 0.2s;
        }
        .btn-feedback:hover { transform: translateY(-3px); box-shadow: 0 12px 25px rgba(244, 151, 170, 0.4); }

        /* FEEDBACK SECTION */
        .feedback-container { margin-top: 20px; }
        .feedback-title { font-weight: 800; color: var(--primary); margin-bottom: 15px; font-size: 18px; display: flex; align-items: center; gap: 10px; }

        .student-msg {
            background: #FAFAFA; padding: 20px; border-radius: 16px; border-left: 5px solid #DDD;
            margin-bottom: 20px; font-size: 15px; line-height: 1.6; color: #555;
        }

        .admin-reply-box {
            background: #E0F2F1; padding: 20px; border-radius: 16px; border-left: 5px solid var(--success-green);
            color: #004D40; font-size: 15px; line-height: 1.6;
        }
        
        .reply-header { display: flex; align-items: center; gap: 8px; font-weight: 700; margin-bottom: 8px; color: var(--success-green); }
        .waiting-text { font-style: italic; color: #999; text-align: center; margin-top: 15px; font-size: 14px; }

        @media (max-width: 650px) {
            .details-grid { grid-template-columns: 1fr; gap: 15px; }
            .card { padding: 25px; }
        }

    </style>
</head>
<body>

    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

    <div class="container">
        
        <a href="${pageContext.request.contextPath}/counseling/history" class="btn-back" title="Back to History">
            <i class="fas fa-arrow-left"></i>
        </a>

        <h1>Session Details</h1>
        <div class="status-badge"><i class="fas fa-check-circle"></i> Completed</div>

        <div class="card">

            <div class="details-grid">
                <div>
                    <div class="detail-item">
                        <span class="label">Counselor</span>
                        <span class="value"><i class="fas fa-user-md"></i> ${app.counselorName}</span>
                    </div>
                    <div class="detail-item">
                        <span class="label">Date</span>
                        <span class="value"><i class="far fa-calendar-alt"></i> ${app.date}</span>
                    </div>
                    <div class="detail-item">
                        <span class="label">Session Type</span>
                        <span class="value"><i class="fas fa-laptop-medical"></i> ${app.type}</span>
                    </div>
                </div>

                <div>
                    <div class="detail-item">
                        <span class="label">Booking ID</span>
                        <span class="value"><i class="fas fa-hashtag"></i> #${app.id}</span>
                    </div>
                    <div class="detail-item">
                        <span class="label">Time</span>
                        <span class="value"><i class="far fa-clock"></i> ${app.time}</span>
                    </div>
                    <div class="detail-item">
                        <span class="label">Venue / Link</span>
                        <span class="value">
                            <c:choose>
                                <c:when test="${app.venue.startsWith('http')}">
                                    <i class="fas fa-link"></i>
                                    <a href="${app.venue}" target="_blank" style="color: var(--accent-orange); text-decoration: underline; font-size: 16px;">
                                        Open Link
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-map-marker-alt"></i> ${app.venue}
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </div>

            <c:choose>
                
                <%-- CASE 1: Feedback Exists --%>
                <c:when test="${not empty feedback}">
                    <div class="feedback-container">
                        <div class="feedback-title"><i class="fas fa-comments" style="color: var(--accent-orange);"></i> Feedback & Review</div>
                        
                        <div class="student-msg">
                            <strong style="color: var(--primary);">Your Rating: ${feedback.rating}/5 <i class="fas fa-star" style="color: gold;"></i></strong><br><br>
                            "${feedback.message}"
                        </div>

                        <c:if test="${not empty feedback.adminReply}">
                            <div class="admin-reply-box">
                                <div class="reply-header">
                                    <i class="fas fa-check-circle"></i> Admin Response
                                </div>
                                "${feedback.adminReply}"
                            </div>
                        </c:if>

                        <c:if test="${empty feedback.adminReply}">
                            <p class="waiting-text"><i class="far fa-clock"></i> Feedback submitted. Waiting for admin response...</p>
                        </c:if>
                    </div>
                </c:when>

                <%-- CASE 2: No Feedback yet --%>
                <c:otherwise>
                    <div class="action-area">
                        <a href="${pageContext.request.contextPath}/counseling/history/feedback?id=${app.id}" class="btn-feedback">
                            <i class="far fa-comment-dots"></i> Write Feedback
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>

</body>
</html>