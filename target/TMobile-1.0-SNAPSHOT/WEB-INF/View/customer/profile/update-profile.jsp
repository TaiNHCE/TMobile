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
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierLists5.css">
    </head>
    <body>
        <div class="container mt-5">
            <div class="card mx-auto shadow" style="max-width: 700px;">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Profile</h4>
                </div>
        <form method="post" action="UpdateProfile">
             <% if (cus == null) {
                out.print("<p>There is no customer with that id</p>");
            } else {
        %>
            <input type="hidden" name="id" value="<%= cus.getId()%>">

            <label>Full Name:</label>
            <input type="text" name="fullname" value="<%= cus.getFullName()%>" class="form-control">

            <label>Phone Number:</label>
            <input type="text" name="phone" value="<%= cus.getPhone()%>" class="form-control">

            <label>Date of Birth:</label>
            <input type="date" name="dob" value="<%= cus.getBirthDay()%>" class="form-control">

            <label>Gender:</label><br>
            <input type="radio" name="gender" value="male" <%= "male".equalsIgnoreCase(cus.getGender()) ? "checked" : ""%>> Male
            <input type="radio" name="gender" value="female" <%= "female".equalsIgnoreCase(cus.getGender()) ? "checked" : ""%>> Female

            <br><br>
            <input type="submit" value="Update" class="btn btn-primary">
        </form>
            </div><!-- comment -->
        </div>
            <%
                }
                %>
    </body>
</html>
