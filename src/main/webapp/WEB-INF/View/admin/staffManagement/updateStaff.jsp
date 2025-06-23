<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Account, model.Staff" %>
<%
    Account account = (Account) request.getAttribute("account");
    Staff staff = (Staff) request.getAttribute("staff");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Update Staff</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            h1, h3 {
                margin-top: 20px;
                margin-bottom: 20px;
                color: #343a40;
            }

            form {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            }

            label.form-label {
                font-weight: 600;
                color: #495057;
            }

            .form-control, .form-select {
                border-radius: 8px;
            }

            .form-control:focus, .form-select:focus {
                border-color: #0d6efd;
                box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
            }

            .alert {
                border-radius: 8px;
                font-size: 0.95rem;
            }

            button[type="submit"] {
                background-color: #0d6efd;
                border: none;
                padding: 10px 20px;
                font-weight: 600;
                transition: background-color 0.3s ease;
                border-radius: 8px;
            }

            button[type="submit"]:hover {
                background-color: #0b5ed7;
            }

            a.btn-secondary {
                margin-left: 10px;
                border-radius: 8px;
            }

            #emailError,
            #phoneError,
            #birthDateError,
            #fullNameError {
                font-size: 0.85rem;
            }

            hr.section-divider {
                margin: 30px 0 10px 0;
                border-top: 2px solid #dee2e6;
            }
        </style>    
    </head>
    <body>
        <div class="container mt-4">
            <h1>Update Staff</h1>
            <% if (request.getAttribute("errorMessage") != null) {%>
            <div class="alert alert-danger"><%= request.getAttribute("errorMessage")%></div>
            <% }%>

            <form action="UpdateStaffServlet" method="post" class="row g-3">
                <!-- Hidden IDs -->
                <input type="hidden" name="accountID" value="<%= account.getAccountID()%>">
                <input type="hidden" name="staffID" value="<%= staff.getStaffID()%>">

                <!-- Account Information -->
                <h3>Account Information</h3>
                <div class="col-md-6">
                    <label for="email" class="form-label">Email:</label>
                    <input type="email" id="email" name="email" class="form-control" value="<%= account.getEmail()%>" required>
                    <div id="emailError" class="text-danger small mt-1"></div> 
                    <input type="hidden" id="currentEmail" value="<%= account.getEmail()%>">

                </div>
                <div class="col-md-6">
                   
                </div>
                <div class="col-md-6">
                    
                </div>
                <div class="col-md-12">
                    <label for="profileImageURL" class="form-label">Profile Image URL:</label>
                    <input type="url" id="profileImageURL" name="profileImageURL" class="form-control" value="<%= account.getProfileImageURL()%>">
                </div>

                <!-- Staff Information -->
                <h3>Staff Information</h3>
                <div class="col-md-6">
                    <label for="fullName" class="form-label">Full Name:</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" value="<%= staff.getFullName()%>" required>
                    <div id="fullNameError" class="text-danger small mt-1"></div>

                </div>
                <div class="col-md-6">
                    <label for="phoneNumber" class="form-label">Phone Number:</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" value="<%= staff.getPhone()%>">
                    <div id="phoneError" class="text-danger small mt-1"></div>
                    <input type="hidden" id="currentPhone" value="<%= staff.getPhone()%>">

                </div>
                <div class="col-md-6">
                    <label for="birthDate" class="form-label">Birth Date:</label>
                    <input type="date" id="birthDate" name="birthDate" class="form-control" value="<%= staff.getBirthDay() != null ? staff.getBirthDay().toString() : ""%>">
                    <div id="birthDateError" class="text-danger small mt-1"></div>

                </div>
                <div class="col-md-6">
                    <label for="gender" class="form-label">Gender:</label>
                    <select id="gender" name="gender" class="form-select">
                        <option value="">Select Gender</option>
                        <option value="Male" <%= "Male".equals(staff.getGender()) ? "selected" : ""%>>Male</option>
                        <option value="Female" <%= "Female".equals(staff.getGender()) ? "selected" : ""%>>Female</option>
                        <option value="Other" <%= "Other".equals(staff.getGender()) ? "selected" : ""%>>Other</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="position" class="form-label">Position:</label>
                    <input type="text" id="position" name="position" class="form-control" value="<%= staff.getPosition()%>" required>
                </div>
                <div class="col-md-6">
                    <label for="hiredDate" class="form-label">Hired Date:</label>
                    <input type="date" id="hiredDate" name="hiredDate" class="form-control" value="<%= staff.getHiredDate() != null ? staff.getHiredDate().toString() : ""%>" required>
                </div>

                <div class="col-12">
                    <button type="submit" class="btn btn-primary">Update Staff</button>
                    <a href="StaffList" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </body>
</html>
<script>
    const submitBtn = document.querySelector("button[type='submit']");
    const currentEmail = document.getElementById("currentEmail").value;
    const currentPhone = document.getElementById("currentPhone").value;

    // ===== EMAIL =====
    const emailInput = document.getElementById("email");
    const emailError = document.getElementById("emailError");

    emailInput.addEventListener("blur", function () {
        const email = emailInput.value.trim();
        const emailPattern = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
        emailError.textContent = "";
        submitBtn.disabled = false;

        if (!emailPattern.test(email)) {
            emailError.textContent = "Email must be a valid Gmail address.";
            submitBtn.disabled = true;
            return;
        }

        // Chỉ kiểm tra trùng nếu người dùng thay đổi email
        if (email !== currentEmail) {
            fetch("CheckEmailServlet?email=" + encodeURIComponent(email))
                    .then(response => response.text())
                    .then(data => {
                        if (data === "EXISTS") {
                            emailError.textContent = "This email already exists.";
                            submitBtn.disabled = true;
                        }
                    })
                    .catch(error => {
                        emailError.textContent = "Error checking email.";
                        submitBtn.disabled = true;
                    });
        }
    });

    emailInput.addEventListener("input", function () {
        emailError.textContent = "";
        submitBtn.disabled = false;
    });

    // ===== PHONE =====
    const phoneInput = document.getElementById("phoneNumber");
    const phoneError = document.getElementById("phoneError");

    phoneInput.addEventListener("blur", function () {
        const phone = phoneInput.value.trim();
        const phonePattern = /^0\d{9}$/;
        phoneError.textContent = "";
        submitBtn.disabled = false;

        if (!phonePattern.test(phone)) {
            phoneError.textContent = "Phone must start with 0 and have exactly 10 digits.";
            submitBtn.disabled = true;
            return;
        }

        // Chỉ kiểm tra nếu thay đổi số điện thoại
        if (phone !== currentPhone) {
            fetch("CheckPhoneServlet?phone=" + encodeURIComponent(phone))
                    .then(response => response.text())
                    .then(data => {
                        if (data === "EXISTS") {
                            phoneError.textContent = "Phone number already exists.";
                            submitBtn.disabled = true;
                        }
                    })
                    .catch(error => {
                        phoneError.textContent = "Error checking phone.";
                        submitBtn.disabled = true;
                    });
        }
    });

    phoneInput.addEventListener("input", function () {
        phoneError.textContent = "";
        submitBtn.disabled = false;
    });

    // ===== BIRTHDATE (check >= 18 tuổi) =====
    const birthInput = document.getElementById("birthDate");
    const birthError = document.getElementById("birthDateError");

    birthInput.addEventListener("blur", function () {
        const birthDate = new Date(this.value);
        const today = new Date();
        birthError.textContent = "";
        submitBtn.disabled = false;

        if (isNaN(birthDate.getTime()))
            return;

        let age = today.getFullYear() - birthDate.getFullYear();
        const m = today.getMonth() - birthDate.getMonth();

        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }

        if (age < 18) {
            birthError.textContent = "Staff must be at least 18 years old.";
            submitBtn.disabled = true;
        }
    });

    // ===== FULLNAME =====
    const fullNameInput = document.getElementById("fullName");
    const fullNameError = document.getElementById("fullNameError");

    fullNameInput.addEventListener("blur", function () {
        let name = fullNameInput.value.trim();
        fullNameError.textContent = "";
        submitBtn.disabled = false;

        name = name.replace(/\s+/g, " ");
        fullNameInput.value = name;

        const namePattern = /^([A-ZÀ-Ỹ][a-zà-ỹ]+)(\s[A-ZÀ-Ỹ][a-zà-ỹ]+)*$/u;

        if (!namePattern.test(name)) {
            fullNameError.textContent = "Names must be initialed, contain no numbers or special characters, and have no spaces..";
            submitBtn.disabled = true;
        }
    });

    fullNameInput.addEventListener("input", function () {
        fullNameError.textContent = "";
        submitBtn.disabled = false;
    });

</script>
