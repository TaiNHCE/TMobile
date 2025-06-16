<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.InventoryStatistic"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Inventory Statistics</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/inventoryStatistic.css">
        <style>
            #categoryChart {
                width: 100% !important;
                max-width: 900px;
                height: 400px;
            }
        </style>
    </head>
    <body>
        <div class="container d-flex">
            <jsp:include page="../sideBar.jsp" />
            <div class="wrapper">

                <h1>INVENTORY STATISTICS</h1>

                <div class="search-form">
                    <form action="InventoryStatistic" method="get">
                        <input type="text" name="keyword" placeholder="Search by name, brand, ..." />
                        <button type="submit">Search</button>
                    </form>
                </div>

                <%
                    String message = (String) request.getAttribute("message");
                    ArrayList<InventoryStatistic> stats = (ArrayList<InventoryStatistic>) request.getAttribute("inventoryStatistics");

                    List<String> fixCategories = Arrays.asList("Phone", "Laptop", "Accessories", "Watch");
                    Map<String, Integer> categoryCount = new LinkedHashMap<>();
                    for (String cat : fixCategories) {
                        categoryCount.put(cat, 0); 
                    }
                    if (stats != null) {
                        for (InventoryStatistic item : stats) {
                            String cat = item.getCategoryName();
                            if (categoryCount.containsKey(cat)) {
                                categoryCount.put(cat, categoryCount.get(cat) + 1);
                            }
                        }
                    }

                    StringBuilder labelsJS = new StringBuilder();
                    StringBuilder dataJS = new StringBuilder();
                    for (String cat : fixCategories) {
                        labelsJS.append("\"").append(cat).append("\",");
                        dataJS.append(categoryCount.get(cat)).append(",");
                    }
                    if (labelsJS.length() > 0) labelsJS.setLength(labelsJS.length() - 1);
                    if (dataJS.length() > 0) dataJS.setLength(dataJS.length() - 1);
                %>

                <table>
                    <thead>
                        <tr>
                            <th>Category Name</th>
                            <th>Brand Name</th>
                            <th>Product Name</th>
                            <th>Stock Quantity</th>
                            <th>Supplier</th>
                            <th>Import Date</th>
                            <th>Import Price</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (stats != null && !stats.isEmpty()) {
                            for (InventoryStatistic item : stats) {
                                int qty = item.getStockQuantity();
                                String statusClass = qty == 0 ? "out-of-stock" : (qty <= 5 ? "low-stock" : "in-stock");
                                String statusText = qty == 0 ? "OUT OF STOCK" : (qty <= 5 ? "LOW STOCK" : "IN STOCK");
                        %>
                        <tr>
                            <td><%= item.getCategoryName()%></td>
                            <td><%= item.getBrandName()%></td>
                            <td><%= item.getFullName()%></td>
                            <td><%= item.getStockQuantity()%></td>
                            <td><%= item.getSupplierName()%></td>
                            <td><%= item.getImportDate()%></td>
                            <td><%= item.getProductImportPrice()%></td>
                            <td><span class="status-tag <%= statusClass%>"><%= statusText%></span></td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="9" class="text-center">No inventory data found.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

                <!-- Biểu đồ 4 cột -->
                <canvas id="categoryChart"></canvas>
                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                <script>
                    const barColors = [
                        "#14dbff", // Phone - xanh
                        "#ffe53b", // Laptop - vàng
                        "#bbbbbb", // Phụ kiện - xám
                        "#14ffb1"  // Đồng hồ - xanh mint
                    ];
                    const labels = [<%= labelsJS.toString() %>];
                    const data = [<%= dataJS.toString() %>];
                    const ctx = document.getElementById('categoryChart').getContext('2d');
                    const config = {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                data: data,
                                backgroundColor: barColors,
                                borderRadius: 16,
                                borderSkipped: false,
                                barPercentage: 0.6,
                                categoryPercentage: 0.6
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: true,
                            plugins: { legend: { display: false }},
                            scales: {
                                x: {
                                    grid: { display: false, drawBorder: false },
                                    ticks: {
                                        color: "#a7a7a7",
                                        font: { size: 16, weight: '400', family: "'Montserrat', Arial, sans-serif" }
                                    }
                                },
                                y: {
                                    grid: { display: false },
                                    ticks: { display: false },
                                    beginAtZero: true,
                                    min: 0
                                }
                            }
                        }
                    };
                    new Chart(ctx, config);
                </script>
            </div>
        </div>
    </body>
</html>
