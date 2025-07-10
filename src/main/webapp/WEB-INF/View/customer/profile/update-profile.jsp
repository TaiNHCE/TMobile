<%-- 
    Document   : update-profile
    Created on : Jun 27, 2025, 11:11:38 AM
    Author     : pc
--%>
<%@page import="model.Customer"%>
<%@page import="model.Account"%>
<%@page import="model.Staff"%>
<%
    Customer cus = (Customer) request.getAttribute("cus");
    Integer accountId = (Integer) session.getAttribute("accountId");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Profile</title>
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

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                color: #333;
                font-weight: 600;
                margin-bottom: 8px;
                display: flex;
                align-items: center;
            }

            .profile-icon {
                color: #667eea;
                margin-right: 8px;
            }

            .form-control {
                border: 2px solid #e9ecef;
                border-radius: 10px;
                padding: 12px 15px;
                font-size: 14px;
                transition: all 0.3s ease;
                background: rgba(255, 255, 255, 0.9);
            }

            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
                background: white;
            }

            .gender-options {
                display: flex;
                align-items: center;
                gap: 25px;
                margin-top: 8px;
            }

            .gender-option {
                display: flex;
                align-items: center;
                gap: 8px;
                font-weight: 500;
                color: #555;
                cursor: pointer;
                padding: 8px 15px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .gender-option:hover {
                background: rgba(102, 126, 234, 0.1);
            }

            .form-check-input {
                width: 18px;
                height: 18px;
                margin: 0;
                cursor: pointer;
            }

            .form-check-input:checked {
                background-color: #667eea;
                border-color: #667eea;
            }

            .profile-actions {
                padding-top: 25px;
                border-top: 1px solid #f0f0f0;
                margin-top: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .btn-update {
                background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
                border: none;
                border-radius: 10px;
                padding: 12px 30px;
                font-weight: 600;
                color: white;
                text-decoration: none;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                cursor: pointer;
                font-size: 14px;
            }

            .btn-update:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(17, 153, 142, 0.3);
                color: white;
            }

            .btn-cancel {
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                border: none;
                border-radius: 10px;
                padding: 12px 30px;
                font-weight: 600;
                color: white;
                text-decoration: none;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
            }

            .btn-cancel:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(245, 87, 108, 0.3);
                color: white;
            }

            .alert {
                border-radius: 10px;
                border: none;
                padding: 15px 20px;
                margin: 20px 0;
                font-weight: 500;
            }

            .alert-danger {
                background: linear-gradient(135deg, #ffeaea 0%, #ffccd5 100%);
                color: #c53030;
            }

            .alert-danger i {
                margin-right: 8px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .profile-actions {
                    flex-direction: column;
                    gap: 15px;
                }

                .btn-update, .btn-cancel {
                    width: 100%;
                    justify-content: center;
                }

                .gender-options {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 12px;
                }

                .profile-body {
                    padding: 20px;
                }
            }

            /* Form validation styles */
            .form-control:invalid {
                border-color: #dc3545;
            }

            .form-control:valid {
                border-color: #28a745;
            }

            /* Loading state */
            .btn-update:disabled {
                opacity: 0.6;
                cursor: not-allowed;
                transform: none;
            }

            .btn-update:disabled:hover {
                transform: none;
                box-shadow: none;
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
                            <i class="bi bi-pencil-square me-2"></i>
                            Update Profile Information
                        </h4>
                    </div>
                    
                    <div class="profile-body">
                        <% if (cus == null) { %>
                            <div class="alert alert-danger">
                                <i class="bi bi-exclamation-triangle-fill"></i>
                                There is no customer with that ID
                            </div>
                        <% } else { %>
                            <form method="post" action="UpdateProfile">
                                <input type="hidden" name="id" value="<%= cus.getId() %>">
                                
                                <div class="form-group">
                                    <label>
                                        <i class="bi bi-person profile-icon"></i>
                                        Full Name:
                                    </label>
                                    <input type="text" 
                                           name="fullname" 
                                           value="<%= cus.getFullName() != null ? cus.getFullName() : "" %>" 
                                           class="form-control"
                                           required>
                                </div>
                                
                                <div class="form-group">
                                    <label>
                                        <i class="bi bi-telephone profile-icon"></i>
                                        Phone Number:
                                    </label>
                                    <input type="tel" 
                                           name="phone" 
                                           value="<%= cus.getPhone() != null ? cus.getPhone() : "" %>" 
                                           class="form-control"
                                           pattern="[0-9]{10,11}"
                                           title="Please enter a valid phone number">
                                </div>
                                
                                <div class="form-group">
                                    <label>
                                        <i class="bi bi-calendar profile-icon"></i>
                                        Date of Birth:
                                    </label>
                                    <input type="date" 
                                           name="dob" 
                                           value="<%= cus.getBirthDay() != null ? cus.getBirthDay() : "" %>" 
                                           class="form-control"
                                           max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                                </div>
                                
                                <div class="form-group">
                                    <label>
                                        <i class="bi bi-gender-ambiguous profile-icon"></i>
                                        Gender:
                                    </label>
                                    <div class="gender-options">
                                        <div class="gender-option">
                                            <input type="radio" 
                                                   class="form-check-input" 
                                                   name="gender" 
                                                   value="male" 
                                                   id="male"
                                                   <%= "male".equalsIgnoreCase(cus.getGender()) ? "checked" : "" %>>
                                            <label for="male">Male</label>
                                        </div>
                                        <div class="gender-option">
                                            <input type="radio" 
                                                   class="form-check-input" 
                                                   name="gender" 
                                                   value="female" 
                                                   id="female"
                                                   <%= "female".equalsIgnoreCase(cus.getGender()) ? "checked" : "" %>>
                                            <label for="female">Female</label>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="profile-actions">
                                    <a href="ViewProfile?id=<%= accountId %>" class="btn-cancel">
                                        <i class="bi bi-x-circle me-2"></i>
                                        Cancel
                                    </a>
                                    <button type="submit" class="btn-update">
                                        <i class="bi bi-check-circle me-2"></i>
                                        Update Profile
                                    </button>
                                </div>
                            </form>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        
        <script>
            // Form validation
            document.querySelector('form').addEventListener('submit', function(e) {
                const submitBtn = document.querySelector('.btn-update');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Updating...';
            });
            
            // Phone number formatting
            document.querySelector('input[name="phone"]').addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length > 11) {
                    value = value.substring(0, 11);
                }
                e.target.value = value;
            });
        </script>
    </body>
</html>