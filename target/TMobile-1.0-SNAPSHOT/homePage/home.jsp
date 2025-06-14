<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    NumberFormat formatter = NumberFormat.getIntegerInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- File CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/style2.css">
</head>
<body>

<!-- HEADER -->
<%@ include file="header.jsp" %>

<div id="page-bg">
    <main class="content-wrapper">

        <!-- BANNER CAROUSEL -->
        <section class="mb-4">
            <div id="mainBanner" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="5000">
                <div id="bannerGradient"></div>
                <div class="carousel-inner">
                    <div class="carousel-item active" data-gradient="linear-gradient(180deg, #D6F1FF, #66A3FF)">
                        <img src="images/banner1.png" class="d-block w-100 banner-img" alt="Banner 1">
                    </div>
                    <div class="carousel-item" data-gradient="linear-gradient(180deg, #FFE9E9, #FFF)">
                        <img src="images/banner2.png" class="d-block w-100 banner-img" alt="Banner 2">
                    </div>
                    <div class="carousel-item" data-gradient="linear-gradient(180deg, #FFE9E9, #FFF)">
                        <img src="images/banner4.png" class="d-block w-100 banner-img" alt="Banner 3">
                    </div>
                </div>
                <button class="carousel-control-prev custom-carousel-btn" type="button" data-bs-target="#mainBanner" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </button>
                <button class="carousel-control-next custom-carousel-btn" type="button" data-bs-target="#mainBanner" data-bs-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </button>
            </div>
        </section>

        <!-- HERO SECTION -->
        <section class="hero mt-4 mb-4">
            <div class="container text-center">
                <h1 class="display-4">Chào mừng đến với T Mobile</h1>
                <p class="lead">Thế giới Điện thoại, Laptop, Đồng hồ, Tablet chính hãng</p>
                <a href="#categories" class="btn btn-primary btn-lg" id="exploreBtn">Khám phá ngay</a>
            </div>
            <button style="width: 4%" id="scrollToTop">
                <img style="width: 100%" src="Products/imgTitle/muiTenLen.png">
            </button>
        </section>

        <!-- BANNER 2 Ô -->
        <section class="dual-banner my-4">
            <div class="container-fluid px-0">
                <div class="row g-0">
                    <div class="col-md-6">
                        <a href="${pageContext.request.contextPath}/Laptop" class="position-relative">
                            <img src="images/banner-laptop.png" alt="Laptop Gaming" class="w-100 banner-custom">
                        </a>
                    </div>
                    <div class="col-md-6">
                        <a href="${pageContext.request.contextPath}/PhuKien" class="position-relative">
                            <img src="images/banner-tablet.png" alt="Tai nghe" class="w-100 banner-custom">
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- DANH MỤC SẢN PHẨM -->
        <section class="container my-4" id="categories">
            <%
                String[] titles = {"Điện thoại nổi bật", "Laptop nổi bật", "Phụ kiện nổi bật", "Đồng hồ nổi bật"};
                String[] links = {"Phone", "Laptop", "PhuKien", "DongHo"};
                List<List<Product>> allLists = new ArrayList<>();
                allLists.add((List<Product>) request.getAttribute("phones"));
                allLists.add((List<Product>) request.getAttribute("laptops"));
                allLists.add((List<Product>) request.getAttribute("accessories"));
                allLists.add((List<Product>) request.getAttribute("watches"));

                for (int i = 0; i < titles.length; i++) {
            %>
            <div class="d-flex align-items-center justify-content-between <%= (i > 0 ? "mt-5" : "") %> mb-3">
                <h2 class="mb-0">
                    <i class="bi bi-fire text-danger"></i> <%= titles[i] %>
                </h2>
                <a href="${pageContext.request.contextPath}/<%= links[i] %>" class="text-decoration-none fw-bold text-danger">Xem tất cả »</a>
            </div>
            <div class="row row-cols-5 g-3">
                <%
                    for (Product product : allLists.get(i)) {
                        double oldPrice = product.getOldPrice();
                        double newPrice = product.getDiscountedPrice();
                        double discountPercent = 0;
                        if (oldPrice > 0 && newPrice < oldPrice) {
                            discountPercent = (1 - (newPrice / oldPrice)) * 100;
                        }
                        String oldPriceFormatted = formatter.format(oldPrice);
                        String newPriceFormatted = formatter.format(newPrice);
                        double diff = oldPrice - newPrice;
                        String diffFormatted = formatter.format(diff);
                %>
                <div class="col">
                    <a href="Detail?id=<%= product.getProductID() %>" class="text-decoration-none" style="color: inherit;">
                        <div class="card card-product h-100">
                            <% if (discountPercent > 0) { %>
                            <div class="discount-badge">Giảm giá <%= String.format("%.0f", discountPercent) %>%</div>
                            <% } %>
                            <img class="card-img-top"
                                 src="<%= request.getContextPath() %>/Products/imgProducts/<%= product.getCategories().getCategoryName() %>/<%= product.getLinkImg() %>"
                                 alt="<%= product.getProductName() %>">
                            <div class="card-body">
                                <p class="installment">Trả góp 0%</p>
                                <h6 class="card-title"><%= product.getProductName() %></h6>
                                <% if (discountPercent > 0) { %>
                                <p class="price-info">
                                    <span class="old-price"><s><%= oldPriceFormatted %></s>₫</span>
                                    <span style="color: red">-<%= (int) discountPercent %>%</span>
                                </p>
                                <p class="price-new">
                                    <span class="new-price"><%= newPriceFormatted %>₫</span>
                                </p>
                                <p class="price-discount">Giảm <%= diffFormatted %>₫</p>
                                <% } else { %>
                                <p class="price-info">
                                    <span class="new-price"><%= newPriceFormatted %>₫</span>
                                </p>
                                <% } %>
                            </div>
                        </div>
                    </a>
                </div>
                <% } %>
            </div>
            <% } %>
        </section>
    </main>
</div>

<!-- FOOTER -->
<%@ include file="footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Scroll đến danh mục
    document.getElementById("exploreBtn").addEventListener("click", function (event) {
        event.preventDefault();
        document.getElementById("categories").scrollIntoView({behavior: "smooth"});
    });

    // Gradient chuyển banner
    document.addEventListener("DOMContentLoaded", function () {
        const mainBanner = document.getElementById("mainBanner");
        const bannerGradient = document.getElementById("bannerGradient");
        const activeItem = document.querySelector(".carousel-item.active");
        if (activeItem) {
            bannerGradient.style.background = activeItem.getAttribute("data-gradient");
        }
        mainBanner.addEventListener("slide.bs.carousel", function (event) {
            bannerGradient.style.background = event.relatedTarget.getAttribute("data-gradient");
        });
    });

    // Scroll to top
    document.getElementById("scrollToTop").addEventListener("click", function () {
        window.scrollTo({top: 0, behavior: "smooth"});
    });
</script>
</body>
</html>


