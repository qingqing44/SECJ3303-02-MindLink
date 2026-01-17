<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Share Your Feedback | MindLink</title>
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
            --input-bg: #F9FAFB;
            --star-gold: #FFC107;
            --star-grey: #E0E0E0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            /* 🟢 Pink & Orange Gradient Background */
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

        .container { max-width: 700px; margin: 0 auto; position: relative; z-index: 1; }

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

        h1 { font-size: 32px; font-weight: 800; margin-bottom: 10px; text-align: center; color: var(--primary); }
        .subtitle { color: #666; font-size: 16px; margin-bottom: 40px; text-align: center; }

        /* 🟢 Glass Feedback Card */
        .feedback-card {
            background: var(--glass-white);
            backdrop-filter: blur(10px);
            padding: 40px 50px;
            border-radius: 24px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.05);
            border: 1px solid rgba(255,255,255,0.6);
            border-top: 6px solid var(--accent-orange);
        }

        .form-group { margin-bottom: 25px; }
        label { display: block; font-size: 14px; font-weight: 700; margin-bottom: 10px; color: var(--primary); letter-spacing: 0.3px; }
        
        .form-control { 
            width: 100%; padding: 15px; background-color: var(--input-bg); 
            border: 2px solid transparent; border-radius: 12px; font-size: 15px; 
            outline: none; box-sizing: border-box; transition: 0.3s;
            font-family: inherit; color: #333;
        }
        .form-control:focus { 
            background: white; 
            border-color: var(--accent-pink); 
            box-shadow: 0 0 0 4px rgba(244, 151, 170, 0.1); 
        }
        textarea.form-control { height: 120px; resize: vertical; }

        /* 🟢 STAR RATING SYSTEM */
        .rating-wrapper {
            background: #FAFAFA; border-radius: 12px; padding: 15px;
            display: flex; justify-content: center; border: 1px dashed #ddd;
        }
        .star-rating { display: flex; gap: 10px; flex-direction: row-reverse; }
        .star-rating input { display: none; }
        .star-rating label { 
            font-size: 32px; color: var(--star-grey); cursor: pointer; transition: 0.2s; margin: 0;
        }
        /* Hover and Checked Effects */
        .star-rating input:checked ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: var(--star-gold);
            transform: scale(1.1);
        }

        /* 🟢 Gradient Submit Button */
        .btn-submit { 
            background: linear-gradient(135deg, #F497AA, #F77F00);
            color: white; width: 100%; padding: 16px; border: none; 
            border-radius: 50px; font-size: 16px; font-weight: 700; 
            cursor: pointer; margin-top: 20px; transition: 0.3s; 
            box-shadow: 0 8px 20px rgba(244, 151, 170, 0.4);
        }
        .btn-submit:hover { transform: translateY(-3px); box-shadow: 0 12px 25px rgba(247, 127, 0, 0.4); }

        /* 🟢 SUCCESS MODAL */
        .modal-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 48, 73, 0.6); display: flex; justify-content: center; align-items: center;
            z-index: 2000; backdrop-filter: blur(5px);
        }
        .success-box {
            background: white; padding: 40px 50px; border-radius: 24px; text-align: center;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2); animation: popIn 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            max-width: 350px; width: 90%;
        }
        @keyframes popIn { 0% { transform: scale(0.5); opacity: 0; } 100% { transform: scale(1); opacity: 1; } }
        
        .check-icon {
            width: 70px; height: 70px; background: linear-gradient(135deg, #66BB6A, #43A047); 
            border-radius: 50%; display: inline-flex; justify-content: center; align-items: center; 
            margin-bottom: 20px; color: white; font-size: 30px; box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
        }
        .success-title { font-size: 24px; font-weight: 800; color: var(--primary); margin-bottom: 10px; }

        @media (max-width: 600px) {
            .feedback-card { padding: 30px 20px; }
        }
    </style>
</head>
<body>

    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

    <div class="container">
        
        <a href="${pageContext.request.contextPath}/counseling/history/view?id=${bookingId}" class="btn-back" title="Back">
            <i class="fas fa-arrow-left"></i>
        </a>

        <h1>Share Your Feedback</h1>
        <p class="subtitle">How was your experience with session <strong>#${bookingId}</strong>?</p>

        <div class="feedback-card">
            <form action="${pageContext.request.contextPath}/counseling/history/feedback/submit" method="post">
                <input type="hidden" name="bookingId" value="${bookingId}">
                
                <div class="form-group">
                    <label>What is this regarding?</label>
                    <select name="category" class="form-control">
                        <option>Counseling Session Quality</option>
                        <option>Platform / Technical Issue</option>
                        <option>Counselor Behavior</option>
                        <option>Other Suggestion</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Subject</label>
                    <input type="text" name="subject" class="form-control" placeholder="E.g., Helpful session, Audio issues..." required>
                </div>

                <div class="form-group">
                    <label>Overall Rating</label>
                    <div class="rating-wrapper">
                        <div class="star-rating">
                            <input type="radio" name="rating" id="star5" value="5" required><label for="star5" title="Excellent"><i class="fas fa-star"></i></label>
                            <input type="radio" name="rating" id="star4" value="4"><label for="star4" title="Good"><i class="fas fa-star"></i></label>
                            <input type="radio" name="rating" id="star3" value="3"><label for="star3" title="Average"><i class="fas fa-star"></i></label>
                            <input type="radio" name="rating" id="star2" value="2"><label for="star2" title="Poor"><i class="fas fa-star"></i></label>
                            <input type="radio" name="rating" id="star1" value="1"><label for="star1" title="Very Poor"><i class="fas fa-star"></i></label>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label>Your Message</label>
                    <textarea name="message" class="form-control" placeholder="Share details about your experience..." required></textarea>
                </div>

                <button type="submit" class="btn-submit">Submit Feedback</button>
            </form>
        </div>
    </div>

    <c:if test="${success}">
        <div class="modal-overlay" id="successModal">
            <div class="success-box">
                <div class="check-icon"><i class="fas fa-check"></i></div>
                <div class="success-title">Thank you!</div>
                <p style="color: #666; font-size: 15px;">Your feedback has been saved successfully.</p>
            </div>
        </div>

        <script>
            // Redirect back to History details after 2 seconds
            setTimeout(function() {
                window.location.href = "${pageContext.request.contextPath}/counseling/history/view?id=${bookingId}";
            }, 2000);
        </script>
    </c:if>

</body>
</html>