<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product List</title>
        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Fontawesome CDN -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <!-- Sidebar CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList5.css">
        <!-- SweetAlert2 CDN -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            .create-btn-placeholder {
                height: 38px;
                min-width: 110px;
                margin-bottom: 12px;
                float: right;
                display: inline-block;
            }
            /* Đảm bảo header hiển thị */
            header, .navbar {
                display: block !important;
                visibility: visible !important;
                height: auto !important;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <jsp:include page="/WEB-INF/View/staff/sideBar.jsp" />

            <div class="wrapper">
                <main class="main-content">
                    <jsp:include page="/WEB-INF/View/staff/header.jsp" />

                    <h1>Product List</h1>
                    <div class="create-btn-placeholder"></div> 

                    <!-- Search Form -->
                    <form class="search-form" action="ProductListForStaff" method="get">
                        <input type="hidden" name="action" value="search">
                        <input type="text" name="keyword" class="form-control" placeholder="Search product by name">
                        <button type="submit" class="search-btn">Search</button>
                    </form>

                    <!-- Product Table -->
                    <table aria-label="Product table">
                        <thead>
                            <tr>
                                <th>Product ID</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Stock</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty products and !products.isEmpty()}">
                                    <c:forEach items="${products}" var="product">
                                        <tr>
                                            <td>${product.productId}</td>
                                            <td>${product.productName}</td>
                                            <td><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/></td>
                                            <td>${product.stock}</td>
                                            <td class="action-col">
                                                <a href="ProductListForStaffDetail?productId=${product.productId}" class="btn btn-primary">Detail</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center">No products found!</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <!-- Optional message -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-info mt-3">${message}</div>
                    </c:if>
                </main>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>