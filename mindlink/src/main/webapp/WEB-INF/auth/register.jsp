<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Create Account - MindLink</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background-color: #FDF3E7;
                /* Beige Theme */
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                color: #003B46;
            }

            .register-card {
                background: white;
                padding: 40px 50px;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                width: 450px;
                /* Slightly wider than login */
                text-align: center;
                margin: 20px;
            }

            .logo {
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 10px;
                color: #003B46;
            }

            .subtitle {
                color: #667085;
                font-size: 14px;
                margin-bottom: 30px;
            }

            .form-group {
                margin-bottom: 20px;
                text-align: left;
            }

            label {
                display: block;
                font-size: 13px;
                font-weight: 600;
                margin-bottom: 8px;
            }

            input {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 14px;
                outline: none;
                background: #F9FAFB;
            }

            input:focus {
                border-color: #003B46;
                background: white;
            }

            .btn-register {
                width: 100%;
                padding: 12px;
                background-color: #003B46;
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                margin-top: 10px;
                transition: 0.3s;
            }

            .btn-register:hover {
                background-color: #005566;
            }

            .signin-link {
                margin-top: 20px;
                font-size: 13px;
                color: #666;
            }

            .signin-link a {
                color: #003B46;
                font-weight: 600;
                text-decoration: none;
            }

            .signin-link a:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <body>

        <div class="register-card">
            <div class="logo"><img src="${pageContext.request.contextPath}/images/mindlink.png"
                    alt="MindLink Logo">MindLink</div>
            <p class="subtitle">Create an account to start your journey.</p>

        <form action="${pageContext.request.contextPath}/register/submit" method="post">
                <div class="form-group">
                    <label>Student ID</label>
                    <input type="text" name="studentId" placeholder="e.g. S12345" required>
                </div>

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullname" placeholder="e.g. Karen Lee" required>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" placeholder="name@example.com" required>
                </div>

                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" placeholder="Choose a username" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Create a password" required>
                </div>

                <button type="submit" class="btn-register">Create Account</button>
            </form>

            <div class="signin-link">
                Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in</a>
            </div>
        </div>

    </body>

    </html>