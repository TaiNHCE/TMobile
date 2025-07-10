<%-- 
    Document   : view-staff-detail
    Created on : Jun 12, 2025, 10:01:59 PM
    Author     : pc
--%>

<%@page import="model.Customer"%>
<%@page import="model.Account"%>
<%@page import="model.Staff"%>
<%

    Customer sta = (Customer) request.getAttribute("cus");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <style>
            html, body {
                height: 100%;
            }

            body {
                display: flex;
                flex-direction: column;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
            }

            .content {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px 20px;
            }

            .profile-card {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 700px;
                border: none;
            }

            .profile-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 20px 20px 0 0;
                padding: 25px 30px;
                border: none;
            }

            .profile-header h4 {
                margin: 0;
                font-weight: 600;
                display: flex;
                align-items: center;
            }

            .profile-body {
                padding: 30px;
            }

            .profile-table {
                margin-bottom: 0;
            }

            .profile-table th {
                color: #333;
                font-weight: 600;
                padding: 15px 0;
                border: none;
                width: 180px;
                vertical-align: middle;
            }

            .profile-table td {
                color: #555;
                padding: 15px 0;
                border: none;
                vertical-align: middle;
            }

            .profile-table tr {
                border-bottom: 1px solid #f0f0f0;
            }

            .profile-table tr:last-child {
                border-bottom: none;
            }

            .error-message {
                color: #ff6b6b;
                font-size: 0.875rem;
                font-style: italic;
                font-weight: 500;
                display: inline-block;
                background: rgba(255, 107, 107, 0.1);
                padding: 4px 8px;
                border-radius: 6px;
                border: 1px solid rgba(255, 107, 107, 0.3);
            }

            .profile-actions {
                padding-top: 25px;
                border-top: 1px solid #f0f0f0;
                margin-top: 20px;
            }

            .btn-change-password {
                background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
                border: none;
                border-radius: 10px;
                padding: 12px 25px;
                font-weight: 600;
                color: white;
                text-decoration: none;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
            }

            .btn-change-password:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(17, 153, 142, 0.3);
                color: white;
            }

            .btn-update {
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                border: none;
                border-radius: 10px;
                padding: 12px 25px;
                font-weight: 600;
                color: white;
                text-decoration: none;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
            }

            .btn-update:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(245, 87, 108, 0.3);
                color: white;
            }

            .gender-options {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .gender-option {
                display: flex;
                align-items: center;
                gap: 8px;
                font-weight: 500;
                color: #555;
            }

            .form-check-input:disabled {
                opacity: 0.7;
            }

            .profile-value {
                font-weight: 500;
                color: #333;
            }

            .profile-icon {
                color: #667eea;
                margin-right: 8px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />
        <div class="content">
            <div class="container-fluid">
                <div class="profile-card mx-auto">        
                    <div class="profile-header">
                        <h4>
                            <i class="bi bi-person-circle me-2"></i>
                            Profile Information
                        </h4>
                    </div>
                    <form method="get" action="ViewProfile?action=list">
                        <div class="profile-body">
                            <table class="table profile-table">
                                <tr>
                                    <th>
                                        <i class="bi bi-hash profile-icon"></i>
                                        ID:
                                    </th>
                                    <td class="profile-value">
                                        <%= sta.getId()%>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <i class="bi bi-person profile-icon"></i>
                                        Full Name:
                                    </th>
                                    <td class="profile-value">
                                        <%= sta.getFullName()%>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <i class="bi bi-telephone profile-icon"></i>
                                        Phone Number:
                                    </th>
                                    <td>
                                        <%= (sta.getPhone() == null || sta.getPhone().isEmpty())
                                                ? "<span class='error-message'><i class='bi bi-exclamation-triangle me-1'></i>Please enter your phone number</span>"
                                                : "<span class='profile-value'>" + sta.getPhone() + "</span>"%>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <i class="bi bi-envelope profile-icon"></i>
                                        Email:
                                    </th>
                                    <td class="profile-value">
                                        <%= sta.getEmail()%>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <i class="bi bi-calendar profile-icon"></i>
                                        Date of Birth:
                                    </th>
                                    <td>
                                        <%-- Dán đoạn JSP xử lý date ở đây --%>
                                        <%
                                            String birth = sta.getBirthDay();
                                            String birthFormatted = "";
                                            if (birth != null && !birth.isEmpty()) {
                                                try {
                                                    java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                    java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
                                                    java.util.Date birthDate = inputFormat.parse(birth);
                                                    birthFormatted = outputFormat.format(birthDate);
                                                } catch (Exception e) {
                                                    birthFormatted = "Your birthday is invalid";
                                                }
                                            }
                                        %>

                                        <%= (birth == null || birth.isEmpty())
                                                ? "<span class='error-message'><i class='bi bi-exclamation-triangle me-1'></i>Please enter your date of birth</span>"
                                                : "<span class='profile-value'>" + birthFormatted + "</span>"%>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <i class="bi bi-gender-ambiguous profile-icon"></i>
                                        Sex:
                                    </th>
                                    <td>
                                        <div class="gender-options">
                                            <div class="gender-option">
                                                <input type="radio" class="form-check-input" name="sex" value="male"
                                                       <%= ("male".equalsIgnoreCase(sta.getGender()) ? "checked" : "")%> disabled />
                                                <span>Male</span>
                                            </div>
                                            <div class="gender-option">
                                                <input type="radio" class="form-check-input" name="sex" value="female"
                                                       <%= ("female".equalsIgnoreCase(sta.getGender()) ? "checked" : "")%> disabled />
                                                <span>Female</span>
                                            </div>
                                        </div>
                                        <% if (sta.getGender() == null || sta.getGender().trim().isEmpty()) { %>
                                        <div class="mt-2">
                                            <span class="error-message">
                                                <i class="bi bi-exclamation-triangle me-1"></i>
                                                Please enter your gender
                                            </span>
                                        </div>
                                        <% }%> 
                                    </td>
                                </tr>
                            </table>

                            <div class="profile-actions d-flex justify-content-between">
                                <a href="ChangePassword" class="btn-change-password">
                                    <i class="bi bi-shield-lock me-2"></i>
                                    Change Password
                                </a>
                                <a href="UpdateProfile?id=<%= sta.getId()%>" class="btn-update">
                                    <i class="bi bi-pencil-square me-2"></i>
                                    Update Profile
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>