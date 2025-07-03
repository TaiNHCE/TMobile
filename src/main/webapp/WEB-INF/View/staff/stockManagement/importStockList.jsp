<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Import Stock History</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <!-- Sidebar CSS (nếu cần) -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList5.css">
    </head>
    <body>
        <div class="container">
            <jsp:include page="/WEB-INF/View/staff/sideBar.jsp" />
            <div class="wrapper">
                <main class="main-content">
                    <h1>Import Stock History</h1>
                    <button class="create-btn" style="float: right; margin-bottom: 12px;" onclick="location.href = 'ImportStock'">+ New Import</button>
                    <form class="search-form" method="get" style="clear: both;">
                        <input
                            type="date"
                            name="from"
                            placeholder="From Date"
                            value="${from != null ? from : ''}" />
                        <input
                            type="date"
                            name="to"
                            placeholder="To Date"
                            value="${to != null ? to : ''}" />
                        <select name="supplierId">
                            <option value="">-- All Suppliers --</option>
                            <c:forEach items="${suppliers}" var="s">
                                <option value="${s.supplierID}" <c:if test="${supplierId != null && supplierId == s.supplierID}">selected</c:if>>${s.name}</option>
                            </c:forEach>
                        </select>
                        <button type="submit" class="search-btn">Filter</button>
                    </form>
                    <table aria-label="Import Stock History table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Import Date</th>
                                <th>Supplier</th>
                                <th>Total Amount</th>
                                <th class="text-center">Staff ID</th>
                                <th class="text-center">Detail</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${importHistory}" var="imp" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td><fmt:formatDate value="${imp.importDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    <td>${imp.supplier.name}</td>
                                    <td><fmt:formatNumber value="${imp.totalAmount}" type="currency" currencySymbol="₫"/></td>
                                    <td class="text-center">${imp.staffId}</td>
                                    <td class="action-col" style="justify-content: center;">
                                        <a href="ImportHistoryDetail?id=${imp.ioid}" class="btn btn-primary">Detail</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty importHistory}">
                                <tr>
                                    <td colspan="7" class="text-center">No import history found!</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                    <div class="text-end" style="margin-top:20px ; margin-bottom: 20px;">
                        <a href="ImportStatistic" class="btn btn-secondary me-2">Back</a>
                    </div>

                </main>
            </div>
        </div>
    </body>
</html>
