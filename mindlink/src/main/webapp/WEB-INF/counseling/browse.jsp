<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Find Your Counselor | MindLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #003049;
            --accent-pink: #F497AA;
            --accent-orange: #F77F00;
            --bg-color: #FFF3E0;
            --glass-white: rgba(255, 255, 255, 0.85);
            --glass-border: rgba(255, 255, 255, 0.6);
            --text-grey: #666;
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
        .blob-2 { bottom: 100px; right: -50px; width: 500px; height: 500px; background: rgba(247, 127, 0, 0.15); border-radius: 60% 40% 30% 70%; animation-direction: reverse; }

        @keyframes float {
            0% { transform: translate(0, 0) rotate(0deg); }
            50% { transform: translate(20px, 20px) rotate(5deg); }
            100% { transform: translate(0, 0) rotate(0deg); }
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        /* 🟢 BACK BUTTON */
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
        .header-section { text-align: center; margin-bottom: 40px; }
        h1 { font-size: 36px; font-weight: 800; margin: 0 0 10px 0; color: var(--primary); }
        .subtitle { color: var(--text-grey); font-size: 16px; margin: 0; }

        /* 🟢 SEARCH BAR */
        .search-container { text-align: center; margin-bottom: 50px; }
        .search-wrapper {
            position: relative; max-width: 500px; margin: 0 auto;
        }
        .search-box {
            padding: 18px 50px 18px 25px;
            width: 100%; box-sizing: border-box;
            border: 2px solid transparent;
            border-radius: 50px;
            font-size: 16px;
            background: white;
            box-shadow: 0 8px 25px rgba(0,0,0,0.05);
            outline: none; transition: 0.3s;
            color: var(--primary);
        }
        .search-box:focus { border-color: var(--accent-pink); box-shadow: 0 8px 30px rgba(244, 151, 170, 0.2); }
        
        .search-btn {
            position: absolute; right: 15px; top: 50%; transform: translateY(-50%);
            background: var(--accent-orange); color: white;
            border: none; width: 40px; height: 40px; border-radius: 50%;
            cursor: pointer; transition: 0.2s; display: flex; align-items: center; justify-content: center;
        }
        .search-btn:hover { background: var(--primary); }

        /* 🟢 COUNSELOR GRID */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
        }

        .card {
            background: var(--glass-white);
            backdrop-filter: blur(10px);
            padding: 30px 20px;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            border: 1px solid var(--glass-border);
            transition: all 0.3s ease;
            text-decoration: none; color: inherit;
            display: flex; flex-direction: column; align-items: center;
            text-align: center;
            position: relative; overflow: hidden;
        }
        
        .card:hover { 
            transform: translateY(-8px); 
            box-shadow: 0 15px 40px rgba(0,0,0,0.1); 
            border-color: var(--accent-pink);
        }

        /* Avatar */
        .avatar-wrapper {
            width: 90px; height: 90px;
            border-radius: 50%;
            padding: 4px;
            background: linear-gradient(135deg, #F497AA, #F77F00);
            margin-bottom: 15px;
        }
        
        .avatar {
            width: 100%; height: 100%;
            background: white;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 32px; font-weight: 800; color: var(--accent-orange);
            overflow: hidden;
        }
        .avatar img { width: 100%; height: 100%; object-fit: cover; }

        .info h3 { margin: 0 0 5px 0; font-size: 20px; font-weight: 700; color: var(--primary); }
        .location { color: #888; font-size: 13px; font-weight: 500; margin-bottom: 15px; display: block; }
        
        /* Tags */
        .tags { display: flex; gap: 8px; flex-wrap: wrap; justify-content: center; margin-bottom: 20px; }
        .tag { 
            background: #FFF0F3; color: #D81B60; 
            padding: 5px 12px; border-radius: 15px; 
            font-size: 12px; font-weight: 600;
        }
        
        /* Action Button (Visible on Hover) */
        .btn-view {
            background: var(--primary); color: white;
            padding: 10px 25px; border-radius: 50px;
            font-size: 14px; font-weight: 600;
            margin-top: auto; transition: 0.3s;
            opacity: 0.8;
        }
        .card:hover .btn-view { background: var(--accent-orange); opacity: 1; }

        /* Empty State */
        .empty-state { grid-column: 1/-1; text-align: center; color: #888; padding: 40px; background: rgba(255,255,255,0.5); border-radius: 20px; }

    </style>
</head>
<body>

    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

    <div class="container">
        
        <a href="${pageContext.request.contextPath}/counseling/home" class="btn-back" title="Back to Dashboard">
            <i class="fas fa-arrow-left"></i>
        </a>

        <div class="header-section">
            <h1>Find Your Counselor</h1>
            <p class="subtitle">Connect with experienced professionals dedicated to your well-being.</p>
        </div>

        <form action="${pageContext.request.contextPath}/counseling/browse" method="get" class="search-container">
            <div class="search-wrapper">
                <input type="text" name="search" class="search-box" placeholder="Search by name or specialty..." value="${param.search}">
                <button type="submit" class="search-btn"><i class="fas fa-search"></i></button>
            </div>
        </form>

        <div class="grid">
            <c:forEach items="${counselors}" var="c">
                
                <a href="${pageContext.request.contextPath}/counseling/counselor?id=${c.id}" class="card">
                    <div class="avatar-wrapper">
                        <div class="avatar">
                            <c:choose>
                                <c:when test="${not empty c.imageUrl}">
                                    <img src="${pageContext.request.contextPath}${c.imageUrl}" alt="${c.name}">
                                </c:when>
                                <c:otherwise>
                                    
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="info">
                        <h3>${c.name}</h3>
                        <span class="location"><i class="fas fa-map-marker-alt"></i> ${not empty c.location ? c.location : 'MindLink Center'}</span>
                        
                        <div class="tags">
                            <span class="tag">Anxiety</span>
                            <span class="tag">Stress</span>
                            <span class="tag">Academic</span>
                        </div>
                    </div>

                    <div class="btn-view">View Profile</div>
                </a>

            </c:forEach>
            
            <c:if test="${empty counselors}">
                <div class="empty-state">
                    <i class="fas fa-user-slash" style="font-size: 40px; margin-bottom: 10px;"></i>
                    <p>No counselors found matching your search.</p>
                </div>
            </c:if>
        </div>
    </div>

</body>
</html>