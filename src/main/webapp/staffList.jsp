<%-- 
    Document   : staffList
    Created on : Jun 12, 2025, 2:03:46 PM
    Author     : pc
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="model.Staff"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
        <h2>Staff List List</h2>
        <a href="StaffList?action=create" class="btn btn-primary">Create Staff</a>
        <div class="container">
            <table class="table table-striped table-hover">
                    <th>ID</th>
                    <th>Email</th>
                    <th>Full Name</th>
                    <th>Hired Date</th>
                    <th>Action</th>
                </tr>
                <%
                    List<Staff> staList = (List<Staff>) request.getAttribute("staff");
                    for (Staff sta : staList) {
                %>
                <tr>
                    <td><%= sta.getStaffID()%></td>
                    <td><%= sta.getEmail()%></td>
                    <td><%= sta.getFullName()%></td>
                    <td><%= sta.getHiredDate()%></td>
                    <%
                        Date createdAt = sta.getHiredDate();
                        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                        String formattedDate = sdf.format(createdAt);
                    %>
                    <td><%= formattedDate%></td>
                    <td>
                        <a href="StaffList?action=edit&id=<%= sta.getStaffID()%>" class="btn btn-primary">Edit</a>
                        
                        <a href="CustomerList?action=detail&id=<%= sta.getStaffID()%>" class="btn btn-info">Detail</a>
                        <a href="CustomerList?action=delete&id=<%= sta.getStaffID()%>" class="btn btn-danger">Delete</a>
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
