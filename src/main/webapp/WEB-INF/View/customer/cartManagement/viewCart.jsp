<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.CartItem"%>
<%@page import="model.Product"%>
<%@page import="model.ProductVariant"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>View Cart - TShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 30px;
        }
        .cart-table img {
            max-width: 80px;
            height: auto;
        }
        .quantity-container {
            display: flex;
            align-items: center;
            gap: 5px;
            position: relative;
        }
        .quantity-btn {
            width: 30px;
            height: 30px;
            padding: 0;
            font-size: 1rem;
            opacity: 0.6; /* Làm mờ nút */
            background-color: #ccc; /* Màu nền để rõ ràng hơn */
        }
        .quantity-value {
            width: 40px;
            text-align: center;
            margin: 0;
            /* Ẩn spinner của input number */
            -moz-appearance: textfield;
        }
        .quantity-value::-webkit-outer-spin-button,
        .quantity-value::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        .cart-total {
            font-size: 1.2rem;
            font-weight: bold;
        }
        .action-buttons form, .action-buttons a {
            display: inline-block;
            margin-right: 5px;
        }
        .variant-select {
            width: 150px;
        }
        .price {
            white-space: nowrap;
        }
        .quantity-tooltip {
            display: none;
            position: absolute;
            top: -30px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.8rem;
            color: #333;
            z-index: 1000;
            white-space: nowrap;
        }
        .quantity-container:hover .quantity-tooltip {
            display: block;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="mb-4">Your Shopping Cart</h2>

        <!-- Display notification -->
        <%
            String message = (String) session.getAttribute("message");
            if (message != null) {
                out.println("<div class='alert alert-info'>" + message + "</div>");
                session.removeAttribute("message"); // Xóa thông báo sau khi hiển thị
            }
        %>

        <!-- Cart Items Table -->
        <%
            List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
            List<ProductVariant> allVariants = (List<ProductVariant>) request.getAttribute("allVariants");
            if (cartItems != null && !cartItems.isEmpty()) {
        %>
        <table class="table table-striped table-hover cart-table">
            <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll" onclick="toggleSelectAll()"></th>
                    <th>Product</th>
                    <th>Color</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (CartItem item : cartItems) {
                        Product product = item.getProduct();
                        if (product == null) {
                            continue;
                        }
                        ProductVariant variant = item.getVariant();
                        BigDecimal unitPrice = variant != null ? variant.getPrice() : product.getPrice();
                        BigDecimal discount = BigDecimal.valueOf(variant != null ? variant.getDiscount() : product.getDiscount());
                        BigDecimal discountFactor = BigDecimal.ONE.subtract(discount.divide(BigDecimal.valueOf(100), 2, BigDecimal.ROUND_HALF_UP));
                        BigDecimal discountedPrice = unitPrice.multiply(discountFactor);
                        BigDecimal itemTotal = discountedPrice.multiply(BigDecimal.valueOf(item.getQuantity()));
                %>
                <tr data-unit-price="<%= discountedPrice.setScale(0, BigDecimal.ROUND_HALF_UP).toString()%>" data-cart-item-id="<%= item.getCartItemID()%>">
                    <td><input type="checkbox" class="selectItem" data-item-total="<%= itemTotal.setScale(0, BigDecimal.ROUND_HALF_UP).toString()%>" onclick="updateCartTotal()"></td>
                    <td>
                        <div class="d-flex align-items-center">
                            <img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "https://via.placeholder.com/80"%>" alt="<%= product.getProductName()%>">
                            <div class="ms-3">
                                <a href="ProductList?action=detail&id=<%= product.getProductId()%>"><%= product.getProductName()%></a>
                            </div>
                        </div>
                    </td>
                    <td>
                        <form action="CartList" method="post" class="action-buttons" id="variantForm-<%= item.getCartItemID()%>">
                            <input type="hidden" name="action" value="updateVariant">
                            <input type="hidden" name="cartItemId" value="<%= item.getCartItemID()%>">
                            <select name="variantId" class="form-select variant-select" onchange="updateVariant(<%= item.getCartItemID()%>)">
                                <%
                                    boolean hasVariants = false;
                                    if (allVariants != null && !allVariants.isEmpty()) {
                                        for (ProductVariant v : allVariants) {
                                            if (v.getProductId() == product.getProductId() && v.getColor() != null && !v.getColor().isEmpty()) {
                                                hasVariants = true;
                                                break;
                                            }
                                        }
                                    }
                                    if (allVariants == null || allVariants.isEmpty() || !hasVariants) {
                                %>
                                <option value="0" <%= (variant == null) ? "selected" : ""%>>No Variant</option>
                                <%
                                    }
                                    if (allVariants != null) {
                                        for (ProductVariant v : allVariants) {
                                            if (v.getProductId() == product.getProductId() && v.getColor() != null && !v.getColor().isEmpty()) {
                                %>
                                <option value="<%= v.getVariantId()%>" <%= (variant != null && v.getVariantId() == variant.getVariantId()) ? "selected" : ""%>>
                                    <%= v.getColor()%>
                                </option>
                                <%
                                            }
                                        }
                                    }
                                %>
                            </select>
                        </form>
                    </td>
                    <td class="price">
                        <%= String.format("%,d", discountedPrice.setScale(0, BigDecimal.ROUND_HALF_UP).longValue())%> VND
                        <% if (discount.compareTo(BigDecimal.ZERO) > 0) {%>
                        <small class="text-muted"><del><%= String.format("%,d", unitPrice.setScale(0, BigDecimal.ROUND_HALF_UP).longValue())%> VND</del></small>
                        <% }%>
                    </td>
                    <td>
                        <form action="CartList" method="post" class="action-buttons" id="quantityForm-<%= item.getCartItemID()%>">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="cartItemId" value="<%= item.getCartItemID()%>">
                            <div class="quantity-container">
                                <button type="button" class="btn btn-secondary quantity-btn" disabled>-</button>
                                <input type="number" name="quantity" value="<%= item.getQuantity()%>" class="form-control quantity-value" id="quantity-<%= item.getCartItemID()%>" readonly>
                                <button type="button" class="btn btn-secondary quantity-btn" disabled>+</button>
                                <div class="quantity-tooltip">Quantity can only be changed at checkout</div>
                            </div>
                        </form>
                    </td>
                    <td class="price" id="total-<%= item.getCartItemID()%>"><%= String.format("%,d", itemTotal.setScale(0, BigDecimal.ROUND_HALF_UP).longValue())%> VND</td>
                    <td class="action-buttons">
                        <button class="btn btn-danger" onclick="confirmDeleteCart(<%= item.getCartItemID()%>)">Delete</button>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <!-- Cart Summary -->
        <div class="card p-3 mb-4">
            <div class="d-flex justify-content-between cart-total">
                <span>Total:</span>
                <span id="cartTotal">0 VND</span>
            </div>
            <div class="text-end mt-3">
                <a href="CheckoutServlet" class="btn btn-success">Proceed to Checkout</a>
                <a href="ProductListServlet" class="btn btn-secondary">Continue Shopping</a>
            </div>
        </div>
        <%
            } else {
        %>
        <div class="alert alert-info">
            Your cart is empty. <a href="CartList?action=shop">Shop now!</a>
            
        </div>
        <%
            }
        %>
    </div>
    <% 
        String successdelete = request.getParameter("successdelete");
        String errordelete = request.getParameter("errordelete");
    %>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // Hàm xác nhận xóa
        function confirmDeleteCart(cartItemId) {
            Swal.fire({
                title: 'Are you sure?',
                text: "This cart item will be deleted.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Delete',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'RemoveCartItem?action=remove&id=' + cartItemId + '&accountId=<%= request.getParameter("accountId") %>';
                }
            });
        }

        // Hiển thị thông báo khi tải trang
        window.onload = function () {
            <% if ("1".equals(successdelete)) { %>
                Swal.fire({
                    icon: 'success',
                    title: 'Deleted!',
                    text: 'The cart item has been deleted.',
                    timer: 2000,
                    showConfirmButton: false
                });
            <% } else if ("1".equals(errordelete)) { %>
                Swal.fire({
                    icon: 'error',
                    title: 'Failed!',
                    text: 'Could not delete the cart item.',
                    timer: 2000,
                    showConfirmButton: false
                });
            <% } %>

            // Format number with commas
            function formatNumber(number) {
                return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
            }

            // Update cart total based on selected items
            function updateCartTotal() {
                let total = 0;
                document.querySelectorAll('.selectItem:checked').forEach(item => {
                    total += parseInt(item.getAttribute('data-item-total') || 0);
                });
                document.getElementById('cartTotal').textContent = formatNumber(total) + ' VND';
            }

            // Toggle select all checkboxes
            function toggleSelectAll() {
                const selectAll = document.getElementById('selectAll');
                document.querySelectorAll('.selectItem').forEach(item => {
                    item.checked = selectAll.checked;
                });
                updateCartTotal();
            }

            // Update variant using AJAX (chỉ cập nhật variant, không thay đổi quantity)
            function updateVariant(cartItemId) {
                let form = document.getElementById(`variantForm-${cartItemId}`);
                let formData = new FormData(form);
                $.ajax({
                    url: 'CartList',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (response) {
                        console.log('Variant updated successfully');
                        // Không cần cập nhật quantity ở đây
                    },
                    error: function (xhr, status, error) {
                        console.error('Error updating variant:', error);
                    }
                });
            }

            // Initialize cart total on page load
            document.addEventListener('DOMContentLoaded', updateCartTotal);
        };
    </script>
</body>
</html>