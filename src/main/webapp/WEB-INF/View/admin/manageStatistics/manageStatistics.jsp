<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.InventoryStatistic"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Statistics</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/manageStatistic.css">

   
        </head>
        <body>
            <div class="container-fluid my-4">
                <div class="main-content-flex">
                    <div class="sidebar-area">
                        <jsp:include page="../sideBar.jsp" /> 
                    </div>
                    <div class="content-area">
                        <h1 class="text-center"><b>MANAGE STATISTICS</b></h1>
                        <div class="d-flex justify-content-center mb-4">
                            <a href="InventoryStatistic" class="stat-btn inventory text-decoration-none text-center d-inline-block">INVENTORY</a>
                            <a href="RevenueStatistic" class="stat-btn revenue text-decoration-none text-center d-inline-block ms-4">REVENUE</a>
                        </div>
                        <div class="custom-box mb-3">
                            <label><i class="fa fa-boxes me-2"></i>PRODUCT INVENTORY SEARCH</label>
                            <form class="search-container" action="ManageStatistic" method="get" autocomplete="off">
                                <input type="text" class="form-control search-inv" name="keyword" placeholder="Search product..." />
                                <button type="submit" class="search-btn"><i class="fa fa-search"></i></button>
                            </form>
                        </div>
                        <%-- Phần hiển thị bảng --%>
                        <%
                            String message = (String) request.getAttribute("message");
                            ArrayList<InventoryStatistic> stats = (ArrayList<InventoryStatistic>) request.getAttribute("inventoryStatistics");
                            if (message != null) {
                        %>
                        <div class="alert alert-danger text-center"><%= message%></div>
                        <%
                            }
                        %>
                        <table class="table table-bordered table-hover align-middle text-center">
                            <thead>
                                <tr>
                                    <th>Product ID</th>
                                    <th>Product Name</th>
                                    <th>Category</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (stats != null && !stats.isEmpty()) {
                                        for (InventoryStatistic item : stats) {
                                            int qty = item.getStockQuantity();
                                            String statusClass = qty == 0 ? "out-stock" : (qty <= 5 ? "low-stock" : "in-stock");
                                            String statusText = qty == 0 ? "OUT OF STOCK" : (qty <= 5 ? "LOW STOCK" : "IN STOCK");
                                %>
                                <tr>
                                    <td><%= item.getProductId()%></td>
                                    <td><%= item.getFullName()%></td>
                                    <td><%= item.getCategoryName()%></td>
                                    <td><%= item.getStockQuantity()%></td>
                                    <td>
                                        <%= item.getProductImportPrice() != null
                                                ? String.format("%,d", item.getProductImportPrice().intValue())
                                                : "-"%>
                                    </td>
                                    <td>
                                        <span class="status-tag <%= statusClass%>"><%= statusText%></span>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="6" class="text-center">No data found.</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </body>
    </html>
