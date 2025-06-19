<%@page import="java.util.Locale"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Voucher" %>
<%
    Voucher v = (Voucher) request.getAttribute("voucher");
%>
<html>
    <head>
        <title>Voucher Details</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css">
        <%@ page import="java.text.NumberFormat" %>
        <%
            NumberFormat currencyVN = NumberFormat.getInstance(new Locale("vi", "VN"));
        %>
    </head>
    <body>
        <div class="container-fluid">
            <jsp:include page="../sideBar.jsp" />
            <div class="wrapper" style="margin-left:250px;">
                <main class="main-content p-4">
                    <h2 class="fw-bold mb-4">Voucher Details</h2>

                    <table class="table table-bordered w-75">
                        <tr><th>ID</th><td><%= v.getVoucherID()%></td></tr>
                        <tr><th>Code</th><td><%= v.getCode()%></td></tr>
                        <tr><th>Discount Percentage</th><td><%= v.getDiscountPercent()%> %</td></tr>
                        <tr><th>Expiry Date</th><td><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(v.getExpiryDate())%></td></tr>
                        <tr><th>Minimum Order Amount</th><td><%= currencyVN.format(v.getMinOrderAmount()) + " đ"%></td></tr>
                        <tr><th>Maximum Discount Amount</th><td><%= currencyVN.format(v.getMaxDiscountAmount()) + " đ"%></td></tr>
                        <tr><th>Usage Limit</th><td><%= v.getUsageLimit()%></td></tr>
                        <tr><th>Used Count</th><td><%= v.getUsedCount()%></td></tr>
                        <tr>
                            <th>Status</th>
                            <td>
                                <span class="badge <%= v.isActive() ? "bg-success" : "bg-danger"%>">
                                    <%= v.isActive() ? "Active" : "Inactive"%>
                                </span>
                            </td>
                        </tr>
                        <tr><th>Description</th><td><%= v.getDescription() != null ? v.getDescription() : ""%></td></tr>
                    </table>

                    <div class="d-flex align-items-center gap-2 mt-3">
                        <a href="Voucher" class="btn btn-secondary">
                            <i class="fa-solid fa-arrow-left"></i> Back to List
                        </a>
                        <a href="Voucher?action=edit&id=<%= v.getVoucherID()%>" class="btn btn-warning">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <a href="#"
                           class="btn btn-danger"
                           data-bs-toggle="modal"
                           data-bs-target="#deleteModal"
                           data-delete-url="Voucher?action=delete&id=<%= v.getVoucherID()%>">
                            <i class="fa-solid fa-trash"></i> Delete
                        </a>
                    </div>

                </main>
            </div>
        </div>
        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-4 shadow">
                    <div class="modal-header bg-danger text-white rounded-top-4">
                        <h5 class="modal-title" id="deleteModalLabel">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i> Confirm Deletion
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="mb-0 fs-5">
                            Are you sure you want to <span class="fw-bold text-danger">delete</span> this voucher?<br>
                            This action cannot be undone.
                        </p>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Cancel</button>
                        <a href="#" class="btn btn-danger px-4" id="confirmDeleteBtn">Delete</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS + Script for Modal Delete -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var deleteModal = document.getElementById('deleteModal');
                var confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

                // Update the delete link each time the modal is shown
                deleteModal.addEventListener('show.bs.modal', function (event) {
                    var button = event.relatedTarget;
                    var deleteUrl = button.getAttribute('data-delete-url');
                    confirmDeleteBtn.setAttribute('href', deleteUrl);
                });
            });
        </script>

    </body>
</html>
