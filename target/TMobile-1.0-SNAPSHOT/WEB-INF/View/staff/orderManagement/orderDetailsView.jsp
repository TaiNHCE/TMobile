<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Order Details</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap & FontAwesome -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

        <!-- Custom Style (reuse supplierList5.css) -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList5.css" />
        <style>
            body {
                background-color: #f4f6fb;
                font-family: 'Segoe UI', sans-serif;
            }

            h2 {
                color: #232946;
                font-weight: 800;
                font-size: 2.2rem;
                margin: 24px 0 18px 0;
            }

            .main-layout {
                display: flex;
                flex-direction: column;
                gap: 24px;
                padding: 0 24px;
            }

            .order-layout {
                display: flex;
                gap: 24px;
                flex-wrap: wrap;
            }

            .left-section, .right-section, .manage-order {
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 4px 18px rgba(0, 0, 0, 0.07);
                padding: 20px 24px;
                flex: 1;
                min-width: 320px;
            }

            .order-info p, .customer-info p {
                margin: 8px 0;
            }

            .order-details div {
                padding: 10px;
                border-bottom: 1px solid #eee;
                display: flex;
                gap: 16px;
                align-items: center;
            }

            .order-details span i {
                margin-right: 6px;
            }

            .btn {
                font-weight: 600;
                border-radius: 8px;
            }

            .btn-success {
                background-color: #22c55e;
                border-color: #22c55e;
            }

            .btn-secondary {
                background-color: #6c757d;
                color: white;
                margin-top: 14px;
            }

            .status-1, .status-2, .status-3, .status-4, .status-5 {
                padding: 6px 14px;
                border-radius: 999px;
                font-weight: 600;
                color: white;
                font-size: 14px;
            }

            .status-1 {
                background: #f59e0b;
            }     /* Waiting */
            .status-2 {
                background: #0d6efd;
            }     /* Packaging */
            .status-3 {
                background: #6366f1;
            }     /* Waiting for Delivery */
            .status-4 {
                background: #22c55e;
            }     /* Delivered */
            .status-5 {
                background: #ef4444;
            }     /* Cancel */

            select {
                border-radius: 8px;
                padding: 8px 12px;
                border: 1.5px solid #ccc;
                margin-right: 12px;
            }

            .alert-danger {
                margin-top: 10px;
            }

            h3 {
                color: #232946;
                font-size: 18px;
                margin-top: 16px;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <jsp:include page="../sideBar.jsp" />
            <div class="wrapper">
                <h1>Order Details</h1>
                <div class="main-layout">

                    <div class="order-layout">
                        <!-- Left Column -->
                        <div class="left-section">
                            <div class="order-info">
                                <h3><i class="fa-solid fa-info-circle"></i> Order Information</h3>
                                <p><strong>Order ID:</strong> ${data.orderID}</p>
                                <p><strong>Order Date:</strong> ${data.orderDate}</p>
                                <p><strong>Order Status:</strong> 
                                    <span class="status-${data.status}">
                                        <c:if test="${data.status == 1}">Waiting</c:if>
                                        <c:if test="${data.status == 2}">Packaging</c:if>
                                        <c:if test="${data.status == 3}">Waiting for Delivery</c:if>
                                        <c:if test="${data.status == 4}">Delivered</c:if>
                                        <c:if test="${data.status == 5}">Cancelled</c:if>
                                        </span>
                                    </p>
                                    <p><strong>Total Amount:</strong> ${data.totalAmount}</p>
                                <p><strong>Discount:</strong> ${data.discount}</p>
                            </div>

                            <h3><i class="fa-solid fa-box"></i> Order Items</h3>
                            <div class="order-details">
                                <c:forEach items="${dataDetail}" var="detail">
                                    <div>
                                        <span><i class="fa-solid fa-cube"></i> ${detail.productName}</span>
                                        <span><i class="fa-solid fa-cart-plus"></i> ${detail.quantity}</span>
                                        <span><i class="fa-solid fa-dollar-sign"></i> ${detail.price}</span>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Right Column -->
                        <div class="right-section">
                            <div class="customer-info">
                                <h3><i class="fa-solid fa-user"></i> Customer Information</h3>
                                <p><strong>Name:</strong> ${data.fullName}</p>
                                <p><strong>Phone:</strong> ${data.phone}</p>
                                <p><strong>Address:</strong> ${data.address}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Manage Order -->
                    <div class="manage-order">
                        <h3><i class="fa-solid fa-cogs"></i> Manage Order</h3>

                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger">${errorMessage}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/UpdateOrder" method="POST" class="d-flex align-items-center gap-3 flex-wrap">
                            <input type="hidden" name="orderID" value="${data.orderID}" />

                            <select name="update" id="orderStatus" class="form-select w-auto">
                                <option value="1" <c:if test="${data.status == 1}">selected</c:if>>Waiting</option>
                                <option value="2" <c:if test="${data.status == 2}">selected</c:if>>Packaging</option>
                                <option value="3" <c:if test="${data.status == 3}">selected</c:if>>Waiting for Delivery</option>
                                <option value="4" <c:if test="${data.status == 4}">selected</c:if>>Delivered</option>
                                <option value="5" <c:if test="${data.status == 5}">selected</c:if>>Cancelled</option>
                                </select>

                                <button type="submit" class="btn btn-success">
                                    Update
                                </button>

                                <a href="${pageContext.request.contextPath}/ViewOrderList" class="btn btn-secondary">
                                Back
                            </a>
                        </form>
                    </div>
                </div>
            </div>
        </div>





        <!-- JavaScript -->
        <!--<script>
            function disableOptions() {
                const status = document.getElementById('orderStatus').value; // Lấy giá trị trạng thái đã chọn
                const options = document.getElementById('orderStatus').options;
        
                // Đảm bảo tất cả các tùy chọn đều được kích hoạt lại trước khi disable lại
                for (let i = 0; i < options.length; i++) {
                    options[i].disabled = false;
                }
        
                // Disable các trạng thái không hợp lệ
                if (status === '3') { // Waiting For Delivery
                    options[0].disabled = true; // Không thể chọn 'Waiting For Acceptance'
                    options[1].disabled = true; // Không thể chọn 'Packaging'
                    options[4].disabled = true; // Không thể chọn 'Cancel'
                } else if (status === '2') { // Packaging
                    options[0].disabled = true; // Không thể chọn 'Waiting For Acceptance'
                    options[4].disabled = true; // Không thể chọn 'Cancel'
                } else if (status === '4') { // Delivered
                    options[0].disabled = true; // Không thể chọn 'Waiting For Acceptance'
                    options[1].disabled = true; // Không thể chọn 'Packaging'
                    options[2].disabled = true; // Không thể chọn 'Waiting For Delivery'
                    options[4].disabled = true; // Không thể chọn 'Cancel'
                } else if (status === '5') { // Cancel
                    options[0].disabled = true; // Không thể chọn 'Waiting For Acceptance'
                    options[1].disabled = true; // Không thể chọn 'Packaging'
                    options[2].disabled = true; // Không thể chọn 'Waiting For Delivery'
                    options[3].disabled = true; // Không thể chọn 'Delivered'
                }
            }
        
        // Gọi disableOptions() khi trang tải
            document.addEventListener('DOMContentLoaded', function () {
                disableOptions();
            });
        
        
        </script>-->
    </body>
</html>
