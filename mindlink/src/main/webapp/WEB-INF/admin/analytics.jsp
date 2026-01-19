<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Analytics Dashboard | MindLink Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        :root {
            --bg-body: #FFF3E0;       /* Admin Beige */
            --bg-card: #FFFFFF;
            --primary: #003049;       /* Navy Blue */
            --secondary: #666666;     
            --accent-orange: #F77F00;
            --accent-pink: #F497AA;
            --shadow: 0 4px 20px rgba(0, 48, 73, 0.08);
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background: var(--bg-body); 
            margin: 0; padding: 0; 
            color: var(--primary);
            overflow-x: hidden;
        }

        /* --- HEADER (UNCHANGED) --- */
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

        /* --- CONTAINER --- */
        .container { 
            max-width: 1100px; margin: 50px auto 0 auto; 
            padding: 10 40px; /* Top padding clears fixed header */
            animation: fadeIn 0.5s ease-out;
        }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        /* --- 3. BACK BUTTON (ICON ONLY) --- */
        .btn-back {
            display: inline-flex; align-items: center; justify-content: center;
            width: 45px; height: 45px; border-radius: 50%;
            background: white; color: var(--primary); font-size: 18px;
            text-decoration: none; box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px; transition: 0.2s;
        }
        .btn-back:hover { background: var(--accent-orange); color: white; transform: translateX(-5px); }

        /* --- TITLE --- */
        .page-header { margin-bottom: 30px; }
        .page-header h2 { font-size: 36px; font-weight: 800; margin: 0; letter-spacing: -1px; }
        .page-header p { margin: 5px 0 0; color: var(--secondary); font-size: 16px; }

        /* --- METRICS GRID --- */
        .metrics-grid {
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px;
        }

        .stat-card {
            background: var(--bg-card); border-radius: 20px; padding: 25px;
            display: flex; align-items: center; gap: 15px;
            box-shadow: var(--shadow); border: 1px solid rgba(255,255,255,0.5);
            transition: transform 0.2s;
        }
        .stat-card:hover { transform: translateY(-5px); }

        .icon-box {
            width: 50px; height: 50px; border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px; flex-shrink: 0;
        }
        
        .icon-users { background: #E3F2FD; color: #1565C0; }
        .icon-sessions { background: #FFF3E0; color: #EF6C00; }
        .icon-posts { background: #E0F2F1; color: #00695C; }

        .stat-info { display: flex; flex-direction: column; }
        .stat-label { font-size: 13px; color: var(--secondary); font-weight: 600; text-transform: uppercase; }
        .stat-value { font-size: 26px; font-weight: 800; color: var(--primary); }

        /* --- 5. OBVIOUS PENDING REVIEWS CARD --- */
        .action-card {
            /* Vibrant Gradient Background */
            background: linear-gradient(135deg, #FF6B6B 0%, #FF8E53 100%);
            color: white; text-decoration: none; cursor: pointer;
            position: relative; overflow: hidden;
            box-shadow: 0 10px 25px rgba(255, 107, 107, 0.4);
            border: 2px solid white;
        }
        .action-card .stat-label { color: rgba(255,255,255,0.9); }
        .action-card .stat-value { color: white; text-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .action-card .icon-box { background: rgba(255,255,255,0.2); color: white; }
        
        .click-hint {
            font-size: 12px; margin-top: 5px; font-weight: 600; 
            background: rgba(0,0,0,0.2); padding: 4px 10px; border-radius: 20px;
            display: inline-block;
        }
        
        .action-card:hover { transform: scale(1.05); box-shadow: 0 15px 35px rgba(255, 107, 107, 0.5); }

        /* --- CHARTS SECTION --- */
        .charts-wrapper { display: grid; grid-template-columns: 2fr 1fr; gap: 20px; }

        .chart-card {
            background: white; border-radius: 24px; padding: 30px;
            box-shadow: var(--shadow);
        }
        .chart-header { margin-bottom: 20px; }
        .chart-title { font-size: 18px; font-weight: 700; color: var(--primary); }

        /* 1. Fix for unreachable graph: Ensure container has defined relative height */
        .chart-container-fix {
            position: relative; 
            height: 250px; 
            width: 100%;
        }

        /* Responsive */
        @media (max-width: 1000px) {
            .metrics-grid { grid-template-columns: repeat(2, 1fr); }
            .charts-wrapper { grid-template-columns: 1fr; }
        }
        @media (max-width: 600px) {
            .metrics-grid { grid-template-columns: 1fr; }
            .header { padding: 15px 20px; }
            .nav-group { display: none; }
        }
    </style>
</head>
<body>

    <div class="header">
        <div class="nav-left">
            <a href="${pageContext.request.contextPath}/admin/home">Home</a>
            <a href="${pageContext.request.contextPath}/admin/modules/dashboard">Module</a>
        </div>

        <a href="${pageContext.request.contextPath}/admin/home" class="logo">
            <div class="logo-icon">
                <img src="${pageContext.request.contextPath}/images/mindlink.png" alt="MindLink">
            </div>
            <span>MindLink</span>
        </a>

        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/admin/user-management">User Management</a>
            <a href="${pageContext.request.contextPath}/admin/profile">Profile</a>
        </div>
    </div>

    <div class="container">
        
        <a href="${pageContext.request.contextPath}/admin/home" class="btn-back" title="Back">
            <i class="fas fa-arrow-left"></i>
        </a>

        <div class="page-header">
            <h2>Platform Analytics</h2>
            <p>Overview of system performance and engagement.</p>
        </div>

        <div class="metrics-grid">
            <div class="stat-card">
                <div class="icon-box icon-users"><i class="fas fa-user-graduate"></i></div>
                <div class="stat-info">
                    <span class="stat-label">Total Students</span>
                    <span class="stat-value">${stats.totalUsers}</span>
                </div>
            </div>

            <div class="stat-card">
                <div class="icon-box icon-sessions"><i class="fas fa-calendar-day"></i></div>
                <div class="stat-info">
                    <span class="stat-label">Total Sessions</span>
                    <span class="stat-value">${stats.totalAppointments}</span>
                </div>
            </div>

            <div class="stat-card">
                <div class="icon-box icon-posts"><i class="fas fa-comment-dots"></i></div>
                <div class="stat-info">
                    <span class="stat-label">Active Posts</span>
                    <span class="stat-value">${stats.totalPosts}</span>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/admin/feedback" class="stat-card action-card">
                <div class="icon-box"><i class="fas fa-bell"></i></div>
                <div class="stat-info">
                    <span class="stat-label">Action Required</span>
                    <span class="stat-value">${stats.pendingFeedback} Pending</span>
                    <span class="click-hint">Review Now <i class="fas fa-arrow-right"></i></span>
                </div>
            </a>
        </div>

        <div class="charts-wrapper">
            <div class="chart-card">
                <div class="chart-header">
                    <div class="chart-title">Appointment Activity (Last 7 Days)</div>
                </div>
                <div class="chart-container-fix">
                    <canvas id="activityChart"></canvas>
                </div>
            </div>

            <div class="chart-card">
                <div class="chart-header">
                    <div class="chart-title">Rating Distribution</div>
                </div>
                <div class="chart-container-fix" style="height: 220px; display: flex; justify-content: center;">
                    <canvas id="ratingChart"></canvas>
                </div>
            </div>
        </div>

    </div>

    <script>
        // Data Injection with Fallbacks to prevent graph breaking
        const rawLabels = '${stats.chartLabels}'; 
        const rawData = '${stats.dailyAppointments}';
        const rawRatings = '${stats.ratingCounts}';

        // Default data if server returns empty strings
        const chartLabels = (rawLabels && rawLabels.length > 2) ? JSON.parse(rawLabels) : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        const chartData = (rawData && rawData.length > 2) ? JSON.parse(rawData) : [0, 0, 0, 0, 0, 0, 0];
        const ratingData = (rawRatings && rawRatings.length > 2) ? JSON.parse(rawRatings) : [1, 1, 1, 1, 1]; // Dummy data to show chart exists if empty

        // 1. Activity Chart
        const ctxActivity = document.getElementById('activityChart').getContext('2d');
        // Simple Gradient
        let gradient = ctxActivity.createLinearGradient(0, 0, 0, 300);
        gradient.addColorStop(0, 'rgba(0, 48, 73, 0.3)'); 
        gradient.addColorStop(1, 'rgba(0, 48, 73, 0.0)');

        new Chart(ctxActivity, {
            type: 'line',
            data: {
                labels: chartLabels,
                datasets: [{
                    label: 'Appointments',
                    data: chartData,
                    borderColor: '#003049',
                    backgroundColor: gradient,
                    borderWidth: 2,
                    pointBackgroundColor: '#F77F00',
                    pointRadius: 4,
                    fill: true,
                    tension: 0.3
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false, // Important for fitting container
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, grid: { borderDash: [5, 5] } },
                    x: { grid: { display: false } }
                }
            }
        });

        // 2. Rating Chart
        const ctxRating = document.getElementById('ratingChart').getContext('2d');
        new Chart(ctxRating, {
            type: 'doughnut',
            data: {
                labels: ['1 Star', '2 Stars', '3 Stars', '4 Stars', '5 Stars'],
                datasets: [{
                    data: ratingData,
                    backgroundColor: ['#FF6B6B', '#FF9F43', '#FFCD56', '#48C9B0', '#003049'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: { legend: { position: 'bottom', labels: { boxWidth: 10, font: { size: 11 } } } }
            }
        });
    </script>

</body>
</html>