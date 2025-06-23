<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Create New Staff</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            body {
                background-color: #f4f8fb;
                font-family: 'Arial', sans-serif;
            }

            .container {
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                color: #333;
            }

            h3 {
                color: #555;
                border-bottom: 2px solid #f0f0f0;
                padding-bottom: 5px;
                margin-bottom: 20px;
            }

            .form-label {
                font-weight: bold;
            }

            .form-control {
                border-radius: 5px;
                border: 1px solid #ddd;
            }

            .form-select {
                border-radius: 5px;
                border: 1px solid #ddd;
            }

            .alert {
                margin-bottom: 20px;
            }

            .btn {
                border-radius: 5px;
                padding: 10px 20px;
                font-size: 1rem;
            }

            .btn-primary {
                border: none;
                transition: background-color 0.3s ease;
            }

            .btn-primary:hover {
                background-color: #45a049;
            }

            .btn-secondary {
                background-color: #6c757d;
                border: none;
                color: white;
                transition: background-color 0.3s ease;
            }

            .btn-secondary:hover {
                background-color: #5a6368;
            }

            .form-control:focus {
                border-color: #4CAF50;
                box-shadow: 0 0 0 0.25rem rgba(76, 175, 80, 0.25);
            }

            .text-danger {
                font-size: 0.85rem;
                margin-top: 5px;
            }

            .small {
                font-size: 0.85rem;
            }

            .col-md-6 {
                margin-bottom: 15px;
            }

            .col-md-12 {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <h2>Create New Staff</h2>
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
            <div class="alert alert-danger" role="alert">
                <%= errorMessage %>
            </div>
            <%
}
            %>
            <form action="CreateStaffServlet" method="post" class="row g-3">
                <!-- Account Information -->
                <h3>Account Information</h3>
                <div class="col-md-6">
                    <label for="email" class="form-label">Email:</label>
                    <input type="email" id="email" name="email" class="form-control" required>
                    <div id="emailError" class="text-danger small mt-1"></div>
                </div>

                <div class="col-md-6">
                    <label for="password" class="form-label">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>
                <div class="col-md-6">
                   
                </div>
                <div class="col-md-12">
                    <label for="profileImageURL" class="form-label">Profile Image URL:</label>
                    <input type="url" id="profileImageURL" name="profileImageURL" class="form-control">
                </div>

                <!-- Staff Information -->
                <h3>Staff Information</h3>
                <div class="col-md-6">
                    <label for="fullName" class="form-label">Full Name:</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" required>
                    <div id="fullNameError" class="text-danger small mt-1"></div>
                </div>
                <div class="col-md-6">
                    <label for="phoneNumber" class="form-label">Phone Number:</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" class="form-control">
                    <div id="phoneError" class="text-danger small mt-1"></div>
                </div>
                <div class="col-md-6">
                    <label for="birthDate" class="form-label">Birth Date:</label>
                    <input type="date" id="birthDate" name="birthDate" class="form-control">
                    <div id="birthDateError" class="text-danger small mt-1"></div>
                </div>
                <div class="col-md-6">
                    <label for="gender" class="form-label">Gender:</label>
                    <select id="gender" name="gender" class="form-select">
                        <option value="">Select Gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="position" class="form-label">Position:</label>
                    <input type="text" id="position" name="position" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label for="hiredDate" class="form-label">Hired Date:</label>
<input type="date" id="hiredDate" name="hiredDate" class="form-control" required>
                </div>

                <div class="col-12">
                    <button type="submit" class="btn btn-primary">Create Staff</button>
                    <a href="StaffList" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>



<script>

// check email valid and already exists
    const emailInput = document.getElementById("email");
    const emailError = document.getElementById("emailError");
    const submitBtn = document.querySelector("button[type='submit']");

    emailInput.addEventListener("blur", function () {
        const email = emailInput.value.trim();
        const emailPattern = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
        emailError.textContent = ""; // Clear previous error
        submitBtn.disabled = false; // Re-enable button

        if (!emailPattern.test(email)) {
            emailError.textContent = "Email must be a valid Gmail address.";
            submitBtn.disabled = true;
            return;
        }


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
                    console.error("Error:", error);
                });
    });


    emailInput.addEventListener("input", function () {
        emailError.textContent = "";
        submitBtn.disabled = false;
    });



//check numberphone
    const phoneInput = document.getElementById("phoneNumber");
    const phoneError = document.getElementById("phoneError");

    phoneInput.addEventListener("blur", function () {
        const phone = phoneInput.value.trim();
        phoneError.textContent = "";
        submitBtn.disabled = false;

        const phonePattern = /^0\d{9}$/;
        if (!phonePattern.test(phone)) {
            phoneError.textContent = "Phone must start with 0 and have exactly 10 digits.";
            submitBtn.disabled = true;
            return;
        }

        // Nếu đúng định dạng, kiểm tra trùng
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
                    console.error("Error:", error);
                });
    });

// check 18 year
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


// check valid fullname
    const fullNameInput = document.getElementById("fullName");
    const fullNameError = document.createElement("div");
    fullNameError.id = "fullNameError";
    fullNameError.className = "text-danger small mt-1";
    fullNameInput.parentNode.appendChild(fullNameError);

    fullNameInput.addEventListener("blur", function () {
        let name = fullNameInput.value.trim();
        fullNameError.textContent = "";
        submitBtn.disabled = false;

        name = name.replace(/\s+/g, " ");
        fullNameInput.value = name;

        const namePattern = /^([A-ZÀ-Ỹ][a-zà-ỹ]+)(\s[A-ZÀ-Ỹ][a-zà-ỹ]+)*$/u;

        if (!namePattern.test(name)) {
            fullNameError.textContent = "Names must be initialed, contain no numbers or special characters, and have no spaces.";
            submitBtn.disabled = true;
        }
    });

    fullNameInput.addEventListener("input", function () {
        fullNameError.textContent = "";
        submitBtn.disabled = false;
    });



    function checkDuplicateEmail(email) {
        fetch("CheckEmailServlet?email=" + encodeURIComponent(email))
                .then(response => response.text())
                .then(data => {
                    if (data === "EXISTS") {
                        alert("Email already exists.");
                        document.getElementById("email").focus();
                    }
                });
    }
</script>
