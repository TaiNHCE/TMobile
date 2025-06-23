<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.RevenueStatistic"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Revenue Statistics</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/revenueStatistic.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            .chart-desc {
                font-size: 15px;
                font-weight: bold;
                color: #444;
                margin-top: 10px;
                margin-bottom: 20px;
            }
            .chart-box {
                margin-bottom: 32px;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="main-content-flex">
                <div class="sidebar-area">
                    <jsp:include page="../sideBar.jsp"/>
                </div>
                <div class="content-area">
                    <h1>REVENUE</h1>

                    <%
                        String message = (String) request.getAttribute("message");
                        String statType = (String) request.getAttribute("statType");
                        ArrayList<RevenueStatistic> stats = (ArrayList<RevenueStatistic>) request.getAttribute("revenueStatistics");

                        ArrayList<RevenueStatistic> chartDayData = (ArrayList<RevenueStatistic>) request.getAttribute("chartDayData");
                        ArrayList<RevenueStatistic> chartMonthData = (ArrayList<RevenueStatistic>) request.getAttribute("chartMonthData");

                        // ==== Danh sách category cố định ====
                        List<String> fixCategories = Arrays.asList("Phone", "Laptop", "Accessories", "Watch");
                        Map<String, Long> categoryRevenueDay = new LinkedHashMap<>();
                        Map<String, Long> categoryRevenueMonth = new LinkedHashMap<>();
                        for (String cat : fixCategories) {
                            categoryRevenueDay.put(cat, 0L);
                            categoryRevenueMonth.put(cat, 0L);
                        }
                        // ==== Gán doanh thu cho từng category (nếu có) ====
                        if (chartDayData != null) {
                            for (RevenueStatistic r : chartDayData) {
                                if (categoryRevenueDay.containsKey(r.getCategoryName()))
                                    categoryRevenueDay.put(r.getCategoryName(), r.getTotalRevenue());
                            }
                        }
                        if (chartMonthData != null) {
                            for (RevenueStatistic r : chartMonthData) {
                                if (categoryRevenueMonth.containsKey(r.getCategoryName()))
                                    categoryRevenueMonth.put(r.getCategoryName(), r.getTotalRevenue());
                            }
                        }

                        StringBuilder dayLabels = new StringBuilder();
                        StringBuilder dayData = new StringBuilder();
                        for (String cat : fixCategories) {
                            dayLabels.append("\"").append(cat).append("\",");
                            dayData.append(categoryRevenueDay.get(cat)).append(",");
                        }
                        if (dayLabels.length() > 0) dayLabels.setLength(dayLabels.length() - 1);
                        if (dayData.length() > 0) dayData.setLength(dayData.length() - 1);

                        StringBuilder monthLabels = new StringBuilder();
                        StringBuilder monthData = new StringBuilder();
                        for (String cat : fixCategories) {
                            monthLabels.append("\"").append(cat).append("\",");
                            monthData.append(categoryRevenueMonth.get(cat)).append(",");
                        }
                        if (monthLabels.length() > 0) monthLabels.setLength(monthLabels.length() - 1);
                        if (monthData.length() > 0) monthData.setLength(monthData.length() - 1);
                    %>

                    <% if (message != null) {%>
                    <div class="alert alert-danger text-center"><%= message%></div>
                    <% } %>

                    <table class="table table-bordered text-center align-middle">
                        <thead>
                            <tr>
                                <th>Time Period</th>
                                <th>Total Orders</th>
                                <th>Total Products Sold</th>
                                <th>Total Revenue (₫)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (stats != null && !stats.isEmpty()) {
                                    for (RevenueStatistic r : stats) {
                                        String label = "N/A";
                                        if ("month".equals(statType)) {
                                            label = String.format("%02d/%d", r.getOrderMonth(), r.getOrderYear());
                                        } else if ("day".equals(statType)) {
                                            label = new java.text.SimpleDateFormat("dd/MM/yyyy").format(r.getOrderDate());
                                        } else if ("category".equals(statType)) {
                                            label = r.getCategoryName();
                                        }
                            %>
                            <tr>
                                <td><%= label%></td>
                                <td><%= r.getTotalOrder()%></td>
                                <td><%= r.getTotalProductsSold()%></td>
                                <td><%= String.format("%,d ₫", r.getTotalRevenue())%></td>
                            </tr>
                            <% }
                            } else { %>
                            <tr><td colspan="4">No revenue data available.</td></tr>
                            <% }%>
                        </tbody>
                    </table>

                    <div class="chart-container">
                        <div class="chart-box">
                            <h5 class="text-center">Revenue by Category (Latest Day)</h5>
                            <canvas id="dayChart"></canvas>
                        </div>
                        <div class="chart-box">
                            <h5 class="text-center">Revenue by Category (Latest Month)</h5>
                            <canvas id="monthChart"></canvas>
                        </div>
                    </div>

                    <script>
                        const barColors = [
                            "#14dbff", // Phone
                            "#ffe53b", // Laptop
                            "#bbbbbb", // Accessories
                            "#14ffb1"  // Watch
                        ];
                        // Dữ liệu cho biểu đồ ngày
                        const dayLabels = [<%= dayLabels.toString()%>];
                        const dayData = [<%= dayData.toString()%>];
                        // Dữ liệu cho biểu đồ tháng
                        const monthLabels = [<%= monthLabels.toString()%>];
                        const monthData = [<%= monthData.toString()%>];

                        function renderChart(canvasId, labels, data) {
                            new Chart(document.getElementById(canvasId), {
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
                                    animation: false,
                                    plugins: {legend: {display: false}},
                                    scales: {
                                        x: {
                                            grid: {display: false, drawBorder: false},
                                            ticks: {
                                                color: "#a7a7a7",
                                                font: {size: 14, weight: '400', family: "'Montserrat', Arial, sans-serif"}
                                            }
                                        },
                                        y: {
                                            grid: {display: false},
                                            ticks: {
                                                callback: val => val.toLocaleString() + ' ₫'
                                            },
                                            beginAtZero: true,
                                            min: 0
                                        }
                                    }
                                }
                            });
                        }

                        renderChart('dayChart', dayLabels, dayData);
                        renderChart('monthChart', monthLabels, monthData);
                    </script>
                </div>
            </div>
        </div>
    </body>
</html>
