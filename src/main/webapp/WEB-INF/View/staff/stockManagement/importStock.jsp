<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.Suppliers" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Import Stock</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList6.css">
        <style>
            /* Style chuẩn chỉ áp dụng cho .modal-table, không ảnh hưởng bảng ngoài */
            .modal-table {
                border-radius: 0 !important;
                box-shadow: none !important;
                margin: 0 !important;
                font-size: 15px;
                background: #fff;
                table-layout: fixed; /* Changed from auto to fixed */
                width: 100%;
            }

            .modal-table th, .modal-table td {
                background: none !important;
                color: #212529 !important;
                border-bottom: 1px solid #e9ecef !important;
                padding: 12px 8px !important;
                text-align: left !important;
                vertical-align: middle !important;
                font-weight: 400;
                white-space: normal !important;
                word-wrap: break-word; /* Added for better text wrapping */
            }

            .modal-table th {
                font-weight: 600;
                font-size: 15px;
            }

            .modal-table > tbody > tr:nth-of-type(odd) {
                background-color: #f7fafd !important;
            }

            .modal-table > tbody > tr:nth-of-type(even) {
                background-color: #fff !important;
            }

            /* Specific column widths for Supplier Modal */
            #supplierListTable th:nth-child(1), #supplierListTable td:nth-child(1) {
                width: 15%;
            } /* Tax ID */
            #supplierListTable th:nth-child(2), #supplierListTable td:nth-child(2) {
                width: 20%;
            } /* Company Name */
            #supplierListTable th:nth-child(3), #supplierListTable td:nth-child(3) {
                width: 25%;
            } /* Email */
            #supplierListTable th:nth-child(4), #supplierListTable td:nth-child(4) {
                width: 15%;
            } /* Phone */
            #supplierListTable th:nth-child(5), #supplierListTable td:nth-child(5) {
                width: 15%;
            } /* Address */
            #supplierListTable th:nth-child(6), #supplierListTable td:nth-child(6) {
                width: 10%;
            } /* Select */

            /* Specific column widths for Product Modal */
            #productListTable th:nth-child(1), #productListTable td:nth-child(1) {
                width: 10%;
            } /* Product ID */
            #productListTable th:nth-child(2), #productListTable td:nth-child(2) {
                width: 35%;
            } /* Name */
            #productListTable th:nth-child(3), #productListTable td:nth-child(3) {
                width: 20%;
            } /* Import Quantity */
            #productListTable th:nth-child(4), #productListTable td:nth-child(4) {
                width: 20%;
            }
            #productListTable th:nth-child(5), #productListTable td:nth-child(5) {
                width: 15%;
            }

            .modal-table .select-supplier,
            .modal-table .select-product {
                min-width: 70px !important; /* Increased from 62px */
                width: 100% !important; /* Added for full width in cell */
                padding: 7px 12px !important; /* Increased horizontal padding */
                font-size: 15px !important;
                font-weight: 600 !important;
                border-radius: 8px !important;
                background: #2584f7 !important;
                color: #fff !important;
                border: none;
            }

            .modal-table .select-supplier:hover,
            .modal-table .select-product:hover {
                background: #0056d6 !important;
            }

            .modal-table input[type="number"],
            .modal-table input[type="text"] {
                font-size: 15px;
                height: 36px;
                padding: 6px 8px;
                border-radius: 7px;
                width: 100%; /* Added for full width */
                box-sizing: border-box; /* Added for proper sizing */
            }

            /* Fix for button spacing - 10px gap between Import and Cancel buttons */
            .mt-2.text-end .create-btn {
                margin-right: 10px; /* Add 10px gap */
            }

            /* Additional styling for better modal appearance */
            .modal-dialog.modal-lg {
                max-width: 1000px; /* Increased modal width */
            }

            .modal-body {
                padding: 20px;
            }

            .modal-header {
                background-color: #f8f9fa;
                border-bottom: 1px solid #dee2e6;
            }

            .modal-footer {
                background-color: #f8f9fa;
                border-top: 1px solid #dee2e6;
                padding: 15px 20px;
            }

            /* Style for search input */
            #searchSupplierInput,
            #searchProductInput {
                border: 1px solid #ced4da;
                border-radius: 8px;
                padding: 10px 15px;
                font-size: 15px;
            }

            #searchSupplierInput:focus,
            #searchProductInput:focus {
                border-color: #2584f7;
                box-shadow: 0 0 0 0.2rem rgba(37, 132, 247, 0.25);
                outline: none;


            }
        </style>
    </head>
    <body>
        <div class="container">
            <jsp:include page="../sideBar.jsp" />
            <div class="wrapper">
                <main class="main-content">
                    <jsp:include page="/WEB-INF/View/staff/header.jsp" />

                    <h1>Import Stock</h1>

                    <form class="search-form mb-4" method="get" style="min-height: 45px;">

                    </form>
                    <!-- Selected Supplier -->
                    <c:set value="${sessionScope.supplier}" var="sup" />
                    <div class="table-container mb-4" style="max-width: 1150px; margin: 0 auto;">
                        <div class="table-navigate" style="display: flex; align-items: center; justify-content: space-between;">
                            <h3 style="margin-bottom: 0;">Selected Supplier</h3>
                            <button id="openModalBtn" class="btn-detail">Select Supplier</button>
                        </div>
                        <table aria-label="Selected Supplier">
                            <thead>
                                <tr>
                                    <th>Tax ID</th>
                                    <th>Company Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                </tr>
                            </thead>
                            <tbody>
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

                    <!-- Selected Products -->
                    <div class="table-container mb-4" style="max-width: 1150px; margin: 0 auto;">
                        <div class="table-navigate" style="display: flex; align-items: center; justify-content: space-between;">
                            <h3 style="margin-bottom: 0;">Selected Products</h3>
                            <button id="openProductModalBtn" class="btn-detail">Select Product</button>
                        </div>
                        <table aria-label="Selected Products">
                            <thead>
                                <tr>
                                    <th>Product ID</th>
                                    <th>Product Name</th>
                                    <th>Import Quantity</th>
                                    <th>Import Price</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="sum" value="0" />
                                <c:forEach items="${sessionScope.selectedProducts}" var="d">
                                    <tr>
                                        <td>${d.getProduct().getProductId()}</td>
                                        <td>${d.getProduct().getProductName()}</td>
                                        <td>${d.getQuantity()}</td>
                                        <td>${d.unitPrice}</td>
                                        <td class="text-center">
                                            <button class="btn btn-warning edit-product"
                                                    data-id="${d.getProduct().getProductId()}"
                                                    data-name="${d.getProduct().getProductName()}"
                                                    data-quantity="${d.getQuantity()}"
                                                    data-price="${d.unitPrice}"
                                                    data-saleprice="${d.getProduct().getPrice()}">
                                                Edit
                                            </button>

                                        </td>

                                    </tr>
                                    <c:set var="sum" value="${sum + d.getQuantity() * d.getUnitPrice()}" scope="page"/>
                                </c:forEach>
                                <tr>
                                    <td colspan="3"></td>
                                    <td class="text-end fw-bold">Total:</td>
                                    <td class="fw-bold text-center" id="totalAmount">${sum} VND</td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="mt-2 text-end">
                            <button type="button" class="create-btn" onclick="redirectToImport()">Import</button>
                            <button type="button" class="back-btn" onclick="cancelImportStock()">Cancel</button>
                        </div>
                    </div>

                    <!-- Modal: Select Supplier -->
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
                                        <table class="table table-striped modal-table" id="supplierListTable">                                            <thead>
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

                    <!-- Modal: Select Product -->
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
                                        <table class="table table-striped modal-table" id="productListTable">
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
                                                            <input type="number" class="form-control product-price" data-id="${p.getProductId()}"  data-saleprice="${p.getPrice()}" min="1000" step="0.01" placeholder="Enter price">
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

                    <!-- Modal: Edit Product -->
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
                                        <input type="hidden" id="editProductSalePrice" name="salePrice">
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
                                <div class="mt-2 text-end">
                                    <button type="button" class="create-btn" onclick="redirectToImport()">Import</button>
                                    <button type="button" class="back-btn" onclick="cancelEditImportStock()" style="margin-left: 10px;">Cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Script xử lý JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
                                        // Format total amount as VND
                                        document.addEventListener("DOMContentLoaded", function () {
                                            let totalAmountElement = document.getElementById("totalAmount");
                                            if (totalAmountElement) {
                                                let amount = parseFloat(totalAmountElement.innerText.replace(/[^\d.-]/g, ''));
                                                if (!isNaN(amount)) {
                                                    totalAmountElement.innerText = amount.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                                                }
                                            }
                                        });

                                        // Open supplier modal
                                        document.getElementById("openModalBtn").addEventListener("click", function () {
                                            var myModal = new bootstrap.Modal(document.getElementById("createImportStock"));
                                            myModal.show();
                                        });

                                        // Open product modal
                                        document.getElementById("openProductModalBtn").addEventListener("click", function () {
                                            let productModal = new bootstrap.Modal(document.getElementById("selectProductModal"));
                                            productModal.show();
                                        });

                                        // Select supplier inside modal
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

                                        // Select product and input quantity, price
                                        document.addEventListener("DOMContentLoaded", function () {
                                            const confirmProductBtn = document.getElementById("confirmProductSelection");
                                            const productIdInput = document.getElementById("selectedProductId");
                                            const productQuantityInput = document.getElementById("selectedProductQuantity");
                                            const productPriceInput = document.getElementById("selectedProductPrice");
                                            // Function to show error message
                                            function showInputError(input, message) {
                                                input.classList.add('is-invalid');
                                                // Remove existing error message
                                                const existingError = input.parentNode.querySelector('.invalid-feedback');
                                                if (existingError) {
                                                    existingError.remove();
                                                }
                                                // Add new error message
                                                const errorDiv = document.createElement('div');
                                                errorDiv.className = 'invalid-feedback';
                                                errorDiv.textContent = message;
                                                input.parentNode.appendChild(errorDiv);
                                            }

                                            // Function to clear error message
                                            function clearInputError(input) {
                                                input.classList.remove('is-invalid');
                                                const errorDiv = input.parentNode.querySelector('.invalid-feedback');
                                                if (errorDiv) {
                                                    errorDiv.remove();
                                                }
                                            }

                                            // Add event listeners to clear errors when typing
                                            document.querySelectorAll('.product-quantity, .product-price').forEach(input => {
                                                input.addEventListener('input', function () {
                                                    clearInputError(this);
                                                });
                                            });
                                            document.querySelectorAll(".select-product").forEach(button => {
                                                button.addEventListener("click", function () {
                                                    const productId = this.dataset.id;
                                                    const selectedRow = this.closest("tr");
                                                    const quantityInput = selectedRow.querySelector(".product-quantity");
                                                    const priceInput = selectedRow.querySelector(".product-price");
                                                    const productQuantity = parseInt(quantityInput.value);
                                                    const productPrice = parseFloat(priceInput.value);
                                                    // Clear previous errors
                                                    clearInputError(quantityInput);
                                                    clearInputError(priceInput);
                                                    let hasError = false;
                                                    if (isNaN(productQuantity) || productQuantity < 1) {
                                                        showInputError(quantityInput, 'Please enter a valid quantity (minimum: 1)');
                                                        quantityInput.focus();
                                                        hasError = true;
                                                    }

                                                    if (isNaN(productPrice) || productPrice < 1000) {
                                                        showInputError(priceInput, 'Please enter a valid price (minimum: 1,000)');
                                                        if (!hasError)
                                                            priceInput.focus();
                                                        hasError = true;
                                                    }

                                                    if (hasError) {
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

                                        // Open modal to edit imported product
                                        document.addEventListener("DOMContentLoaded", function () {
                                            const editModal = new bootstrap.Modal(document.getElementById("editProductModal"));
                                            document.querySelectorAll(".edit-product").forEach(button => {
                                                button.addEventListener("click", function () {
                                                    const productId = this.dataset.id;
                                                    const productName = this.dataset.name;
                                                    const quantity = this.dataset.quantity;
                                                    const price = this.dataset.price;
                                                    const salePrice = this.dataset.saleprice;
                                                    document.getElementById("editProductId").value = productId;
                                                    document.getElementById("editProductName").value = productName;
                                                    document.getElementById("editProductQuantity").value = quantity;
                                                    document.getElementById("editProductPrice").value = price;
                                                    document.getElementById("editProductSalePrice").value = salePrice;
                                                    editModal.show();
                                                });
                                            });
                                            // Validation cho edit product price
                                            document.getElementById("editProductPrice").addEventListener("input", function () {
                                                const importPrice = parseFloat(this.value);
                                                const salePrice = parseFloat(document.getElementById("editProductSalePrice").value);
                                                const submitBtn = document.querySelector("#editProductModal .create-btn");
                                                let errorDiv = this.parentNode.querySelector('.invalid-feedback');
                                                if (!errorDiv) {
                                                    errorDiv = document.createElement('div');
                                                    errorDiv.className = 'invalid-feedback';
                                                    this.parentNode.appendChild(errorDiv);
                                                }

                                                if (!isNaN(importPrice) && !isNaN(salePrice) && importPrice >= salePrice) {
                                                    this.classList.add('is-invalid');
                                                    errorDiv.textContent = 'Import price must be less than sale price (' + salePrice.toLocaleString('vi-VN') + ' VND)';
                                                    submitBtn.disabled = true;
                                                } else {
                                                    this.classList.remove('is-invalid');
                                                    errorDiv.textContent = '';
                                                    submitBtn.disabled = false;
                                                }
                                            });
                                        });

                                        // Supplier search filter
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

                                        // Product search filter
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

                                        // Cancel button: redirect to import statistics page
                                        function cancelImportStock() {
                                            window.location.href = 'ImportStatistic';
                                        }
                                        function cancelEditImportStock() {
                                            window.location.href = 'ImportStock';
                                        }

                                        // Import button: submit form
                                        function redirectToImport() {
                                            const form = document.createElement("form");
                                            form.method = "POST";
                                            form.action = "ImportStock";
                                            document.body.appendChild(form);
                                            form.submit();
                                        }
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Kiểm tra Import Price và disable nút Select nếu lỗi
                document.querySelectorAll("#productListTable tbody tr").forEach(function (row) {
                    const priceInput = row.querySelector(".product-price");
                    const selectBtn = row.querySelector(".select-product");
                    const salePrice = parseFloat(priceInput.getAttribute("data-saleprice"));
                    priceInput.addEventListener("input", function () {
                        const importPrice = parseFloat(this.value);
                        let errorDiv = this.parentNode.querySelector('.invalid-feedback');
                        if (!errorDiv) {
                            errorDiv = document.createElement('div');
                            errorDiv.className = 'invalid-feedback';
                            this.parentNode.appendChild(errorDiv);
                        }
                        // Check lỗi
                        if (!isNaN(importPrice) && !isNaN(salePrice) && importPrice >= salePrice) {
                            this.classList.add('is-invalid');
                            errorDiv.textContent = 'Import price must be less than sale price (' + salePrice.toLocaleString('vi-VN') + ' VND)';
                            selectBtn.disabled = true;
                        } else {
                            this.classList.remove('is-invalid');
                            errorDiv.textContent = '';
                            selectBtn.disabled = false;
                        }
                    });
                });
            });
        </script>

        <!-- SweetAlert2: success/failure messages from servlet (English) -->
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
                    title: 'Import Failed!',
                    text: 'An error occurred during the import process.',
                    showConfirmButton: true,
                    confirmButtonText: 'Try Again'
                });
            <% }%>
            };
        </script>

        <!-- SweetAlert2: import stock errors from backend (English) -->
        <c:if test="${not empty sessionScope.error}">
            <script>
                window.onload = function () {
                    Swal.fire({
                        icon: 'error',
                        title: 'Import Error',
                        text: '${sessionScope.error}',
                        showConfirmButton: true,
                        confirmButtonText: 'OK'
                    });
                };
            </script>
            <c:remove var="error" scope="session"/>
        </c:if>
    </body>
</html>