<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${c.name} - Profile | MindLink</title>
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

        /* MAIN CARD */
        .profile-card {
            background: var(--glass-white);
            backdrop-filter: blur(10px);
            border-radius: 30px; 
            padding: 50px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.05); 
            border: 1px solid rgba(255,255,255,0.6);
            position: relative;
            animation: slideUp 0.5s ease-out;
        }

        @keyframes slideUp { from { transform: translateY(20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }

        /* PROFILE HEADER GRID */
        .profile-header { display: grid; grid-template-columns: 300px 1fr; gap: 50px; margin-bottom: 40px; }

        .img-wrapper {
            background: white; padding: 10px; border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            transform: rotate(-2deg); transition: transform 0.3s;
        }
        .img-wrapper:hover { transform: rotate(0deg); }

        .profile-img {
            width: 100%; height: 350px; object-fit: cover; border-radius: 12px;
        }

        .info-list { display: flex; flex-direction: column; gap: 20px; justify-content: center; }
        
        .counselor-name { font-size: 38px; font-weight: 800; margin: 0 0 5px 0; color: var(--primary); letter-spacing: -1px; }
        .counselor-title { font-size: 18px; color: var(--accent-orange); font-weight: 600; margin-bottom: 15px; }

        .info-row { display: grid; grid-template-columns: 40px 1fr; align-items: center; }
        .icon-box { 
            width: 32px; height: 32px; background: #FFF0F3; color: var(--accent-pink); 
            border-radius: 8px; display: flex; align-items: center; justify-content: center; 
            font-size: 14px;
        }
        
        .value { font-weight: 500; color: #444; font-size: 16px; margin-left: 10px; }
        .value strong { display: block; font-size: 12px; color: #999; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 2px; }

        /* 🟢 BUTTONS */
        .btn-book-now {
            margin-top: 30px;
            background: linear-gradient(135deg, #F497AA, #F77F00);
            color: white; text-decoration: none;
            padding: 16px 35px; border-radius: 50px;
            font-weight: 700; font-size: 16px;
            display: inline-flex; align-items: center; gap: 10px;
            width: fit-content;
            box-shadow: 0 8px 20px rgba(244, 151, 170, 0.4);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-book-now:hover { transform: translateY(-3px); box-shadow: 0 12px 25px rgba(247, 127, 0, 0.4); }

        /* SECTIONS */
        .bio-section { 
            border-top: 1px solid rgba(0,0,0,0.05); padding-top: 30px; margin-top: 20px;
            font-size: 16px; line-height: 1.8; color: var(--text-grey); 
        }
        .bio-section h3 { margin-top: 0; color: var(--primary); font-size: 22px; margin-bottom: 15px; }

        .quote-box {
            margin-top: 40px; 
            background: linear-gradient(135deg, #FFF8E7, #FFF); 
            padding: 30px 40px; border-radius: 20px;
            text-align: center; font-style: italic; color: var(--primary); font-weight: 600; font-size: 20px;
            border: 1px solid rgba(247, 127, 0, 0.1);
            position: relative;
        }
        .quote-icon { font-size: 40px; color: rgba(247, 127, 0, 0.2); position: absolute; top: -20px; left: 20px; }

        @media (max-width: 850px) {
            .profile-header { grid-template-columns: 1fr; text-align: center; gap: 30px; }
            .img-wrapper { max-width: 300px; margin: 0 auto; transform: rotate(0); }
            .info-list { align-items: center; }
            .info-row { grid-template-columns: auto; text-align: center; justify-items: center; gap: 5px; }
            .icon-box { margin-bottom: 5px; }
            .value { margin-left: 0; }
        }
    </style>
</head>
<body>
    
    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

    <div class="container">
        
        <a href="${pageContext.request.contextPath}/counseling/browse" class="btn-back" title="Back to Counselors">
            <i class="fas fa-arrow-left"></i>
        </a>

        <div class="profile-card">

            <div class="profile-header">
                <div class="img-wrapper">
                    <img src="${not empty c.imageUrl ? pageContext.request.contextPath.concat(c.imageUrl) : 'https://via.placeholder.com/400x500?text=No+Image'}" 
                         alt="${c.name}" class="profile-img">
                </div>

                <div class="info-list">
                    <div>
                        <h1 class="counselor-name">${c.name}</h1>
                        <div class="counselor-title">Licensed Professional Counselor</div>
                    </div>
                    
                    <div class="info-row">
                        <div class="icon-box"><i class="fas fa-graduation-cap"></i></div>
                        <div class="value">
                            <strong>Education</strong>
                            ${c.education}
                        </div>
                    </div>

                    <div class="info-row">
                        <div class="icon-box"><i class="fas fa-university"></i></div>
                        <div class="value">
                            <strong>University</strong>
                            ${c.university}
                        </div>
                    </div>
                    
                    <div class="info-row">
                        <div class="icon-box"><i class="fas fa-language"></i></div>
                        <div class="value">
                            <strong>Languages</strong>
                            ${c.languages}
                        </div>
                    </div>
                    
                    <div class="info-row">
                        <div class="icon-box"><i class="fas fa-map-marker-alt"></i></div>
                        <div class="value">
                            <strong>Location</strong>
                            ${c.location}
                        </div>
                    </div>
                    
                    <div class="info-row">
                        <div class="icon-box"><i class="fas fa-envelope"></i></div>
                        <div class="value">
                            <strong>Email</strong>
                            ${c.email}
                        </div>
                    </div>

                    <a href="${pageContext.request.contextPath}/counseling/booking?preselected=${c.name}" class="btn-book-now">
                        Book Appointment <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>

            <div class="bio-section">
                <h3>About Me</h3>
                <p>${c.bio}</p>
            </div>

            <div class="quote-box">
                <i class="fas fa-quote-left quote-icon"></i>
                “${c.quote}”
            </div>
        </div>
    </div>

</body>
</html>