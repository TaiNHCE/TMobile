<%-- 
    Document   : customerList
    Created on : Jun 9, 2025, 1:21:22 PM
    Author     : pc
--%>

<%@page import="java.util.List"%>
<%@page import="model.Customer"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
        <h2>Customer List</h2>
        <div class="container">
            <table class="table table-striped table-hover">
                    <th>ID</th>
                    <th>Email</th>
                    <th>Full Name</th>
                    <th>Phone</th>
                    <th>Created At</th>
                    <th>Is Active</th>
                    <th>Action</th>
                </tr>
                <%
                    List<Customer> cusList = (List<Customer>) request.getAttribute("userList");
                    for (Customer cus : cusList) {
                %>
                <tr>
                    <td><%= cus.getId()%></td>
                    <td><%= cus.getEmail()%></td>
                    <td><%= cus.getFullName()%></td>
                    <td><%= cus.getPhone()%></td>
                    <%
                        Date createdAt = cus.getCreateAt();
                        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                        String formattedDate = sdf.format(createdAt);
                    %>
                    <td><%= formattedDate%></td>
                    <td><%= cus.isActive() ? "Yes" : "No"%></td>
                    <td>
                        <a href="CustomerList?action=edit" class="btn btn-primary">Edit</a>
                        
                        <a href="CustomerList?action=detail&id=<%= cus.getId()%>" class="btn btn-info">Detail</a>
                    </td>
                </tr>
                <%
                } // đóng vòng lặp ở đúng chỗ
%>
            </table>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
