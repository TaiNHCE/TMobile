<%-- 
    Document   : viewProductDetail
    Created on : Jun 19, 2025
    Author     : [Your Name]
--%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <title>Product Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                margin-top: 30px;
            }
            .card-img-top {
                max-width: 200px;
                height: auto;
            }
            .action-buttons form, .action-buttons a {
                display: inline-block;
                margin-right: 5px;
            }
            .action-buttons button, .action-buttons a {
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="mb-4">Product Details</h2>
            <%
                Product product = (Product) request.getAttribute("data");
                if (product != null) {
            %>
            <div class="card">
                <% if (product.getImageUrl() != null) {%>
                <img src="<%= product.getImageUrl()%>" class="card-img-top" alt="Product Image">
                <% }%>
                <div class="card-body">
                    <h5 class="card-title"><%= product.getProductName()%></h5>
                    <p class="card-text"><strong>ID:</strong> <%= product.getProductId()%></p>
                    <p class="card-text"><strong>Description:</strong> <%= product.getDescription() != null ? product.getDescription() : "N/A"%></p>
                    <p class="card-text"><strong>Price:</strong> <%= product.getPrice()%></p>
                    <p class="card-text"><strong>Discount:</strong> <%= product.getDiscount()%>%</p>
                    <p class="card-text"><strong>Stock:</strong> <%= product.getStock()%></p>
                    <p class="card-text"><strong>Status:</strong> <%= product.getStatus() != null ? product.getStatus() : "N/A"%></p>
                    <p class="card-text"><strong>Supplier ID:</strong> <%= product.getSupplierId()%></p>
                    <p class="card-text"><strong>Category ID:</strong> <%= product.getCategoryId()%></p>
                    <p class="card-text"><strong>Brand ID:</strong> <%= product.getBrandId()%></p>
                    <p class="card-text"><strong>Featured:</strong> <%= product.isIsFeatured() ? "Yes" : "No"%></p>
                    <p class="card-text"><strong>Best Seller:</strong> <%= product.isIsBestSeller() ? "Yes" : "No"%></p>
                    <p class="card-text"><strong>New:</strong> <%= product.isIsNew() ? "Yes" : "No"%></p>
                    <p class="card-text"><strong>Warranty Period:</strong> <%= product.getWarrantyPeriod()%> months</p>
                    <p class="card-text"><strong>Activated:</strong> <%= product.isIsActive() ? "Yes" : "No"%></p>
                    <div class="action-buttons">
                        <!-- Activate Product -->
                        <form action="ActivateProductServlet" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to ACTIVATE this product?');">
                            <input type="hidden" name="productId" value="<%= product.getProductId()%>">
                            <button type="submit" class="btn btn-success btn-sm" title="Activate Product" <%= product.isIsActive() ? "disabled" : ""%>>
                                <i class="fas fa-check"></i> Activate
                            </button>
                        </form>
                        <form action="RejectProductServlet" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to REJECT this product?');">
                            <input type="hidden" name="productId" value="<%= product.getProductId()%>">
                            <button type="submit" class="btn btn-success btn-sm" title="Reject Product" 
                                    <i class="fas fa-check"></i> Reject
                            </button>
                        </form>

                        <!-- Back to List -->
                        <a href="ProductList?action=list" class="btn btn-primary">
                            <i class="fas fa-arrow-left"></i> Back to List
                        </a>
                    </div>
                </div>
            </div>
            <%
            } else {
            %>
            <div class="alert alert-danger">Product not found.</div>
            <%
                }
            %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>