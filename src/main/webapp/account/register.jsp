<%-- 
    Document   : register
    Created on : Jun 14, 2025, 8:40:17 PM
    Author     : pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <body>
        <h2>Register New Account</h2>

        <form method="post" action="Register">
            <label>Phone:</label><br>
            <input type="number" name="phone" pattern="\\d{10,11}" required /><br><br>

            <label>Email:</label><br>
            <input type="email" name="email" required /><br><br>

            <label>Full Name:</label><br>
            <input type="text" name="fullName" required /><br><br>

            <label>Password:</label><br>
            <input type="password" name="password" required /><br><br>

            <label>Confirm Password:</label><br>
            <input type="password" name="confirmPassword" required /><br><br>

            <button type="submit">Register</button>
        </form>

        <p style="color: red;">
            <%= request.getAttribute("error") != null ? request.getAttribute("error") : ""%>
        </p>
    </body>
</html>

</html>
