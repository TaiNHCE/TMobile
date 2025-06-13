<%-- 
    Document   : header
    Created on : Jun 13, 2025, 3:27:43 PM
    Author     : HP - Gia Khiêm
--%>

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
    <head class="header-red">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Genuine Phones, Laptops, Watches, and Accessories</title>
        <!-- Bootstrap 5 CSS & Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"> <!-- bootstrap css -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/home.css">
    </head>

    <body>        
        <div class="container">
            <div class="header-top d-flex align-items-center justify-content-between">
                <!-- (1) TRÁI: LOGO & NÚT DANH MỤC -->
                <div class="d-flex align-items-center">
                    <!-- Logo -->
                    <a href="${pageContext.request.contextPath}/TMobile" class="me-3">
                        <img src="${pageContext.request.contextPath}/images/logo2.png" 
                             alt="TShop" 
                             class="header-logo" />
                    </a>

                    <!-- Danh mục: Dropdown -->
                    <div class="dropdown ms-3">
                        <button class="category-btn dropdown-toggle"
                                type="button"
                                id="dropdownMenuButton"
                                data-bs-toggle="dropdown"
                                aria-expanded="false">
                            <i class="bi bi-list"></i> Categories
                        </button>

                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <%
                                for (Category cate : categoryList) {
                            %>
                            <li class="dropdown-submenu position-relative">
                                <a class="dropdown-item dropdown-toggle"
                                   href="${pageContext.request.contextPath}/Brand?name=">
                                    <img src="<%= cate.getImgUrlLogo()%>" style="width: 18%; margin-right: 4%;">
                                    <%= cate.getCategoryName()%>
                                </a>
                                <ul class="dropdown-menu">
                                    <%
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
                                    %>
                                </ul>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                    </div>

                </div>
                <!-- (1) TRÁI: LOGO & NÚT DANH MỤC - KẾT THÚC -->
            </div>

            <!-- (2) GIỮA: THANH TÌM KIẾM -->
            <div class="search-wrapper flex-grow-1 mx-3 position-relative">
                <form action="Search" method="get" class="search-bar position-relative">
                    <input type="text"
                           name="keyword"
                           class="form-control"
                           placeholder="Nhập tên điện thoại, máy tính, phụ kiện... cần tìm">
                    <button type="submit"
                            class="search-btn btn btn-outline-secondary position-absolute top-50 end-0 translate-middle-y">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
            </div>
            <!-- (2) GIỮA: THANH TÌM KIẾM - KẾT THÚC -->

            <!-- (3) PHẢI: TÀI KHOẢN & GIỎ HÀNG -->
            <div class="header-right d-flex align-items-center ">
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-light me-2">
                    <i class="bi bi-person"></i>
                </a>

                <!-- Giỏ hàng -->
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light">
                    <i class="bi bi-cart"></i> Cart
                </a>
            </div>



        </div>

        <!-- ================== GÓI JS, JQUERY, POPPER, BOOTSTRAP ================== -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- JQuery -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> <!-- Bootstrap JS Bundle(dropdown) -->
    </body>
</html>


