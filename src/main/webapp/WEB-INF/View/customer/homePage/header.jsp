<%@page import="model.Brand"%>
<%@page import="model.Category"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
    List<Brand> brandList = (List<Brand>) request.getAttribute("brandList");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Genuine Phones, Laptops, Watches, and Accessories</title>
        <!-- Bootstrap 5 CSS & Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/header.css">
        <style>
            /* ----- ACCOUNT DROPDOWN STYLE ----- */
            .account-dropdown-wrapper {
                position: relative;
                display: flex;
                align-items: center;
            }
            .account-circle {
                background: #fff;
                border-radius: 50%;
                width: 44px;
                height: 44px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2rem;
                color: #222;
                box-shadow: 0 2px 6px rgba(0,0,0,0.09);
                border: 2px solid #55C3FC;
                cursor: pointer;
                transition: box-shadow 0.18s;
            }
            .account-circle:hover {
                box-shadow: 0 6px 24px rgba(85,195,252,0.17);
            }
            .account-dropdown {
                display: none;
                position: absolute;
                top: 52px;
                left: 0;
                min-width: 185px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 6px 22px rgba(85,195,252,0.27);
                padding: 10px 0;
                z-index: 100;
                border: 2px solid #55C3FC;
                animation: fadeInDown 0.22s;
            }
            .account-dropdown .dropdown-item {
                display: flex;
                align-items: center;
                gap: 16px;
                padding: 15px 24px;
                color: #222;
                font-size: 1.15rem;
                font-weight: 400;
                background: none;
                border: none;
                transition: background 0.16s;
                text-decoration: none;
            }
            .account-dropdown .dropdown-item i {
                font-size: 1.6rem;
                min-width: 34px;
                text-align: center;
            }
            .account-dropdown .dropdown-item:hover {
                background: #eaf6ff;
                color: #0d6efd;
            }
            @keyframes fadeInDown {
                from { transform: translateY(-10px); opacity: 0; }
                to   { transform: translateY(0); opacity: 1; }
            }
        </style>
    </head>
    <body>
        <div class="header-top d-flex align-items-center justify-content-between py-2 px-3" style="background-color: #55C3FC;">
            <!-- (1) TRÁI: LOGO & NÚT DANH MỤC -->
            <div class="d-flex align-items-center">
                <!-- Logo -->
                <a style="margin-left: 25%" href="${pageContext.request.contextPath}/TMobile" class="me-3">
                    <img src="https://res.cloudinary.com/dgnyskpc3/image/upload/v1750919684/Logo_nl7ahl.png"
                         class="header-logo"
                         style="height: 40px; object-fit: contain;" />
                </a>
                <!-- Danh mục: Dropdown -->
                <div class="dropdown" style="margin-left: 20%">
                    <button class="category-btn"
                            type="button"
                            id="dropdownMenuButton"
                            data-bs-toggle="dropdown"
                            aria-expanded="false">
                        <i class="bi bi-list"></i> Categories
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <%
                            if (categoryList != null) {
                                for (Category cate : categoryList) {
                                    if (cate.getIsActive()) {
                        %>
                        <li class="dropdown-submenu position-relative">
                            <a class="dropdown-item"
                               href="${pageContext.request.contextPath}/Brand?name=">
                                <img src="<%= cate.getImgUrlLogo()%>"
                                     style="width: 18%; margin-right: 4%;">
                                <%= cate.getCategoryName()%>
                            </a>
                            <ul class="dropdown-menu">
                                <%
                                    if (brandList != null) {
                                        for (Brand brand : brandList) {
                                            if (brand.getCategoryID() == cate.getCategoryId()) {
                                %>
                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/Brand?name=<%= brand.getBrandName()%>">
                                        <img src="<%= brand.getImgUrlLogo()%>"
                                             style="width: 18%; margin-right: 4%;">
                                        <%= brand.getBrandName()%>
                                    </a>
                                </li>
                                <%
                                            }
                                        }
                                    }
                                %>
                            </ul>
                        </li>
                        <%
                                    }
                                }
                            }
                        %>
                    </ul>
                </div>
            </div>

            <!-- (2) GIỮA: THANH TÌM KIẾM -->
            <div class="search-wrapper mx-3 position-relative" style="flex: 0 0 30%;">
                <form action="Search" method="get" class="search-bar position-relative">
                    <input type="text"
                           name="keyword"
                           class="form-control"
                           style="padding-right: 40px;">
                    <button type="submit"
                            class="search-btn btn btn-outline-secondary position-absolute top-50 end-0 translate-middle-y">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
            </div>

            <!-- (3) PHẢI: TÀI KHOẢN & GIỎ HÀNG -->
            <div class="header-right d-flex align-items-center" style="width: 15%; margin-right: 5%;">
                <!-- User Account Dropdown -->
                <div class="account-dropdown-wrapper">
                    <div class="account-circle" id="accountDropdownToggle">
                        <i class="bi bi-person"></i>
                    </div>
                    <div class="account-dropdown" id="accountDropdownMenu">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                            <i class="bi bi-person-circle"></i>
                            <span>Profile</span>
                        </a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/order">
                            <i class="bi bi-file-earmark-text"></i>
                            <span>Order</span>
                        </a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/ViewShippingAddress">
                            <i class="bi bi-geo-alt"></i>
                            <span>Address</span>
                        </a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                            <i class="bi bi-box-arrow-left"></i>
                            <span>Logout</span>
                        </a>
                    </div>
                </div>
                <!-- Cart -->
                <a style="width: 60%; border-radius: 15px; margin-left:16px;" href="${pageContext.request.contextPath}/CartList" class="btn btn-outline-dark" title="Giỏ hàng">
                    <i class="bi bi-cart"></i> Cart
                </a>
            </div>
        </div>

        <!-- ================== JS LIBRARY ================== -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Dropdown toggle logic
            const toggle = document.getElementById('accountDropdownToggle');
            const menu = document.getElementById('accountDropdownMenu');
            document.addEventListener('click', function(e) {
                if (toggle && toggle.contains(e.target)) {
                    menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
                } else if (menu && !menu.contains(e.target)) {
                    menu.style.display = 'none';
                }
            });
        </script>
    </body>
</html>
