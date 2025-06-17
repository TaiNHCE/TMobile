<%-- 
    Document   : supplierList
    Created on : Jun 13, 2025, 11:32:23 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Suppliers" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Supplier List</title>
        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Fontawesome CDN -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <!-- Sidebar CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css">

        <!-- Dashboard CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList4.css">

    </head>
    <body>
        <div class="container">
            <jsp:include page="../sideBar.jsp" />
            <div class="wrapper">
                <main class="main-content">
                    <h1>Suppliers</h1>
                    <button class="create-btn" onclick="location.href = 'CreateSupplier'">Create</button>
                    <form class="search-form" method="get" action="ViewSupplier">
                        <input
                            type="text"
                            name="searchName"
                            placeholder="Find by name ..."
                            value="<%= request.getParameter("searchName") != null ? request.getParameter("searchName") : ""%>"
                            />
                        <button type="submit" class="search-btn">Search</button>
                    </form>
                    <table aria-label="Suppliers table">
                        <thead>
                            <tr>
                                <th>Tax ID</th>
                                <th>Name</th>
                                <th>Phone Number</th>
                                <th>Email</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Suppliers> list = (List<Suppliers>) request.getAttribute("supplierList");
                                if (list != null && !list.isEmpty()) {
                                    for (Suppliers s : list) {
                                        String statusClass = (s.getActivate() == 1) ? "status-active" : "status-inactive";
                                        String statusText = (s.getActivate() == 1) ? "Active" : "Inactive";
                            %>
                            <tr>
                                <td><%= s.getTaxId()%></td>
                                <td><%= s.getName()%></td>
                                <td><%= s.getPhoneNumber()%></td>
                                <td><%= s.getEmail()%></td>
                                <td><span class="<%= statusClass%>"><%= statusText%></span></td>
                                <td class="action-col">
                                    <a href="ViewSupplier?id=<%= s.getSupplierID()%>" class="btn-detail">Detail</a>
                                    <a href="UpdateSupplier?id=<%= s.getSupplierID()%>" class="btn-edit">Edit</a>

                                    <form action="DeleteSupplier" method="get" style="display:inline;">
                                        <input type="hidden" name="supplierID" value="<%= s.getSupplierID()%>"/>
                                        <input type="hidden" name="taxId" value="<%= s.getTaxId()%>"/>
                                        <button type="submit" class="btn-delete">Delete</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="7" class="text-center">No suppliers found!</td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </main>
            </div>
        </div>
    </body>
</html>
