<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Genuine Phones, Laptops, Watches, and Accessories</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .header-top {
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
            padding: 10px 20px;
        }
        .header-logo {
            height: 50px;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .header-logo:hover {
            transform: scale(1.1);
        }
        .cart-btn {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            transition: background-color 0.3s ease, transform 0.3s ease;
            position: relative;
        }
        .cart-btn:hover {
            background-color: #e9ecef;
            transform: scale(1.1);
        }
        .cart-badge {
            font-size: 0.65rem;
            padding: 4px 6px;
            position: absolute;
            top: 0;
            right: 0;
            transform: translate(50%, -50%);
        }
        @media (max-width: 768px) {
            .header-logo {
                height: 40px;
            }
            .container-fluid {
                flex-direction: column;
                align-items: flex-start;
            }
            .header-right {
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>
    <header class="header-top shadow-sm">
        <div class="container-fluid d-flex align-items-center justify-content-between">
            <!-- Logo -->
            <a href="${pageContext.request.contextPath}/Home">
                <img src="${pageContext.request.contextPath}/Logo/logo2.png" 
                     alt="TShop Logo" 
                     class="header-logo" />
            </a>
            <!-- Giỏ hàng -->
            <div class="header-right">
                <%
                    Account account = (Account) session.getAttribute("account");
                    String cartUrl = (account != null) ? 
                        request.getContextPath() + "/CartList?accountId=" + account.getAccountID() : 
                        request.getContextPath() + "/login.jsp";
                %>
                <a href="<%= cartUrl %>" 
                   class="cart-btn btn btn-outline-dark" 
                   title="Giỏ hàng">
                    <i class="bi bi-cart fs-5"></i>
                    <span class="cart-badge badge bg-danger rounded-circle">
                        <%= session.getAttribute("cartItemCount") != null ? session.getAttribute("cartItemCount") : 0 %>
                    </span>
                </a>
            </div>
        </div>
    </header>
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>