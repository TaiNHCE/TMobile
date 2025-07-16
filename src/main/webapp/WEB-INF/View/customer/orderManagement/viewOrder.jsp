<%-- 
    Document   : viewOrder
    Created on : Jul 14, 2025, 1:35:04 PM
    Author     : VinhNTCE181630
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.Order"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>My Orders History</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                font-family: 'Segoe UI', sans-serif;
                
            }
            .order-card {
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
                padding: 25px 30px;
            }
            .order-header {
                font-weight: 700;
                font-size: 1.25rem;
                color: #333;
                margin-bottom: 15px;
            }
            .order-info th {
                width: 140px;
                color: #555;
                vertical-align: middle;
            }
            .order-info td {
                color: #333;
                font-weight: 500;
            }
            .badge {
                padding: 6px 12px;
                border-radius: 999px;
                font-size: 14px;
                font-weight: 600;
            }
            .status-1 {
                background-color: #f59e0b;
                color: #fff;
            } /* Waiting */
            .status-2 {
                background-color: #0d6efd;
                color: #fff;
            } /* Packaging */
            .status-3 {
                background-color: #6366f1;
                color: #fff;
            } /* Awaiting Delivery */
            .status-4 {
                background-color: #22c55e;
                color: #fff;
            } /* Delivered */
            .status-5 {
                background-color: #ef4444;
                color: #fff;
            } /* Cancelled */
            .action-buttons a,
            .action-buttons form {
                display: inline-block;
                margin-right: 10px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />


        <div class="container">
            <h2 class="mb-4">My Orders History</h2>

            <c:choose>
                <c:when test="${not empty orderList}">
                    <c:forEach var="order" items="${orderList}">
                        <div class="order-card">
                            <div class="order-header">
                                <i class="bi bi-receipt-cutoff me-2"></i> Order #${order.orderID}
                            </div>
                            <table class="table order-info">
                                <tr>
                                    <th>Date Update:</th>
                                    <td>${order.updatedDate}</td>
                                </tr>
                                <tr>
                                    <th>Date Order:</th>
                                    <td>${order.orderDate}</td>
                                </tr>
                                <tr>
                                    <th>Status:</th>
                                    <td>
                                        <span class="badge status-${order.status}">
                                            <c:choose>
                                                <c:when test="${order.status == 1}">Waiting</c:when>
                                                <c:when test="${order.status == 2}">Packaging</c:when>
                                                <c:when test="${order.status == 3}">Waiting for Delivery</c:when>
                                                <c:when test="${order.status == 4}">Delivered</c:when>
                                                <c:otherwise>Cancelled</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Total Amount:</th>
                                    <td><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" />₫</td>
                                </tr>
                                <tr>
                                    <th>Recipient:</th>
                                    <td>${order.fullName} - ${order.phone}</td>
                                </tr>
                                <tr>
                                    <th>Address:</th>
                                    <td>${order.addressSnapshot}</td>
                                </tr>
                            </table>

                            <!-- ✅ Bắt đầu sau </table> -->
                            <div class="action-buttons mt-3">
                                <a href="CustomerOrderDetail?orderID=${order.orderID}" class="btn btn-outline-primary">
                                    <i class="bi bi-eye"></i> View Detail
                                </a>

                                <c:if test="${order.status == 1}">
                                    <form action="CancelOrder" method="POST" onsubmit="return confirm('Are you sure you want to cancel this order?')">
                                        <input type="hidden" name="orderID" value="${order.orderID}" />
                                        <button type="submit" class="btn btn-outline-danger">
                                            <i class="bi bi-x-circle"></i> Cancel Order
                                        </button>
                                    </form>
                                </c:if>
                            </div>

                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info">You haven't placed any orders yet.</div>
                </c:otherwise>
            </c:choose>
        </div>
        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>