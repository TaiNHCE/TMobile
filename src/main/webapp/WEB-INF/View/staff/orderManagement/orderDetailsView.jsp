<%@ page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html> 
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Details</title>



        <!-- Custom CSS -->
        <link rel="stylesheet" href="assets/css/orderDetail.css">


    </head>
    <body>

        <h2><i class="fa-solid fa-receipt"></i> Order Details</h2>
    </div>

    <div class="main-layout">         
        <div class="main-content">
            <div class="container">
                <div class="order-layout">
                    <!-- Left: Order Information & Items -->
                    <div class="left-section">
                        <div class="order-info">
                            <h3><i class="fa-solid fa-info-circle"></i> Order Information</h3>
                            <p><strong>Order ID:</strong> <span>${data.orderID}</span></p>
                            <p><strong>Order Date:</strong> <span>${data.orderDate}</span></p>
                            <p><strong>Order Status:</strong> <span class="status-${data.status}">
                                    <c:if test="${data.status == 1}">Waiting For Acceptance</c:if>
                                    <c:if test="${data.status == 2}">Packaging</c:if>
                                    <c:if test="${data.status == 3}">Waiting For Delivery</c:if>
                                    <c:if test="${data.status == 4}">Delivered</c:if>
                                    <c:if test="${data.status == 5}">Cancel</c:if>
                                    </span></p>
                                <p><strong>Total Amount:</strong> <span>${data.totalAmount}</span></p>
                            <p><strong>Discount:</strong> <span>${data.discount}</span></p>
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
                        <c:forEach var="status" items="${statusList}">
                            <li>${status.statusID} - ${status.statusName}</li>
                            </c:forEach>

                    </div>

                    <!-- Right: Customer Info & Manage Order -->
                    <div class="right-section">
                        <div class="customer-info">
                            <h3><i class="fa-solid fa-user"></i> Customer Information</h3>
                            <p><strong>Name:</strong> <span>${data.fullName}</span></p>
                            <p><strong>Phone:</strong> <span>${data.phone}</span></p>
                            <p><strong>Address:</strong> <span>${data.address}</span></p>
                        </div>
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger">
                                ${errorMessage}
                            </div>
                        </c:if>
                    </div>



                    <div class="manage-order">
                        <h3><i class="fa-solid fa-cogs"></i> Manage Order</h3>
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger">
                                ${errorMessage}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/UpdateOrder" method="POST">

                            <input type="hidden" name="orderID" value="${data.orderID}" />
                            <select name="update" id="orderStatus">
                                <option value="1" <c:if test="${data.status == 1}">selected</c:if>>Waiting For Acceptance</option>
                                <option value="2" <c:if test="${data.status == 2}">selected</c:if>>Packaging</option>
                                <option value="3" <c:if test="${data.status == 3}">selected</c:if>>Waiting For Delivery</option>
                                <option value="4" <c:if test="${data.status == 4}">selected</c:if>>Delivered</option>
                                <option value="5" <c:if test="${data.status == 5}">selected</c:if>>Cancel</option>
                                </select>
                                <button type="submit" class="btn btn-success"><i class="fa-solid fa-pen"></i> Update</button>
                            </form>
                           <a href="${pageContext.request.contextPath}/ViewOrderList" 
                           class="btn btn-secondary"
                           style="margin-bottom: 20px; display: inline-block; background-color: #6c757d; color: white; padding: 8px 12px; text-decoration: none; border-radius: 5px;">
                            ← Back to Order List
                           </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

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
