<%@page import="model.Brand"%>
<%@page import="model.Category"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Suppliers"%>
<%@page import="model.Product"%>
<%@page import="model.ProductDetail"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Detail for Staff</title>
        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Fontawesome CDN -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList5.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                background-color: #F2F4F7;
                min-height: 100vh;
            }

            .container {
                display: flex;
                flex-direction: column;
                padding: 20px;
            }

            .product-header {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 20px;
            }

            .product-header h1 {
                font-size: 320%;
                font-weight: bold;
                margin: 0;
                color: #232946;
            }

            .product-header span {
                font-size: 120%;
                color: gray;
                margin-top: 4%;
            }

            .product-container {
                display: flex;
                gap: 20px;
                background-color: #FFFFFF;
                border-radius: 15px;
                padding: 20px;
                box-shadow: 0 4px 18px rgba(34, 40, 85, 0.07);
            }

            .product-image {
                flex: 0 0 40%;
                text-align: center;
            }

            .product-image img {
                max-width: 100%;
                border-radius: 10px;
                cursor: pointer;
            }

            .product-image .click-to-change {
                font-size: 14px;
                color: #6c757d;
                margin-top: 10px;
            }

            .product-details {
                flex: 0 0 60%;
            }

            .product-details .form-group {
                margin-bottom: 15px;
            }

            .product-details label {
                font-weight: 600;
                margin-bottom: 5px;
                display: block;
            }

            .product-details input[type="text"],
            .product-details select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
            }

            .product-details .form-check {
                margin-right: 15px;
                display: inline-block;
            }

            .btn-back {
                color: #fff;
                background-color: #6c757d;
                border: 1px solid #6c757d;
                padding: 10px 20px;
                border-radius: 6px;
                font-size: 16px;
                cursor: pointer;
                text-decoration: none;
                transition: background-color 0.3s ease;
            }

            .btn-back:hover {
                background-color: #5c636a;
                border-color: #565e64;
            }

            .button-container {
                margin-top: 20px;
                text-align: right;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="product-header">
                <h1>Product Management</h1>
                <span>View Product Detail</span>
            </div>
            <%
                Product product = (Product) request.getAttribute("data");
                List<ProductDetail> productDetailList = (List<ProductDetail>) request.getAttribute("productDetailList");
                List<Suppliers> supList = (List<Suppliers>) request.getAttribute("supList");
                List<Category> cateList = (List<Category>) request.getAttribute("cateList");
                List<Brand> braList = (List<Brand>) request.getAttribute("braList");

                if (product == null) {
                    out.print("<p>There is no product with that ID</p>");
                } else {
                    // Format price
                    String priceFormatted = "";
                    if (product.getPrice() != null) {
                        BigDecimal price = product.getPrice();
                        Locale localeVN = new Locale("vi", "VN");
                        NumberFormat currencyVN = NumberFormat.getInstance(localeVN);
                        priceFormatted = currencyVN.format(price);
                    }

                    // Lấy tên supplier an toàn bằng vòng lặp
                    String supplierName = "N/A";
                    if (supList != null && !supList.isEmpty() && product.getSupplierId() > 0) {
                        for (Suppliers s : supList) {
                            if (s.getSupplierID() == product.getSupplierId()) {
                                supplierName = (s.getName() != null) ? s.getName() : "N/A";
                                break;
                            }
                        }
                    }

                    String categoryName = "N/A";
                    if (cateList != null && !cateList.isEmpty() && product.getCategoryId() > 0) {
                        for (Category s : cateList) {
                            if (s.getCategoryId() == product.getCategoryId()) {
                                categoryName = (s.getCategoryName() != null) ? s.getCategoryName() : "N/A";
                                break;
                            }
                        }
                    }

                    String brandName = "N/A";
                    if (braList != null && !braList.isEmpty() && product.getBrandId() > 0) {
                        for (Brand s : braList) {
                            if (s.getBrandId() == product.getBrandId()) {
                                brandName = (s.getBrandName() != null) ? s.getBrandName() : "N/A"; // Sửa thành brandName
                                break;
                            }
                        }
                    }

            %>
            <div class="product-container">
                <div class="product-image">
                    <img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "https://via.placeholder.com/300"%>" alt="Product Image" id="mainImage" class="img-fluid">
                    <% if (productDetailList != null && !productDetailList.isEmpty()) {%>
                    <div class="d-flex flex-wrap gap-2 mt-3">
                        <div class="img-thumbnail">
                            <img src="<%= productDetailList.get(0).getImageUrl1() != null ? productDetailList.get(0).getImageUrl1() : "https://via.placeholder.com/50"%>" onclick="changeMainImage(this.src)" class="img-fluid">
                        </div>
                        <div class="img-thumbnail">
                            <img src="<%= productDetailList.get(0).getImageUrl2() != null ? productDetailList.get(0).getImageUrl2() : "https://via.placeholder.com/50"%>" onclick="changeMainImage(this.src)" class="img-fluid">
                        </div>
                        <div class="img-thumbnail">
                            <img src="<%= productDetailList.get(0).getImageUrl3() != null ? productDetailList.get(0).getImageUrl3() : "https://via.placeholder.com/50"%>" onclick="changeMainImage(this.src)" class="img-fluid">
                        </div>
                        <div class="img-thumbnail">
                            <img src="<%= productDetailList.get(0).getImageUrl4() != null ? productDetailList.get(0).getImageUrl4() : "https://via.placeholder.com/50"%>" onclick="changeMainImage(this.src)" class="img-fluid">
                        </div>
                    </div>
                    <% }%>
                </div>
                <div class="product-details">
                    <div class="form-group">
                        <label>ID</label>
                        <input type="text" class="form-control" value="<%= product.getProductId()%>" readonly>
                    </div>
                    <div class="form-group">
                        <label>Product Name</label>
                        <input type="text" class="form-control" value="<%= product.getProductName() != null ? product.getProductName() : ""%>" readonly>
                    </div>
                    <div class="form-group">
                        <label>Price</label>
                        <input type="text" class="form-control" value="<%= product.getPrice() != null ? product.getPrice() : ""%>" readonly>
                    </div>
                    <div class="form-group">
                        <label>Supplier</label>
                        <input type="text" class="form-control" value="<%= supplierName%>" readonly>
                    </div>
                    <div class="form-group">
                        <label>Category</label>
                        <input type="text" class="form-control" value="<%= categoryName%>" readonly>
                    </div>
                    <div class="form-group">
                        <label>Brand</label>
                        <input type="text" class="form-control" value="<%= brandName%>" readonly>

                    </div>
                    <div class="form-group">
                        <label>Status</label>
                        <div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" name="status" value="featured" <%= product.isIsFeatured() ? "checked" : ""%> disabled>
                                <label class="form-check-label">Is Featured</label>
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" name="status" value="new" <%= product.isIsNew() ? "checked" : ""%> disabled>
                                <label class="form-check-label">Is New</label>
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" name="status" value="bestSeller" <%= product.isIsBestSeller() ? "checked" : ""%> disabled>
                                <label class="form-check-label">Is Best Seller</label>
                            </div>
                            <div class="form-check">

                            </div>
                        </div>
                    </div>
                    <div class="button-container">
                        <a href="ProductListForStaff" class="btn-back">Back</a>
                    </div>
                </div>
            </div>
            <% }%>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                function changeMainImage(src) {
                                    document.getElementById("mainImage").src = src;
                                }
        </script>
    </body>
</html>