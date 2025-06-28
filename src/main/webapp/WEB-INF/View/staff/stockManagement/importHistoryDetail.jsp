<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Import Stock Detail</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <style>
            .main-section {
                margin: 40px auto;
                max-width: 1200px;
            }
            .info-table th, .info-table td {
                vertical-align: middle !important;
            }
            .details-table th, .details-table td {
                vertical-align: middle !important;
            }
            .section-title {
                font-size: 1.8rem;
                font-weight: 500;
                margin-top: 24px;
            }
            .action-btns {
                text-align: right;
                margin-bottom: 18px;
            }
        </style>
    </head>
    <body>
        <div class="main-section">

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <!-- Thông tin chung -->
            <table class="table info-table mb-4">
                <thead>
                    <tr>
                        <th>Import ID</th>
                        <th>Staff ID</th>
                        <th>Staff Name</th>
                        <th>Date</th>
                        <th>Supplier</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${importStock.ioid}</td>
                        <td>${importStock.staffId}</td>
                        <td>${importStock.fullName}</td>
                        <td>
                            <fmt:formatDate value="${importStock.importDate}" pattern="yyyy-MM-dd HH:mm" />
                        </td>

                        <td>${importStock.supplier.name}</td>
                        <td><fmt:formatNumber value="${importStock.totalAmount}" type="currency" currencySymbol="₫"/></td>
                    </tr>
                </tbody>
            </table>

            <!-- Chi tiết sản phẩm -->
            <div class="section-title">Details</div>
            <table class="table table-bordered details-table">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Import Price</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${details}" var="d">
                        <tr>
                            <td>${d.product.productId}</td>
                            <td>${d.product.productName}</td>
                            <td>${d.quantity}</td>
                            <td><fmt:formatNumber value="${d.unitPrice}" type="currency" currencySymbol="₫"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <!-- Nút Back và Edit -->
            <div class="action-btns">
                <a href="ImportStockHistory" class="btn btn-secondary me-2">Back</a>
            </div>
        </div>


    </body>
</html>
