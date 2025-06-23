<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Stock Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <style>
        body { background: #f8f9fa; }
        .dashboard-title { text-align: center; font-weight: bold; font-size: 2rem; margin: 32px 0 30px 0; }
        .charts-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 32px;
            margin-bottom: 40px;
        }
        .chart-card {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.07);
            padding: 28px 18px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 380px;
            min-width: 320px;
        }
        @media (max-width: 991px) {
            .charts-grid { grid-template-columns: 1fr; }
        }
        .filter-form { margin-bottom: 25px; }
        .table-responsive { background: white; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.10); }
        .btn-primary { margin-right: 8px; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="dashboard-title">STOCK MANAGEMENT</div>
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
        <!-- Filter Form -->
        <form class="row g-3 filter-form" method="get" action="ImportStatistic">
            <div class="col-auto">
                <label>From:</label>
                <input type="date" class="form-control" name="fromDate"/>
            </div>
            <div class="col-auto">
                <label>To:</label>
                <input type="date" class="form-control" name="toDate"/>
            </div>
            <div class="col-auto">
                <label>Supplier:</label>
                <select name="supplier" class="form-select">
                    <option value="All">All</option>
                    <c:forEach items="${supplierImport}" var="entry">
                        <option value="${entry.key}">${entry.key}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-auto d-flex align-items-end">
                <button type="submit" class="btn btn-primary">Apply Filter</button>
                <button type="button" class="btn btn-success" onclick="exportTableToExcel('stockTable', 'stock_import')">Export File</button>
            </div>
        </form>
        <!-- Stock Table -->
        <div class="table-responsive">
            <table class="table table-bordered" id="stockTable">
                <thead class="table-primary">
                    <tr>
                        <th>Import ID</th>
                        <th>Staff Name</th>
                        <th>Date</th>
                        <th>Supplier</th>
                        <th>Amount (₫)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${inventoryList}">
                        <tr>
                            <td>${item.productId}</td>
                            <td>${item.fullName}</td>
                            <td><fmt:formatDate value="${item.importDate}" pattern="yyyy-MM-dd"/></td>
                            <td>${item.supplierName}</td>
                            <td><fmt:formatNumber value="${item.productImportPrice}" type="currency" currencySymbol="₫"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // nhap theo ngay
        const dailyLabels = [<c:forEach items="${dailyImport}" var="entry">"${entry.key}",</c:forEach>];
        const dailyData = [<c:forEach items="${dailyImport}" var="entry">${entry.value},</c:forEach>];

        // nhap theo thang
        const monthlyLabels = [<c:forEach items="${monthlyImport}" var="entry">"${entry.key}",</c:forEach>];
        const monthlyData = [<c:forEach items="${monthlyImport}" var="entry">${entry.value},</c:forEach>];

        // nhap theo nha cung cap
        const supplierLabels = [<c:forEach items="${supplierImport}" var="entry">"${entry.key}",</c:forEach>];
        const supplierData = [<c:forEach items="${supplierImport}" var="entry">${entry.value},</c:forEach>];

        // du lieu cua product
        const productLabels = [<c:forEach items="${topProductImport}" var="entry">"${entry.key}",</c:forEach>];
        const productData = [<c:forEach items="${topProductImport}" var="entry">${entry.value},</c:forEach>];

        // bieu do
        const chartOpts = {
            maintainAspectRatio: false,
            plugins: { 
                legend: { display: true, position: 'top' }, 
                title: { display: true } 
            },
            layout: { padding: 10 },
            scales: { y: { beginAtZero: true, ticks: { callback: (v) => v.toLocaleString() } } }
        };

        // so luong nhap hang ngay
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
                plugins: { ...chartOpts.plugins, title: { display: true, text: 'Daily Stock Import' } }
            }
        });

        // so luong nhap hang ngay
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
                plugins: { ...chartOpts.plugins, title: { display: true, text: 'Monthly Stock Import' } }
            }
        });

        // bieu do tron nhap hang boi nha cung cap
        new Chart(document.getElementById('supplierStockChart').getContext('2d'), {
            type: 'pie',
            data: {
                labels: supplierLabels,
                datasets: [{
                    data: supplierData,
                    backgroundColor: ['#61a5e8','#f58787','#ffcd56','#77dd77','#a4a1ff','#ffb366']
                }]
            },
            options: {
                ...chartOpts,
                plugins: { ...chartOpts.plugins, title: { display: true, text: 'Stock Import by Supplier' } }
            }
        });

        // nhap hang boi san pham
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
                plugins: { ...chartOpts.plugins, title: { display: true, text: 'Stock Import by Product' } },
                scales: { y: { beginAtZero: true } }
            }
        });

        // xuat file excel
        function exportTableToExcel(tableID, filename = '') {
            var downloadLink;
            var dataType = 'application/vnd.ms-excel';
            var tableSelect = document.getElementById(tableID);
            var tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');
            filename = filename ? filename + '.xls' : 'excel_data.xls';
            downloadLink = document.createElement("a");
            document.body.appendChild(downloadLink);
            if (navigator.msSaveOrOpenBlob) {
                var blob = new Blob(['\ufeff', tableHTML], { type: dataType });
                navigator.msSaveOrOpenBlob(blob, filename);
            } else {
                downloadLink.href = 'data:' + dataType + ', ' + tableHTML;
                downloadLink.download = filename;
                downloadLink.click();
            }
        }
    </script>
</body>
</html>
