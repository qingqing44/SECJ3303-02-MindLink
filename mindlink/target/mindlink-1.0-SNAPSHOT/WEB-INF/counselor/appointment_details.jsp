<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Session Details | MindLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --bg-color: #FFF3E0;  /* Beige */
            --text-dark: #003049; /* Dark Blue */
            --card-bg: #FFFFFF;
            --btn-orange: #F77F00;
            --btn-teal: #48C9B0;
            --btn-green: #27AE60;
            --btn-blue: #2F80ED;
            --text-grey: #555;
            --border-light: #eee;
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-color); 
            color: var(--text-dark); 
            margin: 0; padding: 0;
            min-height: 100vh;
        }

        /* --- Navbar --- */
        .header {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        z-index: 1000;
        padding: 15px 50px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: white;
        box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        box-sizing: border-box;
    }

        .nav-left, .nav-right {
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
            color: var(--btn-orange); /* Used orange here to match counselor theme */
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

        /* --- Container --- */
        .container { max-width: 800px; margin: 40px auto; padding: 0 20px 80px; }

        /* Back Button */
        .btn-back {
            display: inline-flex; align-items: center; gap: 10px;
            text-decoration: none; color: #666; font-weight: 600; font-size: 16px;
            margin-bottom: 20px; transition: 0.2s;
        }
        .btn-back:hover { color: var(--text-dark); transform: translateX(-5px); }

        /* --- Main Card --- */
        .card {
            background: var(--card-bg); border-radius: 20px; padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        /* Header Section */
        .header-section { text-align: center; margin-bottom: 30px; }
        
        .student-avatar {
            width: 80px; height: 80px; 
            background: #E0F7FA; color: #006064;
            border-radius: 50%; font-size: 32px; 
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        .student-name { font-size: 28px; font-weight: 800; margin: 0 0 10px 0; color: var(--text-dark); }

        .status-badge {
            display: inline-block; padding: 6px 15px; border-radius: 50px; 
            font-size: 13px; font-weight: 700; text-transform: uppercase;
            background: #FFF4E6; color: #F77F00; letter-spacing: 0.5px;
        }
        .status-completed { background: #D1FAE5; color: #065F46; }
        .status-cancelled { background: #FFE4E6; color: #BE123C; }

        /* --- Detail Grid --- */
        .detail-grid { 
            display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px; 
        }
        .detail-item { 
            background: #FAFAFA; padding: 20px; border-radius: 16px; 
            border: 1px solid var(--border-light);
        }
        .label { display: block; color: #888; font-size: 13px; font-weight: 700; margin-bottom: 8px; text-transform: uppercase; }
        .value { font-weight: 600; color: var(--text-dark); font-size: 16px; display: flex; align-items: center; gap: 10px; }

        /* --- Feedback Section --- */
        .feedback-section {
            background: #FFF8E1; border-left: 5px solid #FFC107; 
            border-radius: 12px; padding: 20px; margin-bottom: 30px;
        }
        .star-rating { color: #FFC107; font-size: 16px; }

        /* --- Notes Section --- */
        .notes-section { 
            margin-top: 30px; border-top: 1px solid var(--border-light); padding-top: 30px; 
        }
        .section-title { font-size: 18px; font-weight: 700; margin-bottom: 15px; color: var(--text-dark); }
        
        .notes-area {
            width: 100%; height: 150px; padding: 15px; border-radius: 12px;
            border: 1px solid #ddd; font-family: 'Inter', sans-serif; font-size: 15px;
            margin-bottom: 25px; resize: vertical; box-sizing: border-box;
            background: #FAFAFA; outline: none; transition: border-color 0.2s;
        }
        .notes-area:focus { border-color: var(--text-dark); background: white; }

        /* --- Buttons --- */
        .btn-group { display: flex; gap: 15px; flex-wrap: wrap; }
        
        .btn {
            flex: 1; padding: 12px 20px; border: none; border-radius: 50px;
            font-weight: 600; cursor: pointer; font-size: 14px; transition: 0.2s;
            display: flex; align-items: center; justify-content: center; gap: 8px; 
            text-decoration: none; min-width: 140px;
        }
        
        .btn-save { background: var(--text-dark); color: white; }
        .btn-save:hover { background: #004d73; }
        
        .btn-email { background: var(--btn-blue); color: white; }
        .btn-email:hover { background: #1d4ed8; }

        .btn-complete { background: var(--btn-green); color: white; }
        .btn-complete:hover { background: #15803d; }

        /* Success Message */
        .alert-success {
            background: #D1FAE5; color: #065F46; padding: 15px; 
            border-radius: 12px; margin-bottom: 20px; text-align: center; font-weight: 600;
        }

    </style>
</head>
<body>

    <div class="header">
        <div class="nav-left">
            <a href="${pageContext.request.contextPath}/counselor/dashboard">Home</a>
            <a href="${pageContext.request.contextPath}/counselor/appointments">Appointment</a>
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
        <a href="${pageContext.request.contextPath}/counselor/appointments" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Schedule
        </a>

        <c:if test="${not empty message}">
            <div class="alert-success">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
        </c:if>

        <div class="card">
            
            <div class="header-section">
                <div class="student-avatar"><i class="fas fa-user"></i></div>
                <h2 class="student-name">
                    ${appointment.studentName != null ? appointment.studentName : 'Unknown Student'}
                </h2>
                
                <span class="status-badge ${appointment.status == 'Completed' ? 'status-completed' : (appointment.status == 'Cancelled' ? 'status-cancelled' : '')}">
                    ${appointment.status}
                </span>
            </div>

            <c:if test="${not empty feedback}">
                <div class="feedback-section">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:10px;">
                        <span style="font-weight:700; color:#B45309;">
                            <i class="fas fa-comment-dots"></i> Student Feedback
                        </span>
                        <div class="star-rating">
                            <c:forEach begin="1" end="${feedback.rating}"><i class="fas fa-star"></i></c:forEach>
                            <c:forEach begin="${feedback.rating + 1}" end="5"><i class="far fa-star"></i></c:forEach>
                        </div>
                    </div>
                    <div style="font-weight:700; font-size:15px; margin-bottom:5px; color:#333;">${feedback.subject}</div>
                    <div style="font-style: italic; color: #555; line-height: 1.5;">"${feedback.message}"</div>
                </div>
            </c:if>

            <div class="detail-grid">
                <div class="detail-item">
                    <span class="label">Date & Time</span>
                    <span class="value">
                        <i class="far fa-calendar-alt" style="color:#F77F00;"></i> 
                        ${appointment.date} @ ${appointment.time}
                    </span>
                </div>
                <div class="detail-item">
                    <span class="label">Session Type</span>
                    <span class="value">
                        <i class="fas fa-video" style="color:#F77F00;"></i> 
                        ${appointment.type}
                    </span>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/counselor/appointment/update" method="post" class="notes-section">
                <input type="hidden" name="id" value="${appointment.id}">
                
                <div class="section-title">Session Notes</div>
                <textarea name="notes" class="notes-area" placeholder="Write private notes about this session here...">${appointment.notes}</textarea>

                <div class="btn-group">
                    <button type="submit" name="action" value="save" class="btn btn-save">
                        <i class="far fa-save"></i> Save Notes
                    </button>

                    <a href="mailto:${appointment.studentId}@graduate.utm.my?subject=Counseling Session Follow-up" class="btn btn-email">
                        <i class="fas fa-envelope"></i> Email Student
                    </a>

                    <c:if test="${appointment.status != 'Completed' && appointment.status != 'Cancelled'}">
                        <button type="submit" name="action" value="complete" class="btn btn-complete"
                                onclick="return confirm('Mark this session as Completed?');">
                            <i class="fas fa-check-circle"></i> Mark Complete
                        </button>
                    </c:if>
                </div>
            </form>
            
        </div>
    </div>

</body>
</html>