<%-- 
    Document   : change-password.jsp
    Created on : Jul 10, 2025, 10:00:50 AM
    Author     : pc
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <style>
            .change-password-container {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .change-password-card {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                padding: 40px;
                width: 100%;
                max-width: 450px;
            }

            .change-password-title {
                color: #333;
                font-weight: 600;
                margin-bottom: 30px;
                text-align: center;
            }

            .form-control {
                border-radius: 10px;
                border: 2px solid #e9ecef;
                padding: 12px 15px;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }

            .btn-change-password {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                border-radius: 10px;
                padding: 12px 30px;
                font-weight: 600;
                width: 100%;
                transition: all 0.3s ease;
                margin-top: 20px;
            }

            .btn-change-password:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
            }

            .alert {
                border-radius: 10px;
                margin-bottom: 20px;
                font-weight: 500;
                border: none;
            }

            .alert-danger {
                background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
                color: white;
            }

            .alert-success {
                background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
                color: white;
            }

            .form-label {
                font-weight: 500;
                color: #333;
                margin-bottom: 8px;
            }

            .mb-3 {
                margin-bottom: 20px;
            }

            .back-link {
                text-align: center;
                margin-top: 20px;
            }

            .back-link a {
                color: #667eea;
                text-decoration: none;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .back-link a:hover {
                color: #764ba2;
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <%
            Integer accountId = (Integer) session.getAttribute("accountId");
        %>
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />
        <div class="change-password-container">
            <div class="change-password-card">
                <h1 class="change-password-title">
                    <i class="bi bi-shield-lock me-2"></i>
                    Change Password
                </h1>

                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    <%= error%>
                </div>
                <%
                    }
                %>

                <%
                    String success = (String) request.getAttribute("success");
                    if (success != null) {
                %>
                <div class="alert alert-success">
                    <i class="bi bi-check-circle me-2"></i>
                    <%= success%>
                </div>
                <%
                    }
                %>

                <form method="post" action="ChangePassword">
                    <div class="mb-3">
                        <label for="oldPassword" class="form-label">
                            <i class="bi bi-lock me-2"></i>Old Password
                        </label>
                        <input type="password" class="form-control" name="oldPassword" id="oldPassword" required placeholder="Enter your current password">
                    </div>

                    <div class="mb-3">
                        <label for="newPassword" class="form-label">
                            <i class="bi bi-key me-2"></i>New Password
                        </label>
                        <input type="password" class="form-control" name="newPassword" id="newPassword" required placeholder="Enter your new password">
                    </div>

                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">
                            <i class="bi bi-key-fill me-2"></i>Confirm New Password
                        </label>
                        <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" required placeholder="Confirm your new password">
                    </div>

                    <button type="submit" class="btn btn-primary btn-change-password">
                        <i class="bi bi-shield-check me-2"></i>
                        Change Password
                    </button>
                </form>

                <div class="back-link">
                    <a href="ViewProfile?id=<%= accountId %>">
                        <i class="bi bi-arrow-left me-1"></i>
                        Back to Profile
                    </a>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>