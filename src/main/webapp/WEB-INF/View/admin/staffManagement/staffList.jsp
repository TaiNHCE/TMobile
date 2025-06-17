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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <!-- Fontawesome CDN -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <!-- Sidebar CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css">

        <!-- Dashboard CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/staffList.css">
    </head>
    <body>
        <h2>Staff List</h2>
        <div class="container mt-4">
            <jsp:include page="../sideBar.jsp" />
            <form action="StaffList" method="get" class="row g-3">
                <div class="col-auto">
                    <input type="text" name="keyword" class="form-control" placeholder="Search staff by name">
                </div>
                <div class="col-auto">
                    <input type="hidden" name="action" value="search">
                    <button type="submit" class="btn btn-primary mb-3">Search</button>
                </div>
            </form>
        </div>
        <a href="StaffList?action=create" class="btn btn-primary">Create Staff</a>
        <div class="container">
            <table class="table table-striped table-hover">
                <th>Staff ID</th>
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
                    <td>
                        <a href="StaffList?action=edit&id=<%= sta.getStaffID()%>" class="btn btn-primary">Edit</a>

                        <a href="StaffList?action=detail&id=<%= sta.getStaffID()%>" class="btn btn-info">Detail</a>
                        <a href="StaffList?action=delete&id=<%= sta.getStaffID()%>" class="btn btn-danger">Delete</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
            <%
                String mes = (String) request.getAttribute("message");
                if (mes != null) {
                    out.println(mes);
                }
            %>
        </div>
    </body>
</html>
