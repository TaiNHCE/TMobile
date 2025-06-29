<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Order" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
    <head>
        <title>Order List</title>
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
            }

            th, td {
                border: 1px solid #ccc;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #f5f5f5;
            }

            .btn-view {
                background-color: #007bff;
                color: white;
                padding: 6px 12px;
                border: none;
                border-radius: 4px;
                text-decoration: none;
            }

            .btn-view:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>

        <h2>Order List</h2>

        <c:if test="${not empty message}">
            <p style="color: red;">${message}</p>
        </c:if>

        <c:if test="${not empty orderList}">
            <form action="${pageContext.request.contextPath}/ViewOrderList" method="GET"
                  class="search-container">
                <input type="text" name="search" id="searchInput" value="${searchQuery}" 
                       placeholder="Search by Name, Phone..." class="search-input">
                <button type="submit" class="search-button">
                    🔍
                </button>
            </form>
            <br/>

            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Customer Name</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Total Amount</th>
                    <th>Order Date</th>
                    <th>Status</th>
                </tr>
                <c:forEach var="order" items="${orderList}">
                    <tr>
                        <td>#${order.orderID}</td>
                        <td>${order.fullName}</td>
                        <td>${order.phone}</td>
                        <td>${order.address}</td>
                        <td>${order.totalAmount}</td>
                        <td>${order.orderDate}</td>
                        <td class="order-status">
                            <c:choose>
                                <c:when test="${order.status == 1}">
                                    <span class="status waiting">
                                        <i class="fa-solid fa-hourglass-half"></i> Waiting For Acceptance
                                    </span>
                                </c:when>
                                <c:when test="${order.status == 2}">
                                    <span class="status packaging">
                                        <i class="fa-solid fa-box"></i> Packaging
                                    </span>
                                </c:when>
                                <c:when test="${order.status == 3}">
                                    <span class="status waiting-delivery">
                                        <i class="fa-solid fa-truck"></i> Waiting For Delivery
                                    </span>
                                </c:when>
                                <c:when test="${order.status == 4}">
                                    <span class="status delivered">
                                        <i class="fa-solid fa-check-circle"></i> Delivered
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status cancelled">
                                        <i class="fa-solid fa-times-circle"></i> Cancelled
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="d-flex gap-2">
                                <a href="ViewOrderDetail?orderID=${order.orderID}" class="btn btn-outline-info btn-sm">
                                    <i class="fa-solid fa-eye"></i> View Details
                                </a>

                            </div>

                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>

        <c:if test="${empty orderList}">
            <form action="${pageContext.request.contextPath}/ViewOrderList" method="GET"
                  class="search-container">
                <input type="text" name="search" id="searchInput" value="${searchQuery}" 
                       placeholder="Search by Name, Phone..." class="search-input">
                <button type="submit" class="search-button">
                    🔍
                </button>
            </form>

            <p>No orders available.</p>
        </c:if>
    </body>
</html>
