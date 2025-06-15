<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.InventoryStatistic"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Inventory Statistics</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            .back-btn {
                background-color: red;
                color: white;
                padding: 8px 12px;
                border: none;
                text-decoration: none;
                border-radius: 5px;
                margin-bottom: 10px;
            }
            h2 {
                text-align: center;
                margin-bottom: 20px;
            }
            .search-form {
                text-align: center;
                margin-bottom: 20px;
            }
            input[type="text"] {
                padding: 8px;
                width: 300px;
                border-radius: 4px;
                border: 1px solid #ccc;
            }
            button {
                padding: 8px 12px;
                background-color: green;
                color: white;
                border: none;
                border-radius: 4px;
                margin-left: 5px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #f4f4f4;
            }
            .status-tag {
                padding: 5px 10px;
                border-radius: 20px;
                color: white;
                font-size: 0.9em;
            }
            .in-stock {
                background-color: #28a745;
            }
            .low-stock {
                background-color: #ffc107;
                color: #000;
            }
            .out-of-stock {
                background-color: #dc3545;
            }
            canvas {
                margin-top: 30px;
                width: 100%;
                max-width: 600px;
                display: block;
                margin-left: auto;
                margin-right: auto;
            }
        </style>
    </head>
    <body>
            <jsp:include page="../sideBar.jsp" />

        <a href="AdminDashboard" class="back-btn">BACK</a>

        <h2>INVENTORY STATISTICS</h2>

        <div class="search-form">
            <form action="InventoryStatistic" method="get">
                <input type="text" name="keyword" placeholder="Search by name, brand, model..."/>
                <button type="submit">Search</button>
            </form>
        </div>

        <%
            String message = (String) request.getAttribute("message");
            ArrayList<InventoryStatistic> stats = (ArrayList<InventoryStatistic>) request.getAttribute("inventoryStatistics");

            if (message != null) {
        %>
        <p style="text-align:center; color:red;"><%= message%></p>
        <%
        } else if (stats != null && !stats.isEmpty()) {
            Map<String, Integer> categoryCount = new HashMap<>();
            for (InventoryStatistic item : stats) {
                String cat = item.getCategoryName();
                categoryCount.put(cat, categoryCount.getOrDefault(cat, 0) + 1);
            }

            StringBuilder labelsJS = new StringBuilder();
            StringBuilder dataJS = new StringBuilder();
            for (Map.Entry<String, Integer> entry : categoryCount.entrySet()) {
                labelsJS.append("\"").append(entry.getKey()).append("\",");
                dataJS.append(entry.getValue()).append(",");
            }
            if (labelsJS.length() > 0) {
                labelsJS.setLength(labelsJS.length() - 1);
            }
            if (dataJS.length() > 0)
                dataJS.setLength(dataJS.length() - 1);
        %>

        <table>
            <tr>
                <th>Category Name</th>
                <th>Brand Name</th>
                <th>Model</th>
                <th>Product Name</th>
                <th>Stock Quantity</th>
                <th>Supplier</th>
                <th>Import Date</th>
                <th>Import Price</th>
                <th>Status</th>
            </tr>
            <%
                for (InventoryStatistic item : stats) {
                    int qty = item.getStockQuantity();
                    String statusClass = qty == 0 ? "out-of-stock" : (qty <= 5 ? "low-stock" : "in-stock");
                    String statusText = qty == 0 ? "OUT OF STOCK" : (qty <= 5 ? "LOW STOCK" : "IN STOCK");
            %>
            <tr>
                <td><%= item.getCategoryName()%></td>
                <td><%= item.getBrandName()%></td>
                <td><%= item.getModelName() != null ? item.getModelName() : "-"%></td>
                <td><%= item.getFullName()%></td>
                <td><%= item.getStockQuantity()%></td>
                <td><%= item.getSupplierName()%></td>
                <td><%= item.getImportDate()%></td>
                <td><%= item.getProductImportPrice()%></td>
                <td><span class="status-tag <%= statusClass%>"><%= statusText%></span></td>
            </tr>
            <%
                }
            %>
        </table>

        <canvas id="categoryChart"></canvas>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            const ctx = document.getElementById('categoryChart').getContext('2d');
            const categoryData = {
                labels: [<%= labelsJS.toString()%>],
                datasets: [{
                        label: 'Product Count by Category',
                        data: [<%= dataJS.toString()%>],
                        backgroundColor: ['#17a2b8', '#ffc107', '#6c757d', '#28a745', '#dc3545']
                    }]
            };

            const config = {
                type: 'bar',
                data: categoryData,
                options: {
                    responsive: true,
                    plugins: {
                        legend: {display: false}
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            precision: 0
                        }
                    }
                }
            };

            new Chart(ctx, config);
        </script>

        <%
            }
        %>

    </body>
</html>
