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
                        <tr><th>Minimum Order Amount</th><td><%= v.getMinOrderAmount()%></td></tr>
                        <tr><th>Maximum Discount Amount</th><td><%= v.getMaxDiscountAmount()%></td></tr>
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

                    <a href="Voucher" class="btn btn-secondary mt-3">
                        <i class="fa-solid fa-arrow-left"></i> Back to List
                    </a>
                </main>
            </div>
        </div>
    </body>
</html>
