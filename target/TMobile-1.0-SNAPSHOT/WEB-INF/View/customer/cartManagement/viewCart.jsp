<%-- 
    Document   : viewCart
    Created on : Jun 20, 2025
    Author     : [Your Name]
--%>
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
            .cart-table .quantity-input {
                width: 60px;
                display: inline-block;
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
                    session.removeAttribute("message");
                }
            %>

            <!-- Cart Items Table -->
            <%
                List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
                // Giả định có danh sách biến thể cho mỗi sản phẩm
                List<ProductVariant> allVariants = (List<ProductVariant>) request.getAttribute("allVariants"); // Cần được truyền từ Servlet
                if (cartItems != null && !cartItems.isEmpty()) {
            %>
            <table class="table table-striped table-hover cart-table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="selectAll" onclick="toggleSelectAll()"></th>
                        <th>Product</th>
                        <th>Variant</th>
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
                                continue; // Bỏ qua nếu product null
                            }
                            ProductVariant variant = item.getVariant();
                            BigDecimal unitPrice = variant != null ? variant.getPrice() : product.getPrice();
                            BigDecimal discount = BigDecimal.valueOf(variant != null ? variant.getDiscount() : product.getDiscount());
                            BigDecimal discountFactor = BigDecimal.ONE.subtract(discount.divide(BigDecimal.valueOf(100), 2, BigDecimal.ROUND_HALF_UP));
                            BigDecimal discountedPrice = unitPrice.multiply(discountFactor);
                            BigDecimal itemTotal = discountedPrice.multiply(BigDecimal.valueOf(item.getQuantity()));
                    %>
                    <tr>
                        <td><input type="checkbox" class="selectItem" data-item-total="<%= itemTotal.setScale(0, BigDecimal.ROUND_HALF_UP).toString()%>" onclick="updateCartTotal()"></td>
                        <td>
                            <div class="d-flex align-items-center">
                                <img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "https://via.placeholder.com/80"%>" alt="<%= product.getProductName()%>">
                                <div class="ms-3">
                                    <a href="ProductDetailServlet?id=<%= product.getProductId()%>"><%= product.getProductName()%></a>
                                </div>
                            </div>
                        </td>
                        <td>
                            <form action="ViewCartServlet" method="post" class="action-buttons">
                                <input type="hidden" name="action" value="updateVariant">
                                <input type="hidden" name="cartItemId" value="<%= item.getCartItemID()%>">
                                <select name="variantId" class="form-select variant-select" onchange="this.form.submit()">
                                    <option value="0" <%= variant == null ? "selected" : ""%>>No Variant</option>
                                    <%
                                        if (allVariants != null) {
                                            for (ProductVariant v : allVariants) {
                                                if (v.getProductId() == product.getProductId()) {
                                    %>
                                    <option value="<%= v.getVariantId()%>" <%= variant != null && v.getVariantId() == variant.getVariantId() ? "selected" : ""%>>
                                        <%= v.getColor() + ", " + v.getStorage()%>
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
                            <form action="ViewCartServlet" method="post" class="action-buttons">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="cartItemId" value="<%= item.getCartItemID()%>">
                                <input type="number" name="quantity" value="<%= item.getQuantity()%>" min="1" max="<%= variant != null ? variant.getQuantity() : product.getStock()%>" class="form-control quantity-input" required>
                                <button type="submit" class="btn btn-primary btn-sm mt-1" title="Update Quantity">
                                    <i class="fas fa-sync"></i>
                                </button>
                            </form>
                        </td>
                        <td class="price"><%= String.format("%,d", itemTotal.setScale(0, BigDecimal.ROUND_HALF_UP).longValue())%> VND</td>
                        <td class="action-buttons">
                            <form action="RemoveCartItem" method="post">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="cartItemId" value="<%= item.getCartItemID()%>">
                                <button type="submit" class="btn btn-danger btn-sm" title="Remove Item" onclick="return confirm('Are you sure you want to remove this item?');">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </form>
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
                    <a href="CartList?action=shop" class="btn btn-secondary">Continue Shopping</a>
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script>
                                    // Format number with commas
                                    function formatNumber(number) {
                                        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
                                    }

                                    // Update cart total based on selected items
                                    function updateCartTotal() {
                                        let total = 0;
                                        document.querySelectorAll('.selectItem:checked').forEach(item => {
                                            total += parseInt(item.getAttribute('data-item-total'));
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

                                    // Initialize cart total on page load
                                    document.addEventListener('DOMContentLoaded', updateCartTotal);
        </script>
    </body>
</html>