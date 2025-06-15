<%-- 
    Document   : view-staff-detail
    Created on : Jun 12, 2025, 10:01:59 PM
    Author     : pc
--%>

<%@page import="model.Staff"%>
<%

    Staff sta = (Staff) request.getAttribute("data");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <title>Staff detail</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
        <% if (sta == null) {
                out.print("<p>There is no customer with that id</p>");
            } else {
        %>
        <h2>Staff's information</h2>
        <form method="post" action="CustomerList?action=detail">
            <div class="mb-3">
                <label class="form-label">Full Name: </label>
                <input type="text" class="form-control" name="fullname" id="fullname" required value="<%= sta.getFullName()%>" readonly />
            </div>
            <div class="mb-3">
                <label class="form-label">Phone Number:</label>
                <input type="number" class="form-control" name="phone" id="phone" required value="<%= sta.getPhone()%>" readonly />
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="text" class="form-control" name="email" id="email" required value="<%= sta.getEmail()%>" readonly />
            </div>
            <div class="mb-3">
                <label class="form-label">Date of Birth:</label>
                <input type="date"class="form-control" name="dob" id="dob" required value="<%= sta.getBirthDay()%>"readonly  />
            </div>
            <div class="mb-3">
                <label class="form-label">Sex</label><br/>
                <input type="radio" class="form-check-input" name="sex" value="male"
                       <%= ("male".equalsIgnoreCase(sta.getGender()) ? "checked" : "")%> disabled/> Male
                <input type="radio" class="form-check-input" name="sex" value="female"
                       <%= ("female".equalsIgnoreCase(sta.getGender()) ? "checked" : "")%> disabled/> Female
            </div>
            <a href="ChangePassword" class="btn btn-secondary" ><i class="bi bi-tools"></i> Change Password</a>
            <a href="CustomerList" class="btn btn-primary" id="back"><i class="bi bi-arrow-return-left"></i> Back</a>
        </form>
        <%
            }
        %>
    </body>
</html>
