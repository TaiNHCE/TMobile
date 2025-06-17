<%-- 
    Document   : verify
    Created on : Jun 17, 2025, 12:53:27 PM
    Author     : pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify OTP</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f2f5;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .container {
                background-color: #fff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                width: 350px;
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            label, input {
                display: block;
                width: 100%;
                margin-top: 10px;
            }

            input[type="text"] {
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #ccc;
            }

            input[type="submit"] {
                margin-top: 20px;
                padding: 10px;
                background-color: #4CAF50;
                border: none;
                color: white;
                border-radius: 6px;
                cursor: pointer;
            }

            .error {
                color: red;
                text-align: center;
                margin-top: 10px;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <h2>Enter OTP</h2>
            <form method="post" action="Verify">
                <label for="otp">OTP Code:</label>
                <input type="text" id="otp" name="otp" required " placeholder="Enter 6-digit code" />
                <input type="submit" value="Verify" />
            </form>

            <%-- Hiển thị lỗi nếu có (ví dụ: OTP không đúng) --%>
            <%
                String error = request.getParameter("error");
                if (error != null) {
            %>
            <div class="error"><%= error%></div>
            <%
                }
            %>
        </div>
    </body>
</html>
