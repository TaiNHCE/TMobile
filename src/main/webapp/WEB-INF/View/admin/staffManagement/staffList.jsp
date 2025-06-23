
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="model.Staff"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Staff List</title>
        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Fontawesome CDN -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <!-- Sidebar CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css">

        <!-- Dashboard CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/staffList2.css">
    </head>
    <body>
        <div class="container">
            <jsp:include page="../sideBar.jsp" />
            <div class="wrapper">
                <main class="main-content">
                    <h1>Staff List</h1>

                    <!-- Create Button -->
                    <div class="d-flex justify-content-end mb-3">
                        <button class="btn btn-success" onclick="location.href = 'CreateStaffServlet'">Create</button>
                    </div>

                    <!-- Search Form -->
                    <form class="d-flex mb-4" action="StaffList" method="get">
                        <input type="hidden" name="action" value="search">
                        <input type="text" name="keyword" class="form-control me-2" placeholder="Search staff by name">
                        <button type="submit" class="btn btn-primary">Search</button>
                    </form>

                    <!-- Staff Table -->
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Staff ID</th>
                                <th>Email</th>
                                <th>Full Name</th>
                                <th>Hired Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Staff> staList = (List<Staff>) request.getAttribute("staff");
                                if (staList != null && !staList.isEmpty()) {
                                    for (Staff sta : staList) {
                            %>
                            <tr>
                                <td><%= sta.getStaffID()%></td>
                                <td><%= sta.getEmail()%></td>
                                <td><%= sta.getFullName()%></td>
                                <td><%= sta.getHiredDate()%></td>
                                <td>
                                    <a href="StaffList?action=detail&id=<%= sta.getStaffID()%>" class="btn btn-primary btn-sm">Detail</a>
                                    <a href="UpdateStaffServlet?action=update&id=<%= sta.getStaffID()%>" class="btn btn-warning btn-sm">Update</a>
                                    <a href="DeleteStaffServlet?action=delete&id=<%= sta.getStaffID()%>" class="btn btn-danger btn-sm">Delete</a>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="5" class="text-center">No staff found!</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>

                    <!-- Optional message -->
                    <%
                        String mes = (String) request.getAttribute("message");
                        if (mes != null) {
                    %>
                    <div class="alert alert-info mt-3"><%= mes%></div>
                    <%
                        }
                    %>
                </main>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
