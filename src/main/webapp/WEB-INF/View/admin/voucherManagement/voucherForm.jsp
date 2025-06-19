<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Voucher" %>
<%
    Voucher v = (Voucher) request.getAttribute("voucher");
    boolean isEdit = v != null;
%>
<html>
    <head>
        <title><%= isEdit ? "Update" : "Create"%> Voucher</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <!-- Fontawesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <!-- Sidebar + Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/voucherForm.css">

    </head>
    <body>
        <div class="container-fluid">
            <jsp:include page="../sideBar.jsp" />
            <div class="wrapper" style="margin-left:250px;">
                <main class="main-content p-4">
                    <h2 class="fw-bold mb-4"><%= isEdit ? "Update" : "Create"%> Voucher</h2>

                    <% if (request.getAttribute("error") != null) {%>
                    <div class="alert alert-danger">
                        <%= request.getAttribute("error")%>
                    </div>
                    <% } %>

                    <form method="post" action="Voucher" class="row g-3 needs-validation" novalidate>
                        <% if (isEdit) {%>
                        <input type="hidden" name="id" value="<%= v.getVoucherID()%>" />
                        <% }%>

                        <div class="col-md-6">
                            <label class="form-label">Voucher Code</label>
                            <input type="text" class="form-control" name="code" maxlength="50"
                                   value="<%= isEdit ? v.getCode() : ""%>" required />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Discount Percentage (%)</label>
                            <input type="number" class="form-control" name="discountPercent" min="1" max="100"
                                   value="<%= isEdit ? v.getDiscountPercent() : 0%>" required />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Expiry Date</label>
                            <input type="date" class="form-control" name="expiryDate"
                                   value="<%= isEdit ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(v.getExpiryDate()) : ""%>" required />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Minimum Order Amount</label>

                            <div class="input-group">
                                <input type="number" class="form-control" step="1000" min="0" name="minOrderAmount"
                                       value="<%= isEdit ? String.format("%.0f", v.getMinOrderAmount()).replace(",", "") : 0%>" required />
                                <span class="input-group-text">VNĐ</span>
                            </div>

                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Maximum Discount Amount</label>

                            <div class="input-group">
                                <input type="number" class="form-control" step="1000" min="0" name="maxDiscountAmount"
                                       value="<%= isEdit ? String.format("%.0f", v.getMaxDiscountAmount()).replace(",", "") : 0%>" required />
                                <span class="input-group-text">VNĐ</span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Usage Limit</label>
                            <input type="number" class="form-control" name="usageLimit" min="1"
                                   value="<%= isEdit ? v.getUsageLimit() : 1%>" required />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Used Count</label>
                            <input type="number" class="form-control" name="usedCount" min="0"
                                   value="<%= isEdit ? v.getUsedCount() : 0%>" required />
                        </div>

                        <div class="col-md-6 d-flex align-items-center">
                            <div class="form-check mt-4">
                                <input class="form-check-input" type="checkbox" name="isActive" id="isActive"
                                       <%= isEdit && v.isActive() ? "checked" : ""%> />
                                <label class="form-check-label" for="isActive">
                                    Activate Voucher
                                </label>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="3" maxlength="255"><%= isEdit ? v.getDescription() : ""%></textarea>
                        </div>

                        <div class="col-12">
                            <button type="submit" class="btn btn-primary">
                                <i class="fa-solid fa-save"></i> <%= isEdit ? "Update" : "Create"%>
                            </button>
                            <a href="Voucher" class="btn btn-secondary ms-2">
                                <i class="fa-solid fa-arrow-left"></i> Back
                            </a>
                        </div>
                    </form>
                </main>
            </div>
        </div>
    </body>
</html>
