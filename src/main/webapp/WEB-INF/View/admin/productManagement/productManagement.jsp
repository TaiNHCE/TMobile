<%-- 
    Document   : ManagementProductAdmin
    Created on : Jun 19, 2025
    Author     : [Your Name]
--%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Sidebar CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/ProductManagementForAdmin.css">
    </head>
    <body>
        <div class="container">
            <jsp:include page="../sideBar.jsp" />

            <h1>Product Management</h1>

            <!-- Search bar -->
            <form action="ProductList" method="get">
                <div class="search-container">
                    <input type="text" name="keyword" class="form-control" placeholder="Search products by name" value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : ""%>">
                    <input type="hidden" name="action" value="search">
                    <button type="submit" class="btn">Search</button>
                </div>
            </form>

            <!-- Product list table -->
            <div class="table-container">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Discount (%)</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Product> productList = (List<Product>) request.getAttribute("products");
                            if (productList != null) {
                                for (Product product : productList) {
                        %>
                        <tr>
                            <td><%= product.getProductId()%></td>
                            <td><%= product.getProductName()%></td>
                            <td><%= String.format("%,.0f", product.getPrice())%></td>
                            <td><%= product.getDiscount()%></td>
                            <td>
                                <%= product.isIsActive() ? "<span class='badge bg-success'>Activated</span>" : "<span class='badge bg-warning'>Not Activated</span>"%>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <!-- View Details -->
                                    <a href="ProductList?action=detail&id=<%= product.getProductId()%>" class="btn btn-info btn-sm" title="View Details">
                                        <i class="fas fa-eye"></i> Detail
                                    </a>

                                    <!-- Activate Product (Only show if product is NOT active) -->
                                    <% if (!product.isIsActive()) {%>
                                    <form action="ActivateProductServlet" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to ACTIVATE this product?');">
                                        <input type="hidden" name="productId" value="<%= product.getProductId()%>">
                                        <button type="submit" class="btn btn-success btn-sm" title="Activate Product">
                                            <i class="fas fa-check"></i> Activate
                                        </button>
                                    </form>
                                    <% }%>

                                    <!-- Reject Product -->
                                    <form action="RejectProductServlet" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to REJECT this product?');">
                                        <input type="hidden" name="productId" value="<%= product.getProductId()%>">
                                        <button type="submit" class="btn btn-danger btn-sm" title="Reject Product">
                                            <i class="fas fa-times"></i> Reject
                                        </button>
                                    </form>

                                    <!-- Set Discount -->
                                    <form action="setPromotion" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="setDiscount">
                                        <input type="hidden" name="productId" value="<%= product.getProductId()%>">
                                        <button type="submit" class="btn btn-primary btn-sm" title="Set Discount">
                                            <i class="fas fa-tags"></i> Discount
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <!-- Notification -->
            <%
                String message = (String) request.getAttribute("message");
                if (message != null) {
                    out.println("<div class='alert alert-info'>" + message + "</div>");
                }
            %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>