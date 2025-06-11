<%-- 
    Document   : view-customer-detail.jsp
    Created on : Jun 10, 2025, 2:40:25 PM
    Author     : pc
--%>
<%@page import="java.util.List"%>
<%@page import="model.Customer"%>
<%

    Customer custo = (Customer) request.getAttribute("data");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer detail</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
        <% if (custo == null) {
                out.print("<p>There is no customer with that id</p>");
            } else {
        %>
        <form method="post" action="CustomerList?action=detail">
            <div class="mb-3">
                <label class="form-label">Full Name: </label>
                <input type="text" class="form-control" name="fullname" id="fullname" required value="<%= custo.getFullName()%>" readonly />
            </div>
            <div class="mb-3">
                <label class="form-label">Phone Number:</label>
                <input type="number" class="form-control" name="phone" id="phone" required value="<%= custo.getPhone()%>" readonly />
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="text" class="form-control" name="email" id="email" required value="<%= custo.getEmail()%>" readonly />
            </div>
            <div class="mb-3">
                <label class="form-label">Date of Birth:</label>
                <input type="date"class="form-control" name="dob" id="dob" required value="<%= custo.getBirthDay()%>"readonly  />
            </div>
            <div class="mb-3">
                <label class="form-label">Sex</label><br/>
                <input type="radio" class="form-check-input" name="sex" value="male"
                       <%= ("male".equalsIgnoreCase(custo.getGender()) ? "checked" : "")%> disabled/> Male
                <input type="radio" class="form-check-input" name="sex" value="female"
                       <%= ("female".equalsIgnoreCase(custo.getGender()) ? "checked" : "")%> disabled/> Female
            </div>
            <a href="CustomerList" class="btn btn-secondary" id="back"><i class="bi bi-arrow-return-left"></i> Change Status</a>
            <button type="submit" class="btn btn-primary" id="submit"><i class="bi bi-tools"></i> Back</button>
        </form>
        <%
            }
        %>
    </body>
</html>
