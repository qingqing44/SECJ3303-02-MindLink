<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | MindLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root {
            --bg-color: #FFF3E0;
            --text-dark: #003049;
            --btn-orange: #F77F00;
            --btn-hover: #D62828;
            --input-border: #E0E0E0;
            --input-focus: #F77F00;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(247, 127, 0, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 90% 80%, rgba(72, 201, 176, 0.1) 0%, transparent 50%);
            margin: 0; min-height: 100vh;
            color: var(--text-dark);
            position: relative; overflow-x: hidden;
        }

        /* --- 🟢 POP OUT MODAL STYLES --- */
        .modal-overlay {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6); /* Dark background */
            backdrop-filter: blur(4px); /* Blur effect behind */
            z-index: 2000; /* Highest priority */
            display: flex; justify-content: center; align-items: center;
            animation: fadeIn 0.3s ease-out;
        }

        .success-card {
            background: white;
            padding: 40px;
            border-radius: 24px;
            text-align: center;
            width: 90%; max-width: 400px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            animation: popIn 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); /* Bouncy pop effect */
        }

        .icon-circle {
            width: 80px; height: 80px;
            background: #D1FAE5; color: #10B981;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 40px; margin: 0 auto 20px;
        }

        .modal-title { font-size: 24px; font-weight: 800; color: #003049; margin-bottom: 10px; }
        .modal-text { color: #666; font-size: 15px; margin-bottom: 25px; line-height: 1.5; }

        .btn-close-modal {
            background: var(--text-dark); color: white; border: none;
            padding: 12px 30px; border-radius: 50px; font-weight: 600; cursor: pointer;
            transition: 0.2s; width: 100%; font-size: 16px;
        }
        .btn-close-modal:hover { background: #004d73; transform: translateY(-2px); }

        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        @keyframes popIn { 
            0% { transform: scale(0.5); opacity: 0; } 
            100% { transform: scale(1); opacity: 1; } 
        }

        /* --- Navbar --- */
        .header {
            position: fixed; top: 0; left: 0; width: 100%; z-index: 1000;
            padding: 15px 50px; display: flex; justify-content: space-between; align-items: center;
            background: white; box-shadow: 0 4px 15px rgba(0,0,0,0.05); box-sizing: border-box;
        }
        .nav-left, .nav-right { display: flex; align-items: center; justify-content: space-evenly; flex: 1; gap: 0; }
        .nav-left a, .nav-right a { text-decoration: none; color: #00313e; font-size: 16px; font-weight: 500; transition: color 0.3s; }
        .nav-left a:hover, .nav-right a:hover { color: var(--btn-orange); }
        .logo { display: flex; align-items: center; gap: 10px; font-weight: 700; color: #00313e; font-size: 32px; text-decoration: none; }
        .logo-icon { width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; }
        .logo-icon img { width: 100%; height: 100%; object-fit: contain; }

        /* --- Layout --- */
        .container {
            max-width: 1000px; margin: 0 auto; padding: 130px 20px 80px;
            display: grid; grid-template-columns: 300px 1fr; gap: 30px; align-items: start;
        }

        /* --- Sidebar --- */
        .profile-sidebar {
            background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(10px);
            border-radius: 20px; padding: 40px 30px; text-align: center;
            box-shadow: 0 8px 30px rgba(0,0,0,0.06); border: 1px solid rgba(255,255,255,0.5);
            position: sticky; top: 110px; z-index: 10;
        }
        .img-wrapper { position: relative; width: 140px; height: 140px; margin: 0 auto 15px; }
        .profile-img {
            width: 100%; height: 100%; border-radius: 50%; object-fit: cover;
            border: 4px solid #FFF4E6; box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .btn-upload-label {
            display: inline-block; background: white; color: var(--btn-orange);
            border: 2px solid var(--btn-orange); padding: 8px 16px; border-radius: 20px;
            font-size: 13px; font-weight: 700; cursor: pointer; margin-bottom: 20px; transition: all 0.2s;
        }
        .btn-upload-label:hover { background: var(--btn-orange); color: white; }
        .sidebar-name { font-size: 22px; font-weight: 800; margin-bottom: 5px; color: var(--text-dark); }
        .sidebar-role { color: #666; font-size: 14px; font-weight: 500; margin-bottom: 25px; }
        .stat-row { display: flex; justify-content: center; gap: 20px; padding-top: 20px; border-top: 1px solid #eee; }
        .stat-item { text-align: center; }
        .stat-val { font-weight: 800; font-size: 18px; display: block; }
        .stat-label { font-size: 12px; color: #888; text-transform: uppercase; font-weight: 600; }

        /* --- Form --- */
        .edit-card { background: rgba(255, 255, 255, 0.95); border-radius: 20px; padding: 40px; box-shadow: 0 8px 30px rgba(0,0,0,0.06); }
        .form-title { font-size: 24px; font-weight: 800; margin-bottom: 30px; color: var(--text-dark); }
        .section-header {
            font-size: 16px; font-weight: 700; color: var(--text-dark);
            margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #FFF0E5;
            display: flex; align-items: center; gap: 10px;
        }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px; }
        .form-group { margin-bottom: 5px; }
        .form-group.full-width { grid-column: span 2; }
        label { display: block; font-size: 13px; font-weight: 600; margin-bottom: 8px; color: #555; text-transform: uppercase; }
        input, textarea {
            width: 100%; padding: 12px 15px; border-radius: 12px;
            border: 1px solid var(--input-border); font-family: 'Inter', sans-serif;
            font-size: 15px; box-sizing: border-box; transition: 0.2s; background: #FAFAFA;
        }
        input:focus, textarea:focus {
            outline: none; border-color: var(--input-focus); background: #FFF; box-shadow: 0 0 0 4px rgba(247, 127, 0, 0.1);
        }
        .btn-save {
            background-color: var(--btn-orange); color: white; border: none;
            padding: 15px 40px; border-radius: 50px; font-size: 16px; font-weight: 700;
            cursor: pointer; transition: 0.2s; display: block; width: 100%; margin-top: 10px;
            box-shadow: 0 4px 10px rgba(247, 127, 0, 0.3);
        }
        .btn-save:hover { background-color: var(--btn-hover); transform: translateY(-2px); }

        /* Blobs */
        .blob { position: absolute; filter: blur(50px); z-index: -1; opacity: 0.6; animation: float 10s ease-in-out infinite; }
        .blob-1 { top: -100px; left: -100px; width: 500px; height: 500px; background: rgba(247, 127, 0, 0.15); border-radius: 40% 60% 70% 30%; }
        .blob-2 { bottom: -150px; right: -100px; width: 600px; height: 600px; background: rgba(72, 201, 176, 0.15); border-radius: 60% 40% 30% 70%; animation-direction: reverse; }
        @keyframes float { 0% { transform: translate(0, 0) rotate(0deg); } 50% { transform: translate(30px, 20px) rotate(5deg); } 100% { transform: translate(0, 0) rotate(0deg); } }

        @media (max-width: 900px) {
            .container { grid-template-columns: 1fr; padding: 110px 20px 60px; }
            .profile-sidebar { position: static; width: 100%; box-sizing: border-box; }
        }
    </style>
</head>
<body>

    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

    <c:if test="${param.success eq 'true'}">
        <div class="modal-overlay" id="successModal">
            <div class="success-card">
                <div class="icon-circle">
                    <i class="fas fa-check"></i>
                </div>
                <h2 class="modal-title">Profile Updated!</h2>
                <p class="modal-text">Your profile details have been successfully saved.</p>
                <button class="btn-close-modal" onclick="closeModal()">Great, Thanks!</button>
            </div>
        </div>
    </c:if>

    <div class="header">
        <div class="nav-left">
            <a href="${pageContext.request.contextPath}/counselor/dashboard">Home</a>
            <a href="${pageContext.request.contextPath}/counselor/appointments">Appointment</a>
        </div>
        <a href="${pageContext.request.contextPath}/counselor/dashboard" class="logo">
            <div class="logo-icon"><img src="${pageContext.request.contextPath}/images/mindlink.png" alt="MindLink"></div>
            <span>MindLink</span>
        </a>
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/counselor/profile">Profile</a>
            <a href="${pageContext.request.contextPath}/logout" style="color: #D62828;">Logout</a>
        </div>
    </div>

    <form class="container" action="${pageContext.request.contextPath}/counselor/updateProfile" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${sessionScope.loggedInCounselor.id}">
        <input type="hidden" name="existingImage" value="${sessionScope.loggedInCounselor.imageUrl}">

        <div class="profile-sidebar">
            <div class="img-wrapper">
                <img id="profilePreview" 
                     src="${not empty sessionScope.loggedInCounselor.imageUrl ? pageContext.request.contextPath.concat(sessionScope.loggedInCounselor.imageUrl) : 'https://via.placeholder.com/150'}" 
                     alt="Profile" class="profile-img">
            </div>
            <input type="file" id="imageUpload" name="imageFile" accept="image/*" style="display: none;" onchange="previewImage(this)">
            <label for="imageUpload" class="btn-upload-label"><i class="fas fa-camera"></i> Change Photo</label>
            <div class="sidebar-name">${sessionScope.loggedInCounselor.name}</div>
            <div class="sidebar-role">Licensed Counselor</div>
            <div class="stat-row">
                <div class="stat-item"><span class="stat-val">#${sessionScope.loggedInCounselor.id}</span><span class="stat-label">ID</span></div>
                <div class="stat-item"><span class="stat-val">Active</span><span class="stat-label">Status</span></div>
            </div>
        </div>

        <div class="edit-card">
            <h2 class="form-title">Edit Profile</h2>

            <div class="section-header"><i class="far fa-user"></i> Personal Information</div>
            <div class="form-grid">
                <div class="form-group"><label>Full Name</label><input type="text" name="name" value="${sessionScope.loggedInCounselor.name}" required></div>
                <div class="form-group"><label>Email Address</label><input type="email" name="email" value="${sessionScope.loggedInCounselor.email}" required></div>
                <div class="form-group"><label>Password</label><input type="password" name="password" value="${sessionScope.loggedInCounselor.password}" required></div>
                <div class="form-group"><label>Location</label><input type="text" name="location" value="${sessionScope.loggedInCounselor.location}"></div>
            </div>

            <div class="section-header"><i class="fas fa-graduation-cap"></i> Professional Details</div>
            <div class="form-grid">
                <div class="form-group"><label>University</label><input type="text" name="university" value="${sessionScope.loggedInCounselor.university}"></div>
                <div class="form-group"><label>Degree / Qualification</label><input type="text" name="education" value="${sessionScope.loggedInCounselor.education}"></div>
                <div class="form-group full-width"><label>Languages Spoken</label><input type="text" name="languages" value="${sessionScope.loggedInCounselor.languages}"></div>
            </div>

            <div class="section-header"><i class="fas fa-id-card"></i> Public Profile</div>
            <div class="form-group" style="margin-bottom: 20px;"><label>Favorite Quote</label><input type="text" name="quote" value="${sessionScope.loggedInCounselor.quote}"></div>
            <div class="form-group" style="margin-bottom: 20px;"><label>Bio / About Me</label><textarea name="bio" rows="4">${sessionScope.loggedInCounselor.bio}</textarea></div>

            <button type="submit" class="btn-save">Save Changes</button>
        </div>
    </form>

    <script>
        // Preview Image Script
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) { document.getElementById('profilePreview').src = e.target.result; }
                reader.readAsDataURL(input.files[0]);
            }
        }

        // 🟢 Close Modal Script
        function closeModal() {
            const modal = document.getElementById('successModal');
            if (modal) {
                // Fade out animation
                modal.style.transition = "opacity 0.3s";
                modal.style.opacity = "0";
                setTimeout(() => {
                    modal.style.display = "none";
                    const url = new URL(window.location);
                    url.searchParams.delete('success');
                    window.history.replaceState(null, '', url);
                }, 300);
            }
        }
    </script>

</body>
</html>