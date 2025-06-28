<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="model.Suppliers"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Import Stock</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .content { padding: 20px 10%; }
        .table-container { background: white; padding: 20px; border-radius: 10px; box-shadow: 0px 5px 15px rgba(0,0,0,0.1);}
        .table-navigate { display: flex; justify-content: space-between; align-items: center; }
        .table-navigate h3 { margin: 0; }
        .table { margin-bottom: 0; }
        thead { background: #7D69FF; color: white; }
        tbody tr:hover { background: #f2f2f2; }
        .btn-detail { background: #BDF3BD; border: none; }
        .btn-detail:hover { background: #91e491; }
        .fw-bold { font-weight: bold; }
    </style>
</head>
<body>
<div class="content">
    <div class="container mt-4">

        <%-- hien nha cung cap duoc chon --%>
        <c:set value="${sessionScope.supplier}" var="sup" />
        <div class="table-container mb-4">
            <div class="table-navigate">
                <h3>Selected Supplier</h3>
                <button id="openModalBtn" class="btn btn-detail">Select Supplier</button>
            </div>
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Tax ID</th>
                        <th>Company Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Address</th>
                    </tr>
                </thead>
                <tbody id="supplierTable">
                    <tr>
                        <td>${sup.taxId}</td>
                        <td>${sup.name}</td>
                        <td>${sup.email}</td>
                        <td>${sup.phoneNumber}</td>
                        <td>${sup.address}</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <%-- hien danh sach san pham duoc chon nhap kho --%>
        <div class="table-container mb-4">
            <div class="table-navigate">
                <h3>Selected Products</h3>
                <button id="openProductModalBtn" class="btn btn-detail">Select Product</button>
            </div>
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Import Quantity</th>
                        <th>Import Price</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="productTable">
                    <c:set var="sum" value="0" />
                    <c:forEach items="${sessionScope.selectedProducts}" var="d">
                        <tr>
                            <td>${d.getProduct().getProductId()}</td>
                            <td>${d.getProduct().getProductName()}</td>
                            <td>${d.getQuantity()}</td>
                            <td>${d.unitPrice}</td>
                            <td>
                                <button class="btn btn-warning edit-product"
                                        data-id="${d.getProduct().getProductId()}"
                                        data-name="${d.getProduct().getProductName()}"
                                        data-quantity="${d.getQuantity()}"
                                        data-price="${d.getUnitPrice()}">
                                    Edit
                                </button>
                            </td>
                        </tr>
                        <c:set var="sum" value="${sum + d.getQuantity() * d.getUnitPrice()}" scope="page"/>
                    </c:forEach>
                    <tr>
                        <td colspan="3"></td>
                        <td class="text-end fw-bold">Total:</td>
                        <td class="fw-bold" id="totalAmount">${sum} VND</td>
                    </tr>
                </tbody>
            </table>
            <div class="mt-3">
                <button type="button" class="btn btn-secondary" onclick="cancelImportStock()">Cancel</button>
                <button type="button" class="btn btn-success" onclick="redirectToImport()">Import</button>
            </div>
        </div>

        <%-- modal chon nha cung cap --%>
        <div class="modal fade" id="createImportStock" tabindex="-1" aria-labelledby="createImportStockLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createImportStockLabel">Select Supplier</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="text" id="searchSupplierInput" class="form-control mb-2" placeholder="Search supplier...">
                        <div style="max-height: 400px; overflow-y: auto;">
                            <table class="table table-striped" id="supplierListTable">
                                <thead>
                                    <tr>
                                        <th>Tax ID</th>
                                        <th>Company Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Address</th>
                                        <th>Select</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${sessionScope.suppliers}" var="s">
                                        <tr>
                                            <td>${s.getTaxId()}</td>
                                            <td>${s.getName()}</td>
                                            <td>${s.getEmail()}</td>
                                            <td>${s.getPhoneNumber()}</td>
                                            <td>${s.getAddress()}</td>
                                            <td>
                                                <button class="btn btn-primary select-supplier" data-id="${s.getSupplierID()}">Select</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <form id="importStockForm" method="POST" action="ImportStock">
                            <input type="hidden" name="supplierId" id="selectedSupplierID">
                            <button type="submit" class="btn btn-success" id="confirmSelection" disabled>Confirm</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%-- modal chon san pham --%>
        <div class="modal fade" id="selectProductModal" tabindex="-1" aria-labelledby="selectProductLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="selectProductLabel">Select Product</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="text" id="searchProductInput" class="form-control mb-2" placeholder="Search product...">
                        <div style="max-height: 400px; overflow-y: auto;">
                            <table class="table table-striped" id="productListTable">
                                <thead>
                                    <tr>
                                        <th>Product ID</th>
                                        <th>Name</th>
                                        <th>Import Quantity</th>
                                        <th>Import Price</th>
                                        <th>Select</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${sessionScope.products}" var="p">
                                        <tr>
                                            <td>${p.getProductId()}</td>
                                            <td>${p.getProductName()}</td>
                                            <td>
                                                <input type="number" class="form-control product-quantity" data-id="${p.getProductId()}" min="1" placeholder="Enter quantity">
                                            </td>
                                            <td>
                                                <input type="number" class="form-control product-price" data-id="${p.getProductId()}" min="1000" step="0.01" placeholder="Enter price">
                                            </td>
                                            <td>
                                                <button class="btn btn-primary select-product" data-id="${p.getProductId()}">Select</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <form id="productStockForm" method="POST" action="ImportStock">
                            <input type="hidden" name="productId" id="selectedProductId">
                            <input type="hidden" name="importQuantity" id="selectedProductQuantity">
                            <input type="hidden" name="unitPrice" id="selectedProductPrice">
                            <button type="submit" class="btn btn-success" id="confirmProductSelection" disabled>Confirm</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%-- modal sua san pham da chon --%>
        <div class="modal fade" id="editProductModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Imported Product</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editProductForm" method="POST" action="ImportStock">
                            <input type="hidden" id="editProductId" name="productEditedId">
                            <div class="mb-3">
                                <label class="form-label">Product Name:</label>
                                <input type="text" class="form-control" id="editProductName" readonly>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Import Quantity:</label>
                                <input type="number" class="form-control" id="editProductQuantity" name="quantity" min="1">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Import Price:</label>
                                <input type="number" class="form-control" id="editProductPrice" name="price" min="1000" step="1">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button name="action" value="delete" type="submit" class="btn btn-danger" form="editProductForm" id="deleteProduct">Delete</button>
                        <button name="action" value="save" type="submit" class="btn btn-success" form="editProductForm">Save</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Script xu ly javascript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    // dinh dang tong tien theo vnd
    document.addEventListener("DOMContentLoaded", function () {
        let totalAmountElement = document.getElementById("totalAmount");
        let amount = parseFloat(totalAmountElement.innerText.replace(/[^\d.-]/g, ''));
        if (!isNaN(amount)) {
            totalAmountElement.innerText = amount.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
        }
    });

    // mo modal chon supplier
    document.getElementById("openModalBtn").addEventListener("click", function () {
        var myModal = new bootstrap.Modal(document.getElementById("createImportStock"));
        myModal.show();
    });
    // mo modal chon san pham
    document.getElementById("openProductModalBtn").addEventListener("click", function () {
        let productModal = new bootstrap.Modal(document.getElementById("selectProductModal"));
        productModal.show();
    });

    // chon nha cung cap
    document.addEventListener("DOMContentLoaded", function () {
        const confirmBtn = document.getElementById("confirmSelection");
        const supplierIDInput = document.getElementById("selectedSupplierID");
        document.querySelectorAll(".select-supplier").forEach(button => {
            button.addEventListener("click", function () {
                const supplierID = this.dataset.id;
                const selectedRow = this.closest("tr");
                supplierIDInput.value = supplierID;
                document.querySelectorAll("#supplierListTable tbody tr").forEach(row => {
                    row.classList.remove("table-success");
                });
                selectedRow.classList.add("table-success");
                confirmBtn.disabled = false;
            });
        });
    });

    // chon san pham va nhap so luong, gia
    document.addEventListener("DOMContentLoaded", function () {
        const confirmProductBtn = document.getElementById("confirmProductSelection");
        const productIdInput = document.getElementById("selectedProductId");
        const productQuantityInput = document.getElementById("selectedProductQuantity");
        const productPriceInput = document.getElementById("selectedProductPrice");

        document.querySelectorAll(".select-product").forEach(button => {
            button.addEventListener("click", function () {
                const productId = this.dataset.id;
                const selectedRow = this.closest("tr");
                const quantityInput = selectedRow.querySelector(".product-quantity");
                const priceInput = selectedRow.querySelector(".product-price");
                const productQuantity = parseInt(quantityInput.value);
                const productPrice = parseFloat(priceInput.value);

                if (isNaN(productQuantity) || productQuantity < 1) {
                    alert("Please enter a valid quantity (min: 1).");
                    quantityInput.value = "";
                    quantityInput.focus();
                    selectedRow.classList.remove("table-success");
                    confirmProductBtn.disabled = true;
                    return;
                }
                if (isNaN(productPrice) || productPrice < 1000) {
                    alert("Please enter a valid price (min: 1000).");
                    priceInput.value = "";
                    priceInput.focus();
                    selectedRow.classList.remove("table-success");
                    confirmProductBtn.disabled = true;
                    return;
                }

                productQuantityInput.value = productQuantity;
                productPriceInput.value = productPrice;
                productIdInput.value = productId;
                document.querySelectorAll("#productListTable tbody tr").forEach(row => {
                    row.classList.remove("table-success");
                });
                selectedRow.classList.add("table-success");
                confirmProductBtn.disabled = false;
            });
        });
    });

    // sua thong tin san pham nhap kho
    document.addEventListener("DOMContentLoaded", function () {
        const editModal = new bootstrap.Modal(document.getElementById("editProductModal"));
        document.querySelectorAll(".edit-product").forEach(button => {
            button.addEventListener("click", function () {
                const productId = this.dataset.id;
                const productName = this.dataset.name;
                const quantity = this.dataset.quantity;
                const price = this.dataset.price;
                document.getElementById("editProductId").value = productId;
                document.getElementById("editProductName").value = productName;
                document.getElementById("editProductQuantity").value = quantity;
                document.getElementById("editProductPrice").value = price;
                editModal.show();
            });
        });
    });

    // filter supplier
    document.getElementById("searchSupplierInput").addEventListener("keyup", function () {
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("#supplierListTable tbody tr");
        rows.forEach(row => {
            let taxId = row.cells[0].textContent.toLowerCase();
            let companyName = row.cells[1].textContent.toLowerCase();
            let email = row.cells[2].textContent.toLowerCase();
            if (taxId.includes(filter) || companyName.includes(filter) || email.includes(filter)) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    });

    // filter product
    document.getElementById("searchProductInput").addEventListener("keyup", function () {
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("#productListTable tbody tr");
        rows.forEach(row => {
            let id = row.cells[0].textContent.toLowerCase();
            let name = row.cells[1].textContent.toLowerCase();
            if (name.includes(filter) || id.includes(filter)) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    });

    // nut cancel, ve trang thong ke nhap kho
    function cancelImportStock() {
        window.location.href = 'ImportStatistic';
    }
    // nut Import, submit form
    function redirectToImport() {
        const form = document.createElement("form");
        form.method = "POST";
        form.action = "ImportStock";
        document.body.appendChild(form);
        form.submit();
    }
</script>

<%-- sweetalert2 thong bao thanh cong/that bai --%>
<%
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>
<script>
    window.onload = function () {
        <% if ("imported".equals(success)) { %>
        Swal.fire({
            icon: 'success',
            title: 'Import Successful!',
            text: 'Stock has been successfully imported.',
            showConfirmButton: true,
            confirmButtonText: 'OK',
            timer: 2500
        });
        <% } else if ("1".equals(error)) { %>
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: 'An error occurred during the import process.',
            showConfirmButton: true,
            confirmButtonText: 'Try Again'
        });
        <% } %>
    };
</script>
</body>
</html>
