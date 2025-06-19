<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Voucher" %>
<html>
    <head>
        <title>Voucher List</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <!-- Fontawesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <!-- Custom Sidebar -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css">
        <!-- Voucher List Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/voucherList.css">
        
        <%@ page import="java.text.NumberFormat" %>
        <%
            NumberFormat currencyVN = NumberFormat.getInstance(new Locale("vi", "VN"));
        %>

    </head>
    <body>
        <div class="container">
            <jsp:include page="../sideBar.jsp" />           
            <div class="wrapper">
                <main class="main-content">
                    <h1 class="fw-bold mb-4">Vouchers</h1>

                    <!-- Search + Create -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <form class="d-flex" method="get" action="Voucher">
                            <input type="text" name="searchCode" class="form-control me-2" placeholder="Find by code ..."
                                   value="<%= request.getParameter("searchCode") != null ? request.getParameter("searchCode") : ""%>" />
                            <button class="btn btn-primary me-2" type="submit">
                                <i class="fas fa-search"></i>Search</button>
                            <a href="Voucher" class="btn btn-secondary"><i class="fas fa-times"></i> Clear</a>
                        </form>
                        <a href="Voucher?action=create" class="btn btn-success"> <i class="fas fa-plus"></i> Create</a>
                    </div>

                    <!-- Voucher Table -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover rounded-3 overflow-hidden shadow-sm">
                            <thead class="text-white" style="background-color: #1E56A0;">
                                <tr>
                                    <th>ID</th>
                                    <th>Code</th>
                                    <th>Discount (%)</th>
                                    <th>Expiry</th>
                                    <th>Min Order</th>
                                    <th>Max Discount</th>
                                    <th>Usage Limit</th>
                                    <th>Used</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Voucher> list = (List<Voucher>) request.getAttribute("voucherList");
                                    if (list != null && !list.isEmpty()) {
                                        for (Voucher v : list) {
                                %>
                                <tr>
                                    <td><%= v.getVoucherID()%></td>
                                    <td><%= v.getCode()%></td>
                                    <td><%= v.getDiscountPercent()%></td>
                                    <td><%= v.getExpiryDate()%></td>
                                    <td><%= currencyVN.format(v.getMinOrderAmount()) + " đ"%></td>
                                    <td><%= currencyVN.format(v.getMaxDiscountAmount()) + " đ"%></td>
                                    <td><%= v.getUsageLimit()%></td>
                                    <td><%= v.getUsedCount()%></td>
                                    <td>
                                        <span class="badge <%= v.isActive() ? "bg-success" : "bg-danger"%>">
                                            <%= v.isActive() ? "Active" : "Inactive"%>
                                        </span>
                                    </td>
                                    <td>
                                        <a href="Voucher?action=detail&id=<%= v.getVoucherID()%>" class="btn btn-info btn-sm">
                                            <i class="fa-solid fa-eye"></i> View
                                        </a>
                                        <a href="Voucher?action=edit&id=<%= v.getVoucherID()%>" class="btn btn-warning btn-sm">

                                            <i class="fas fa-edit"></i>  Edit
                                        </a>
                                        <a href="#"
                                           class="btn btn-danger btn-sm"
                                           data-bs-toggle="modal"
                                           data-bs-target="#deleteModal"
                                           data-delete-url="Voucher?action=delete&id=<%= v.getVoucherID()%>">
                                            <i class="fa-solid fa-trash"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="10" class="text-center text-muted">No vouchers found!</td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
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
