<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Order List</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Sidebar & Shared Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList5.css" />

    <%
        NumberFormat currencyVN = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    %>
</head>
<body>
    <div class="container">
        <jsp:include page="../sideBar.jsp" />
        <div class="wrapper">
            <main class="main-content">
                <h1>Orders</h1>

                <!-- Search Form -->
                <form class="search-form" method="get" action="ViewOrderList">
                    <input type="text" name="search" placeholder="Search by Name, Phone..." value="${searchQuery}" />
                    <button type="submit" class="search-btn">Search</button>
                </form>

                <!-- Alert if message exists -->
                <c:if test="${not empty message}">
                    <div class="alert alert-danger">${message}</div>
                </c:if>

                <!-- Order Table -->
                <c:if test="${not empty orderList}">
                    <table>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer Name</th>
                                <th>Phone</th>
                                <th>Address</th>
                                <th>Total Amount</th>
                                <th>Order Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orderList}">
                                <tr>
                                    <td>#${order.orderID}</td>
                                    <td>${order.fullName}</td>
                                    <td>${order.phone}</td>
                                    <td>${order.address}</td>
                                    <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" /></td>
                                    <td>${order.orderDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status == 1}">
                                                <span class="status-inactive">Waiting</span>
                                            </c:when>
                                            <c:when test="${order.status == 2}">
                                                <span class="status-inactive">Packaging</span>
                                            </c:when>
                                            <c:when test="${order.status == 3}">
                                                <span class="status-inactive">Awaiting Delivery</span>
                                            </c:when>
                                            <c:when test="${order.status == 4}">
                                                <span class="status-active">Delivered</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-inactive">Cancelled</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="text-center">
                                        <a href="ViewOrderDetail?orderID=${order.orderID}" class="btn btn-primary">
                                            Detail
                                        </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>

                <!-- If order list is empty -->
                <c:if test="${empty orderList}">
                    <div class="text-center">No orders found!</div>
                </c:if>
            </main>
        </div>
    </div>
</body>
</html>
