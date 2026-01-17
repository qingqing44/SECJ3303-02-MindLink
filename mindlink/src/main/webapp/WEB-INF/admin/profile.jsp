<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #FFF3E0;
            --text-dark: #003049;
            --text-blue: #2F80ED;
            --card-bg: #FDF3E7;
            --btn-dark: #013B46;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            margin: 0; padding: 0;
            color: var(--text-dark);
        }

        /* Header Navigation */
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

        .nav-left a, .nav-right a {
            text-decoration: none;
            color: #00313e;
            font-size: 16px;
            font-weight: 500;
            transition: color 0.3s;
        }

        .nav-left a:hover, .nav-right a:hover {
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

        /* Main Container */
        .container {
            max-width: 1000px;
            margin: 40px auto;
            background-color: var(--card-bg);
            border-radius: 50px;
            padding: 60px 80px;
            position: relative;
            min-height: 500px;
        }

        /* Back Button */
        .back-btn {
            position: absolute; top: 40px; left: 40px;
            font-size: 32px; text-decoration: none; color: #000;
        }

        /* Grid Layout */
        .profile-layout {
            display: flex; gap: 60px; align-items: flex-start; margin-top: 20px;
        }

        /* Profile Icon */
        .profile-icon {
            width: 150px; height: 150px;
            border: 6px solid #000; border-radius: 50%;
            display: flex; justify-content: center; align-items: center;
        }
        
        .profile-icon svg { width: 80px; height: 80px; }

        /* Details */
        .details-section { flex: 1; display: flex; flex-direction: column; gap: 25px; }
        .row { display: flex; align-items: center; font-size: 20px; }
        .label { font-weight: 800; color: var(--text-dark); margin-right: 10px; }
        .value { font-weight: 700; color: var(--text-blue); }

        .top-row { display: flex; justify-content: space-between; width: 100%; }

        /* Edit Button */
        .btn-edit {
            background-color: var(--btn-dark);
            color: white; width: 300px; padding: 15px;
            border-radius: 30px; font-size: 18px; font-weight: 600;
            border: none; cursor: pointer;
            display: block; margin: 60px auto 0 auto;
            transition: 0.2s;
        }
        .btn-edit:hover { opacity: 0.9; }

        /* Logout Button */
        .btn-logout {
            background-color: #D62828;
            color: white;
            width: 300px;
            padding: 15px;
            border-radius: 30px;
            font-size: 18px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            display: block;
            margin: 20px auto 0 auto;
            transition: 0.2s;
            text-decoration: none;
            text-align: center;
        }

        .btn-logout:hover {
            opacity: 0.9;
        }

        .button-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
            margin-top: 60px;
        }

    </style>
</head>
<body>

  <!-- Header Navigation -->
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
        <a href="${pageContext.request.contextPath}/admin/home" class="back-btn">
            <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M9 14L4 9l5-5"/>
                <path d="M4 9h10c4 0 7 3 7 7v1"/>
            </svg>
        </a>

        <c:if test="${not empty successMessage}">
            <div style="text-align: center; padding: 15px; background: #e8f5e9; color: #2e7d32; border-radius: 10px; margin-bottom: 20px;">
                <strong>Success:</strong> ${successMessage}
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div style="text-align: center; padding: 15px; background: #ffebee; color: #c62828; border-radius: 10px; margin-bottom: 20px;">
                <strong>Error:</strong> ${errorMessage}
            </div>
        </c:if>

        <div class="profile-layout">
            
            <div>
                <div class="profile-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                </div>
            </div>

            <div class="details-section">
                
                <div class="top-row">
                    <div class="row">
                        <span class="label">Full Name :</span>
                        <span class="value">${p.name}</span>
                    </div>
                    <div class="row">
                        <span class="label">Admin ID :</span>
                        <span class="value">${p.adminId}</span>
                    </div>
                </div>

                <div class="row">
                    <span class="label">Email Address :</span>
                    <span class="value">${p.email}</span>
                </div>

                <div class="row">
                    <span class="label">Phone Number :</span>
                    <span class="value">${p.phone != null && !p.phone.isEmpty() ? p.phone : 'Not provided'}</span>
                </div>

                <div class="row">
                    <span class="label">Department :</span>
                    <span class="value">${p.department != null && !p.department.isEmpty() ? p.department : 'Not provided'}</span>
                </div>

                <div class="row">
                    <span class="label">Role :</span>
                    <span class="value">${p.role != null ? p.role : 'admin'}</span>
                </div>

            </div>
            <script>
            function togglePassword() {
                var passwordInput = document.getElementById("passwordField");
                var icon = document.getElementById("toggleIcon");

                if (passwordInput.type === "password") {
                    passwordInput.type = "text"; // Show password
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash"); // Change icon to 'crossed eye'
                } else {
                    passwordInput.type = "password"; // Hide password
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye"); // Change icon back to 'eye'
                }
            }
            </script>
        </div>

        <div class="button-container">
            <a href="${pageContext.request.contextPath}/admin/profile/edit" class="btn-edit" style="text-decoration: none; text-align: center;">Edit</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
        </div>

    </div>

</body>
</html>