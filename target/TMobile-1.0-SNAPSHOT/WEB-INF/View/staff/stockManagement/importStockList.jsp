<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Import Stock History</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <style>
        body { background: #f8f9fa; }
        .main-content { margin: 40px auto; max-width: 1100px; }
        .history-table { background: #fff; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.06);}
        th, td { vertical-align: middle !important; }
        .filter-form { background: #fff; border-radius: 8px; box-shadow: 0 1px 4px rgba(0,0,0,0.03); padding: 18px; margin-bottom: 24px;}
        .btn-success, .btn-primary { border-radius: 8px;}
    </style>
</head>
<body>
<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Import Stock History</h2>
        <a href="ImportStock" class="btn btn-success">+ New Import</a>
    </div>

    <!-- FILTER FORM -->
    <form method="get" class="filter-form row g-3">
        <div class="col-md-3">
            <label for="from" class="form-label">From Date</label>
            <input type="date" id="from" name="from" value="${from}" class="form-control" />
        </div>
        <div class="col-md-3">
            <label for="to" class="form-label">To Date</label>
            <input type="date" id="to" name="to" value="${to}" class="form-control" />
        </div>
        <div class="col-md-4">
            <label for="supplierId" class="form-label">Supplier</label>
            <select name="supplierId" id="supplierId" class="form-select">
                <option value="">-- All Suppliers --</option>
                <c:forEach items="${suppliers}" var="s">
                    <option value="${s.supplierID}" <c:if test="${supplierId != null && supplierId == s.supplierID}">selected</c:if>>${s.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-2 d-flex align-items-end">
            <button type="submit" class="btn btn-primary w-100">Filter</button>
        </div>
    </form>

    <table class="table table-hover history-table">
        <thead class="table-primary">
            <tr>
                <th>#</th>
                <th>Import Date</th>
                <th>Supplier</th>
                <th>Total Amount</th>
                <th>Staff ID</th>
                <th>Status</th>
                <th>Detail</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${importHistory}" var="imp" varStatus="loop">
            <tr>
                <td>${loop.index + 1}</td>
                <td><fmt:formatDate value="${imp.importDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                <td>${imp.supplier.name}</td>
                <td><fmt:formatNumber value="${imp.totalAmount}" type="currency" currencySymbol="₫"/></td>
                <td>${imp.staffId}</td>
                <td>
                    <c:choose>
                        <c:when test="${imp.isCompleted == 1}"><span class="badge bg-success">Completed</span></c:when>
                        <c:otherwise><span class="badge bg-warning text-dark">Pending</span></c:otherwise>
                    </c:choose>
                </td>
                <td> 
                    <a href="ImportHistoryDetail?id=${imp.ioid}" class="btn btn-sm btn-outline-info">View</a>
                </td>
            </tr>
            
        </c:forEach>
        </tbody>
    </table>
        <div class="action-btns">
                <a href="ImportStatistic" class="btn btn-secondary me-2">Back</a>
            </div>
</div>
</body>
</html>
