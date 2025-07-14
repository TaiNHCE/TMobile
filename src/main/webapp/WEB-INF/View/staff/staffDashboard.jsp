<%@page import="model.Account"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    Account acc = (Account) session.getAttribute("staff");
    if (acc == null || acc.getRoleID() != 2) {
        response.sendRedirect("LoginStaff");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard - TMobile Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Shared CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/Staff.css">
</head>
<body>

<div class="container">
    <!-- Sidebar -->
    <jsp:include page="sideBar.jsp" />

    <!-- Wrapper + Main -->
    <div class="wrapper">
        <main class="main-content">
            <h1>Staff Dashboard</h1>

            <!-- User Info -->
            <div class="user-info" style="display: flex; align-items: center; gap: 15px; margin-bottom: 20px;">
                <div class="user-avatar bg-success text-white" style="width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                    ${not empty sessionScope.user.firstName ? sessionScope.user.firstName.charAt(0) : 'S'}${not empty sessionScope.user.lastName ? sessionScope.user.lastName.charAt(0) : 'T'}
                </div>
                <div>
                    <h4>${not empty sessionScope.user ? sessionScope.user.firstName : 'John'} ${not empty sessionScope.user ? sessionScope.user.lastName : 'Smith'}</h4>
                    <p style="margin: 0;">Sales Staff</p>
                </div>
                <form action="${pageContext.request.contextPath}/Logout" method="post" style="margin-left: auto;">
                    <button type="submit" class="logout-btn btn btn-danger"><i class="fas fa-sign-out-alt"></i> Logout</button>
                </form>
            </div>

           

            <!-- Stats Grid -->
            <div class="stats-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 30px;">
                <div class="stat-card bg-secondary text-white p-3 rounded">
                    <h5>Today's Orders</h5>
                    <p style="font-size: 1.8rem; font-weight: bold;">${todayOrders != null ? todayOrders : 0}</p>
                </div>
                <div class="stat-card bg-success text-white p-3 rounded">
                    <h5>Products Sold</h5>
                    <p style="font-size: 1.8rem; font-weight: bold;">${productsSold != null ? productsSold : 0}</p>
                </div>
                <div class="stat-card bg-warning text-white p-3 rounded">
                    <h5>Low Stock</h5>
                    <p style="font-size: 1.8rem; font-weight: bold;">${lowStockAlerts != null ? lowStockAlerts : 0}</p>
                </div>
                <div class="stat-card bg-danger text-white p-3 rounded">
                    <h5>New Customers</h5>
                    <p style="font-size: 1.8rem; font-weight: bold;">${newCustomers != null ? newCustomers : 0}</p>
                </div>
            </div>

            <!-- Recent Activities -->
            <div class="activity-section">
                <div class="activity-header bg-primary text-white p-2 rounded-top">
                    <i class="fas fa-clock"></i> Recent Activities
                </div>
                <table class="activity-table table">
                    <thead class="table-primary">
                        <tr>
                            <th>Time</th>
                            <th>Activity</th>
                            <th>Subject</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty recentActivities}">
                                <c:forEach var="activity" items="${recentActivities}">
                                    <tr>
                                        <td><fmt:formatDate value="${activity.timestamp}" pattern="HH:mm" /></td>
                                        <td>${activity.activityType}</td>
                                        <td>${activity.subject}</td>
                                        <td>
                                            <span class="status-badge
                                                  ${activity.status == 'Completed' ? 'status-active' :
                                                    activity.status == 'Pending' ? 'status-inactive' :
                                                    'bg-secondary text-white p-1 rounded'}">
                                                ${activity.status}
                                            </span>
                                        </td>
                                        <td><a href="${activity.actionUrl}" class="btn btn-sm btn-outline-primary">View</a></td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="text-center">No recent activities available.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>

</body>
</html>
