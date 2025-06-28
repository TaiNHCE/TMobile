<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Stock Management</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background: #f8f9fa;
                margin: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                height: 100vh;
                width: 240px;
                background: #1e40af;
                z-index: 1000;
                box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            }
            .sidebar-header {
                padding: 20px;
                text-align: center;
                border-bottom: 1px solid rgba(255,255,255,0.1);
            }
            .sidebar-header h4 {
                color: white;
                margin: 0;
                font-weight: 600;
            }
            .sidebar-menu {
                padding: 20px 0;
            }
            .sidebar-menu a {
                display: block;
                padding: 12px 20px;
                color: rgba(255,255,255,0.8);
                text-decoration: none;
                border-left: 3px solid transparent;
            }
            .sidebar-menu a:hover, .sidebar-menu a.active {
                background: rgba(255,255,255,0.1);
                color: white;
                border-left-color: #fff;
            }
            .sidebar-menu i {
                width: 20px;
                margin-right: 10px;
            }
            .main-content {
                margin-left: 240px;
                padding: 20px;
                min-height: 100vh;
            }
            .dashboard-title {
                text-align: center;
                font-weight: bold;
                font-size: 2rem;
                margin: 32px 0 30px 0;
                color: #333;
            }
            .charts-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 32px;
                margin-bottom: 40px;
            }
            .chart-card {
                background: #fff;
                border-radius: 18px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                padding: 28px 18px;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 380px;
                min-width: 320px;
            }
            .btn-primary {
                margin-right: 8px;
                border: none;
                border-radius: 8px;
                padding: 10px 20px;
                font-weight: 500;
            }
            .btn-success, .btn-secondary {
                border: none;
                border-radius: 8px;
                padding: 10px 20px;
                font-weight: 500;
            }
            .form-control, .form-select {
                border-radius: 8px;
                border: 1px solid #ddd;
                padding: 10px 12px;
            }
            .form-control:focus, .form-select:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/View/staff/sideBar.jsp" />

        <div class="main-content">
            <div class="dashboard-title">IMPORT STATISTIC</div>
            <!-- Buttons at top-right -->
            <div class="d-flex justify-content-end mb-4">
                <a href="ImportStock" class="btn btn-success">Import Stock</a>
                <a href="ImportStockHistory" class="btn btn-secondary ms-2">Import History</a>
            </div>

            <div class="charts-grid">
                <div class="chart-card">
                    <canvas id="dailyStockChart" width="340" height="310"></canvas>
                </div>
                <div class="chart-card">
                    <canvas id="monthlyStockChart" width="340" height="310"></canvas>
                </div>
                <div class="chart-card">
                    <canvas id="supplierStockChart" width="340" height="310"></canvas>
                </div>
                <div class="chart-card">
                    <canvas id="productStockChart" width="340" height="310"></canvas>
                </div>
            </div>

            <!-- Chart.js -->
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Daily Import
                const dailyLabels = [<c:forEach items="${dailyImport}" var="entry">"${entry.key}",</c:forEach>];
                const dailyData = [<c:forEach items="${dailyImport}" var="entry">${entry.value},</c:forEach>];

                // Monthly Import
                const monthlyLabels = [<c:forEach items="${monthlyImport}" var="entry">"${entry.key}",</c:forEach>];
                const monthlyData = [<c:forEach items="${monthlyImport}" var="entry">${entry.value},</c:forEach>];

                // Top 5 Suppliers
                const supplierLabels = [<c:forEach items="${supplierImport}" var="entry">"${entry.key}",</c:forEach>];
                const supplierData = [<c:forEach items="${supplierImport}" var="entry">${entry.value},</c:forEach>];

                // Top 5 Products
                const productLabels = [<c:forEach items="${topProductImportShort}" var="entry">"${entry.key}",</c:forEach>];
                const productData = [<c:forEach items="${topProductImportShort}" var="entry">${entry.value},</c:forEach>];
                const chartOpts = {
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {display: true, position: 'top'},
                        title: {display: true}
                    },
                    layout: {padding: 10},
                    scales: {y: {beginAtZero: true, ticks: {callback: (v) => v.toLocaleString()}}}
                };

                new Chart(document.getElementById('dailyStockChart').getContext('2d'), {
                    type: 'bar',
                    data: {
                        labels: dailyLabels,
                        datasets: [{
                                label: 'Import Order',
                                data: dailyData,
                                backgroundColor: '#61a5e8'
                            }]
                    },
                    options: {
                        ...chartOpts,
                        animation: false,
                        plugins: {...chartOpts.plugins, title: {display: true, text: 'Daily Stock Import'}}
                    }
                });

                new Chart(document.getElementById('monthlyStockChart').getContext('2d'), {
                    type: 'bar',
                    data: {
                        labels: monthlyLabels,
                        datasets: [{
                                label: 'Import Order',
                                data: monthlyData,
                                backgroundColor: '#61a5e8'
                            }]
                    },
                    options: {
                        ...chartOpts,
                        animation: false,
                        plugins: {...chartOpts.plugins, title: {display: true, text: 'Monthly Stock Import'}}
                    }
                });

                new Chart(document.getElementById('supplierStockChart').getContext('2d'), {
                    type: 'pie',
                    data: {
                        labels: supplierLabels,
                        datasets: [{
                                data: supplierData,
                                backgroundColor: ['#61a5e8', '#f58787', '#ffcd56', '#77dd77', '#a4a1ff', '#ffb366']
                            }]
                    },
                    options: {
                        ...chartOpts,
                        animation: false,
                        plugins: {...chartOpts.plugins, title: {display: true, text: 'Stock Import by Supplier'}}
                    }
                });

                new Chart(document.getElementById('productStockChart').getContext('2d'), {
                    type: 'bar',
                    data: {
                        labels: productLabels,
                        datasets: [{
                                label: 'Quantity',
                                data: productData,
                                backgroundColor: '#61a5e8'
                            }]
                    },
                    options: {
                        ...chartOpts,
                        animation: false,
                        plugins: {...chartOpts.plugins, title: {display: true, text: 'Stock Import by Product'}},
                        scales: {y: {beginAtZero: true}}
                    }
                });
            </script>
        </div>
    </body>
</html>
