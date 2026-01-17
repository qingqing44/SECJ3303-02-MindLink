<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%-- CALCULATE UPCOMING COUNT --%>
<c:set var="bookedCount" value="0" />
<c:forEach items="${appointments}" var="app">
    <c:if test="${app.upcoming}">
        <c:set var="bookedCount" value="${bookedCount + 1}" />
    </c:if>
</c:forEach>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Counselor Home | MindLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
    :root {
        --bg-color: #FFF3E0; 
        --text-dark: #003049;
        --card-bg: #FFFFFF;
        --btn-orange: #F77F00;
        --btn-hover: #D62828;
        --text-grey: #555;
    }

    body {
        font-family: 'Inter', sans-serif;
        background-color: var(--bg-color);
        background-image: 
            radial-gradient(circle at 10% 20%, rgba(247, 127, 0, 0.05) 0%, transparent 50%),
            radial-gradient(circle at 90% 80%, rgba(72, 201, 176, 0.1) 0%, transparent 50%);
        margin: 0; 
        padding: 0; /* REMOVED PADDING */
        color: var(--text-dark);
        overflow-x: hidden;
        min-height: 100vh;
        position: relative;
    }

    /* 🟢 ANIMATED BLOBS */
    .blob {
        position: absolute;
        filter: blur(50px);
        z-index: -1;
        opacity: 0.6;
        animation: float 10s ease-in-out infinite;
    }

    .blob-1 {
        top: -100px; left: -100px;
        width: 500px; height: 500px;
        background: rgba(247, 127, 0, 0.15);
        border-radius: 40% 60% 70% 30%;
    }

    .blob-2 {
        bottom: -150px; right: -100px;
        width: 600px; height: 600px;
        background: rgba(72, 201, 176, 0.15);
        border-radius: 60% 40% 30% 70%;
        animation-direction: reverse;
    }

    @keyframes float {
        0% { transform: translate(0, 0) rotate(0deg); }
        50% { transform: translate(30px, 20px) rotate(5deg); }
        100% { transform: translate(0, 0) rotate(0deg); }
    }

    /* 🟢 DECORATIVE SIDE IMAGES */
    .deco-img {
        position: fixed;
        bottom: 0;
        z-index: -1; /* Behind content, above background */
        width: 300px; /* Adjust this size as needed */
        opacity: 0.9;
        pointer-events: none; /* Allows you to click through them if they overlap anything */
        transition: all 0.3s ease;
    }

    .deco-left {
        left: 0;
        /* Optional: Entrance animation */
        animation: slideInLeft 1s ease-out;
    }

    .deco-right {
        right: 0;
        /* Optional: Entrance animation */
        animation: slideInRight 1s ease-out;
    }

    /* Hide images on smaller screens so they don't cover text */
    @media (max-width: 1300px) {
        .deco-img {
            opacity: 0.3; /* Fade them out or hide them completely with display: none; */
            width: 150px;
        }
    }

    @keyframes slideInLeft {
        from { transform: translateX(-100px); opacity: 0; }
        to { transform: translateX(0); opacity: 0.9; }
    }

    @keyframes slideInRight {
        from { transform: translateX(100px); opacity: 0; }
        to { transform: translateX(0); opacity: 0.9; }
    }

    /* --- NEW HEADER STYLE --- */
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

    /* --- Main Layout --- */
    .container {
        max-width: 900px; 
        margin: 0 auto; 
        padding: 120px 20px 60px; /* ADDED TOP PADDING 120px */
        text-align: center;
    }

    h1 { 
        font-size: 48px; font-weight: 800; color: var(--text-dark); 
        margin: 0 0 10px 0; 
        text-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }
    
    .subtitle { 
        font-size: 22px; font-weight: 600; color: #555; 
        margin-bottom: 50px; 
    }

    /* --- INFO CARD --- */
    .info-card {
        background: rgba(255, 255, 255, 0.8);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        padding: 40px;
        box-shadow: 0 8px 30px rgba(0,0,0,0.06);
        margin-bottom: 50px;
        text-align: center;
        border: 1px solid rgba(255,255,255,0.6);
    }

    .info-header {
        display: flex; align-items: center; justify-content: center; gap: 10px;
        font-size: 20px; font-weight: 700; color: var(--text-dark);
        margin-bottom: 15px;
    }
    
    .info-text { font-size: 16px; color: var(--text-grey); }

    /* --- SESSION LIST --- */
    .section-title {
        font-size: 28px; font-weight: 800; color: var(--text-dark);
        margin-bottom: 25px;
    }

    .session-card {
        background: white;
        border-radius: 16px;
        padding: 25px 35px;
        margin-bottom: 20px;
        display: flex; justify-content: space-between; align-items: center;
        box-shadow: 0 4px 15px rgba(0,0,0,0.03);
        transition: transform 0.2s, box-shadow 0.2s;
        position: relative; overflow: hidden;
    }
    
    .session-card::before {
        content: ''; position: absolute; left: 0; top: 0; bottom: 0; width: 6px;
        background: var(--btn-orange);
    }

    .session-card:hover { 
        transform: translateY(-5px); 
        box-shadow: 0 10px 25px rgba(0,0,0,0.1); 
    }

    .session-info { text-align: left; }
    
    .session-name { 
        font-size: 18px; font-weight: 700; color: var(--text-dark); 
        margin-bottom: 5px; 
    }
    
    .session-date { font-size: 14px; color: var(--text-grey); font-weight: 500; }

    .btn-view {
        background-color: var(--btn-orange);
        color: white;
        padding: 10px 30px;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        border: none;
        box-shadow: 0 4px 10px rgba(247, 127, 0, 0.3);
        transition: all 0.2s;
    }
    .btn-view:hover { 
        background-color: #e06c00; 
        box-shadow: 0 6px 15px rgba(247, 127, 0, 0.4); 
        transform: translateY(-1px);
    }

    .empty-state {
        padding: 30px; background: rgba(255,255,255,0.6); 
        border-radius: 16px; color: #777; font-style: italic;
    }
</style>
</head>
<body>

    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

    <img src="${pageContext.request.contextPath}/images/assessment-left.png" class="deco-img deco-left" alt="Decoration Left">
    <img src="${pageContext.request.contextPath}/images/assessment-right.png" class="deco-img deco-right" alt="Decoration Right">

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
        <h1>Welcome back, ${not empty sessionScope.loggedInCounselor.name ? sessionScope.loggedInCounselor.name : 'Counselor'}!</h1>
        <div class="subtitle">Ready to support your students today?</div>

        <div class="info-card">
            <div class="info-header">
                <i class="fas fa-calendar-check" style="color: #F77F00;"></i> Session Overview
            </div>
            <div class="info-text">
                "You have <strong>${bookedCount}</strong> upcoming sessions scheduled. Prepare your notes and grab a coffee!"
            </div>
        </div>

        <div class="section-title">Upcoming Sessions</div>

        <c:forEach items="${appointments}" var="app">
            <c:if test="${app.upcoming}">
                <div class="session-card">
                    <div class="session-info">
                        <div class="session-name">Session with ${app.studentName != null ? app.studentName : 'Student'}</div>
                        <div class="session-date">
                            <i class="far fa-calendar-alt" style="margin-right: 5px;"></i> ${app.date} 
                            &nbsp;|&nbsp; 
                            <i class="far fa-clock" style="margin-right: 5px;"></i> ${app.time}
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/counselor/appointment?id=${app.id}" class="btn-view">
                        View Details
                    </a>
                </div>
            </c:if>
        </c:forEach>

        <c:if test="${bookedCount == 0}">
            <div class="empty-state">
                <i class="fas fa-mug-hot"></i> No upcoming sessions found. Enjoy your free time!
            </div>
        </c:if>

    </div>

</body>
</html>