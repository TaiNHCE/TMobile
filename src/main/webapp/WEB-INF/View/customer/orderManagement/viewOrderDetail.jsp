<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Detail</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                font-family: 'Segoe UI', sans-serif;
            }
            .order-detail-card {
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                padding: 30px;
                margin-bottom: 30px;
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
                } /* Waiting for Delivery */
                .status-4 {
                    background-color: #22c55e;
                    color: #fff;
                } /* Delivered */
                .status-5 {
                    background-color: #ef4444;
                    color: #fff;
                } /* Cancelled */
            }
            .order-header {
                font-size: 1.5rem;
                font-weight: 700;
                margin-bottom: 20px;
            }
            .detail-table th {
                background-color: #f8f9fa;
                text-align: center;
                vertical-align: middle;
            }
            .detail-table td {
                vertical-align: middle;
                text-align: center;
            }
            .back-link {
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

        <div class="container">
            <div class="order-detail-card">
                <c:choose>
                    <c:when test="${not empty orderList}">
                        <c:forEach var="order" items="${orderList}">
                            <div class="order-header">
                                 Order #${data.orderID} Detail
                            </div>

                            <div class="mb-4">
                                <p><strong>Order Date:</strong> ${data.orderDate}</p>
                                <p><strong>Updated At:</strong> ${data.updatedDate}</p>
                                <p><strong>Status:</strong>
                                    <span class="badge status-${order.status}">
                                        <c:choose>
                                            <c:when test="${order.status == 1}">Waiting</c:when>
                                            <c:when test="${order.status == 2}">Packaging</c:when>
                                            <c:when test="${order.status == 3}">Waiting for Delivery</c:when>
                                            <c:when test="${order.status == 4}">Delivered</c:when>
                                            <c:otherwise>Cancelled</c:otherwise>
                                        </c:choose>
                                    </span>

                                </p>
                                <p><strong>Recipient:</strong> ${data.fullName} - ${data.phone}</p>
                                <p><strong>Address:</strong> ${data.addressSnapshot}</p>
                                <p><strong>Total Amount:</strong>
                                    <fmt:formatNumber value="${data.totalAmount}" type="number" groupingUsed="true"/>₫
                                </p>
                            </div>

                            <h5 class="mb-3"><i class="bi bi-box-seam me-1"></i> Products</h5>
                            <table class="table table-bordered detail-table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Product Name</th>
                                        <th>Category</th>
                                        <th>Quantity</th>
                                        <th>Price (₫)</th>
                                        <th>Subtotal (₫)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${dataDetail}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>${item.productName}</td>
                                            <td>${item.category}</td>
                                            <td>${item.quantity}</td>
                                            <td><fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/></td>
                                            <td>
                                                <fmt:formatNumber value="${item.price * item.quantity}" type="number" groupingUsed="true"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:forEach>
                            </c:when>

                        </c:choose>
                    </tbody>
                </table>

                <a href="javascript:history.back()" class="btn btn-outline-secondary back-link">
                    <i class="bi bi-arrow-left"></i> Back to Orders
                </a>
            </div>
        </div>

        <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
