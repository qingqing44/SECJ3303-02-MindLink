<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Assessments | MindLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* 🟢 MATCHED: Root Variables & Body Style */
        :root {
            --bg-color: #FFF3E0;
            --text-dark: #003049;
            --card-bg: #FFFFFF;
            --btn-orange: #F77F00;
            --btn-hover: #D62828;
            --text-grey: #555;
            --risk-red: #D62828;
            --safe-green: #27AE60;
            --warn-orange: #F77F00; /* Added for Moderate */
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(247, 127, 0, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 90% 80%, rgba(72, 201, 176, 0.1) 0%, transparent 50%);
            margin: 0; padding: 0;
            color: var(--text-dark);
            overflow-x: hidden;
            min-height: 100vh;
            position: relative;
        }

        /* 🟢 MATCHED: Animated Blobs */
        .blob { position: absolute; filter: blur(50px); z-index: -1; opacity: 0.6; animation: float 10s ease-in-out infinite; }
        .blob-1 { top: -100px; left: -100px; width: 500px; height: 500px; background: rgba(247, 127, 0, 0.15); border-radius: 40% 60% 70% 30%; }
        .blob-2 { bottom: -150px; right: -100px; width: 600px; height: 600px; background: rgba(72, 201, 176, 0.15); border-radius: 60% 40% 30% 70%; animation-direction: reverse; }
        @keyframes float { 0% { transform: translate(0, 0) rotate(0deg); } 50% { transform: translate(30px, 20px) rotate(5deg); } 100% { transform: translate(0, 0) rotate(0deg); } }

        /* 🟢 MATCHED: Header Style */
        .header { position: fixed; top: 0; left: 0; width: 100%; z-index: 1000; padding: 15px 50px; display: flex; justify-content: space-between; align-items: center; background: white; box-shadow: 0 4px 15px rgba(0,0,0,0.05); box-sizing: border-box; }
        .nav-left, .nav-right { display: flex; align-items: center; justify-content: space-evenly; flex: 1; gap: 0; }
        .nav-left a, .nav-right a { text-decoration: none; color: #00313e; font-size: 16px; font-weight: 500; transition: color 0.3s; }
        .nav-left a:hover, .nav-right a:hover, .nav-left a.active-link { color: var(--btn-orange); }
        .logo { display: flex; align-items: center; gap: 10px; font-weight: 700; color: #00313e; font-size: 32px; text-decoration: none; }
        .logo-icon { width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; }
        .logo-icon img { width: 100%; height: 100%; object-fit: contain; }

        /* --- Main Container --- */
        .container { max-width: 1000px; margin: 0 auto; padding: 120px 20px 60px; }
        h1 { font-size: 32px; font-weight: 800; margin-bottom: 30px; text-align: center; color: var(--text-dark); }

        /* --- Filter Card --- */
        .filter-card {
            background: rgba(255, 255, 255, 0.8); backdrop-filter: blur(10px);
            padding: 20px; border-radius: 20px; border: 1px solid rgba(255,255,255,0.6);
            box-shadow: 0 8px 30px rgba(0,0,0,0.06); margin-bottom: 30px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .filter-group { display: flex; gap: 10px; }
        .filter-btn {
            padding: 8px 20px; border: 1px solid #ddd; border-radius: 50px;
            text-decoration: none; color: #666; font-weight: 600; font-size: 14px; transition: 0.2s;
            background: white;
        }
        .filter-btn:hover { background: #f9f9f9; color: var(--text-dark); border-color: var(--text-dark); }
        .filter-btn.active { background: var(--text-dark); color: white; border-color: var(--text-dark); }
        .risk-toggle { color: var(--risk-red); border-color: #FFCDD2; background: #FFEBEE; }
        .risk-toggle.active { background: var(--risk-red); color: white; border-color: var(--risk-red); }

        /* --- Results Table Card --- */
        .table-card {
            background: var(--card-bg); border-radius: 20px; padding: 30px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.05); overflow: hidden;
        }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 15px; color: #888; font-size: 12px; text-transform: uppercase; border-bottom: 2px solid #f0f0f0; }
        td { padding: 20px 15px; border-bottom: 1px solid #f0f0f0; vertical-align: middle; }
        tr:last-child td { border-bottom: none; }
        .student-name { font-weight: 700; color: var(--text-dark); display: block; }
        .student-id { font-size: 12px; color: #888; }
        
        /* Badges */
        .badge { padding: 4px 10px; border-radius: 8px; font-size: 11px; font-weight: 700; text-transform: uppercase; }
        .badge-happiness { background: #E3F2FD; color: #1565C0; }
        .badge-stress { background: #F3E5F5; color: #7B1FA2; }
        
        .score-box { font-weight: 800; font-size: 16px; }
        
        /* Dynamic Dots */
        .sev-dot { height: 10px; width: 10px; border-radius: 50%; display: inline-block; margin-right: 5px; }
        .empty-state { text-align: center; padding: 40px; color: #999; font-style: italic; }
    </style>
</head>
<body>

    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

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
        <h1>Student Assessment Results</h1>

        <div class="filter-card" style="flex-direction: column; align-items: stretch; gap: 20px;">
            
            <form action="${pageContext.request.contextPath}/counselor/assessments" method="get" style="display: flex; gap: 10px;">
                <input type="text" name="search" value="${currentSearch}" placeholder="Search student by name..." 
                       style="flex: 1; padding: 12px 20px; border-radius: 50px; border: 1px solid #ddd; outline: none; font-family: 'Inter';">
                
                <button type="submit" style="background: var(--text-dark); color: white; border: none; padding: 0 25px; border-radius: 50px; font-weight: 600; cursor: pointer;">
                    <i class="fas fa-search"></i> Search
                </button>
            </form>

            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div class="filter-group">
                    <a href="?type=all&search=${currentSearch}&risk=${currentRisk}" 
                       class="filter-btn ${empty currentType || currentType == 'all' ? 'active' : ''}">All Tests</a>
                    <a href="?type=Happiness Check&search=${currentSearch}&risk=${currentRisk}" 
                       class="filter-btn ${currentType == 'Happiness Check' ? 'active' : ''}">Happiness Check</a>
                    <a href="?type=Stress Test&search=${currentSearch}&risk=${currentRisk}" 
                       class="filter-btn ${currentType == 'Stress Test' ? 'active' : ''}">Stress Test</a>
                </div>
                
                <div>
                    <a href="?risk=${currentRisk == 'high' ? 'all' : 'high'}&search=${currentSearch}&type=${currentType}" 
                       class="filter-btn risk-toggle ${currentRisk == 'high' ? 'active' : ''}">
                       <i class="fas fa-exclamation-circle"></i> Prioritize High Risk
                    </a>
                </div>
            </div>
        </div>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>Student</th>
                        <th>Test Taken</th>
                        <th>Date</th>
                        <th>Score</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${assessments}" var="res">
                        <tr>
                            <td>
                                <span class="student-name">${res.studentName}</span>
                                <span class="student-id">#${res.studentId}</span>
                            </td>
                            <td>
                                <span class="badge ${res.assessmentTitle == 'Happiness Check' ? 'badge-happiness' : 'badge-stress'}">
                                    ${res.assessmentTitle}
                                </span>
                            </td>
                            <td style="color:#666; font-size:14px;">${res.completedAt}</td>
                            <td><span class="score-box">${res.score}</span></td>
                            
                            <%-- 🟢 NEW SCORE LOGIC --%>
                            <td>
                                <c:choose>
                                    <%-- HIGH RISK (> 20) --%>
                                    <c:when test="${res.score > 20}">
                                        <div style="color: var(--risk-red); font-weight: 700; font-size: 14px;">
                                            <span class="sev-dot" style="background: var(--risk-red); box-shadow: 0 0 0 3px rgba(214, 40, 40, 0.2);"></span>
                                            High Risk
                                        </div>
                                    </c:when>
                                    
                                    <%-- MODERATE (> 10) --%>
                                    <c:when test="${res.score > 10}">
                                        <div style="color: var(--warn-orange); font-weight: 600; font-size: 14px;">
                                            <span class="sev-dot" style="background: var(--warn-orange);"></span>
                                            Moderate
                                        </div>
                                    </c:when>

                                    <%-- NORMAL (0-10) --%>
                                    <c:otherwise>
                                        <div style="color: var(--safe-green); font-weight: 600; font-size: 14px;">
                                            <span class="sev-dot" style="background: var(--safe-green);"></span>
                                            Normal
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <c:if test="${empty assessments}">
                <div class="empty-state">
                    <i class="fas fa-clipboard-list" style="font-size: 32px; margin-bottom: 10px; display:block;"></i>
                    No assessment records found matching your filters.
                </div>
            </c:if>
        </div>
    </div>

</body>
</html>