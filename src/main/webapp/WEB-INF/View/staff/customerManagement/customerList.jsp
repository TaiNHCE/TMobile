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
        <div class="container mt-4">
            <form action="CustomerList" method="get" class="row g-3">
                <div class="col-auto">
                    <input type="text" name="keyword" class="form-control" placeholder="Search customer by name">
                </div>
                <div class="col-auto">
                    <input type="hidden" name="action" value="search">
                    <button type="submit" class="btn btn-primary mb-3">Search</button>
                </div>
            </form>
        </div>
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
                        <a href="CustomerList?action=changeStatus&id=<%= cus.getId()%>"
                           class="btn btn-primary"
                           onclick="return confirmStatusChange(<%= cus.isActive()%>, '<%= cus.getFullName().replace("'", "\\'")%>')">
                            Change Status
                        </a>
                        <a href="CustomerList?action=detail&id=<%= cus.getId()%>" class="btn btn-info">Detail</a>
                         <a href="CustomerList?action=orderhistory&id=<%= cus.getId()%>" class="btn btn-success">Order History</a>
                    </td>
                </tr>
                <%
                    } 
                %>
            </table>
            <%
                String error = (String) request.getAttribute("error");
                if (error != null && !error.isEmpty()) {
            %>
            <div class="container">
                <div class="alert alert-danger" role="alert">
                    <%= error%>
                </div>
            </div>
            <%
                }
            %>

        </div>
        <script>
            function confirmStatusChange(currentStatus, fullName) {
                const action = currentStatus ? "block" : "unblock";
                return confirm("Are you sure you want to " + action + " user \"" + fullName + "\"?");
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
