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

        <style>
            body {
                background-color: #f4f6fb;
                font-family: 'Segoe UI', sans-serif;
            }

            .status-1 {
                background-color: #f59e0b;
            }     /* Waiting */
            .status-2 {
                background-color: #0d6efd;
            }     /* Packaging */
            .status-3 {
                background-color: #6366f1;
            }     /* Waiting for Delivery */
            .status-4 {
                background-color: #22c55e;
            }     /* Delivered */
            .status-5 {
                background-color: #ef4444;
            }     /* Cancelled */

            .badge {
                padding: 6px 12px;
                border-radius: 999px;
                font-weight: 600;
                color: #fff;
                font-size: 14px;
            }

            .search-form {
                margin-bottom: 20px;
                display: flex;
                gap: 10px;
            }

            .search-form input[type="text"] {
                flex: 1;
            }

            .search-btn {
                border-radius: 8px;
                font-weight: 600;
                padding: 6px 16px;
            }

            table {
                width: 100%;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <jsp:include page="../sideBar.jsp" />
            <div class="wrapper">
                <main class="main-content">
                    <jsp:include page="../header.jsp" />

                    <h1>Orders</h1>
                                                        <button class="create-btn" style="float: right; margin-bottom: 7.5px; visibility: hidden;">+ New Import</button>


                    <!-- Search Form -->
                    <form class="search-form" method="get" action="ViewOrderList">
                        <input
                            type="text"
                            name="search"
                            class="form-control"
                            placeholder="Search by Name, Phone..."
                            value="${searchQuery}"
                            />
                        <button type="submit" class="btn btn-primary search-btn">Search</button>
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
                                    <th scope="col">Order ID</th>
                                    <th scope="col">Customer Name</th>
                                    <th scope="col">Phone</th>
                                    <th scope="col">Address</th>
                                    <th scope="col">Total Amount</th>
                                    <th scope="col">Order Date</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orderList}">
                                    <tr>
                                        <td>#${order.orderID}</td>
                                        <td>${order.fullName}</td>
                                        <td>${order.phone}</td>
                                        <td>${order.addressSnapshot}</td>
                                        <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" /></td>
                                        <td>${order.orderDate}</td>
                                        <td>
                                            <span class="badge status-${order.status}">
                                                <c:choose>
                                                    <c:when test="${order.status == 1}">Waiting</c:when>
                                                    <c:when test="${order.status == 2}">Packaging</c:when>
                                                    <c:when test="${order.status == 3}">Awaiting Delivery</c:when>
                                                    <c:when test="${order.status == 4}">Delivered</c:when>
                                                    <c:otherwise>Cancelled</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <a href="ViewOrderDetail?orderID=${order.orderID}" class="btn btn-primary btn-sm">
                                                Detail
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>

                    <!-- If order list is empty -->
                    <c:if test="${empty orderList}">
                        <div class="text-center mt-3">No orders found!</div>
                    </c:if>
                </main>
            </div>
        </div>

        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
        %>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            window.onload = function () {
            <% if ("update".equals(success)) { %>
                Swal.fire({
                    icon: 'success',
                    title: 'Update Successful!',
                    text: 'The order status has been updated.',
                    timer: 3000,
                    confirmButtonText: 'OK'
                });
            <% } else if ("1".equals(error)) { %>
                Swal.fire({
                    icon: 'error',
                    title: 'Error!',
                    text: 'Unable to update the order status.',
                    timer: 3000,
                    confirmButtonText: 'Try Again'
                });
            <% }%>
            };
        </script>

    </body>
</html>
