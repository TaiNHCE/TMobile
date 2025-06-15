<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Staff Dashboard - TMobile Store</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f7fa;
                color: #333;
            }

            .container {
                display: flex;
                min-height: 100vh;
            }

            /* Sidebar */
            .sidebar {
                width: 250px;
                background: linear-gradient(180deg, #1e3a8a 0%, #1e40af 100%);
                color: white;
                padding: 20px 0;
            }

            .logo {
                text-align: center;
                padding: 20px;
                border-bottom: 1px solid rgba(255,255,255,0.1);
            }

            .logo h2 {
                font-size: 20px;
                color: #00bcd4;
            }

            .nav-menu {
                padding: 20px 0;
            }

            .nav-item {
                margin: 5px 15px;
                border-radius: 8px;
            }

            .nav-item.active {
                background: #00bcd4;
            }

            .nav-link {
                display: flex;
                align-items: center;
                padding: 12px 15px;
                color: white;
                text-decoration: none;
            }

            .nav-link:hover {
                background: rgba(255,255,255,0.1);
                text-decoration: none;
                color: white;
            }

            .nav-link i {
                margin-right: 10px;
                width: 20px;
            }

            /* Main Content */
            .main-content {
                flex: 1;
                background-color: #f8fafc;
            }

            /* Header */
            .header {
                background: white;
                padding: 20px 30px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .header h1 {
                font-size: 24px;
                color: #1e40af;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                background: #00bcd4;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: bold;
            }

            .logout-btn {
                background: #ef4444;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 6px;
                cursor: pointer;
                text-decoration: none;
            }

            .logout-btn:hover {
                background: #dc2626;
                color: white;
            }

            /* Dashboard Content */
            .dashboard-content {
                padding: 30px;
            }

            /* Stats Grid */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .stat-info h3 {
                font-size: 14px;
                color: #64748b;
                margin-bottom: 5px;
                text-transform: uppercase;
            }

            .stat-info .number {
                font-size: 28px;
                font-weight: bold;
                color: #1e40af;
            }

            .stat-icon {
                width: 50px;
                height: 50px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 20px;
                color: white;
            }

            .stat-icon.orders {
                background: #00bcd4;
            }
            .stat-icon.products {
                background: #4caf50;
            }
            .stat-icon.stock {
                background: #ff9800;
            }
            .stat-icon.customers {
                background: #9c27b0;
            }

            /* Quick Actions */
            .quick-actions {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 15px;
                margin-bottom: 30px;
            }

            .action-btn {
                background: white;
                border: 2px solid #e2e8f0;
                padding: 20px;
                border-radius: 10px;
                text-align: center;
                cursor: pointer;
                text-decoration: none;
                color: #64748b;
                display: block;
            }

            .action-btn:hover {
                border-color: #00bcd4;
                background: #f0fdff;
                color: #00bcd4;
                text-decoration: none;
            }

            .action-btn i {
                font-size: 20px;
                margin-bottom: 8px;
                display: block;
            }

            /* Activity Section */
            .activity-section {
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .activity-header {
                background: #00bcd4;
                color: white;
                padding: 15px 20px;
                font-size: 16px;
                font-weight: 600;
            }

            .activity-table {
                width: 100%;
                border-collapse: collapse;
            }

            .activity-table th {
                background: #f8fafc;
                padding: 12px 20px;
                text-align: left;
                font-weight: 600;
                color: #475569;
                font-size: 14px;
            }

            .activity-table td {
                padding: 12px 20px;
                border-bottom: 1px solid #f1f5f9;
                color: #64748b;
            }

            .activity-table tr:hover {
                background: #f8fafc;
            }

            .status-badge {
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
            }

            .status-success {
                background: #dcfce7;
                color: #166534;
            }
            .status-pending {
                background: #fef3c7;
                color: #92400e;
            }
            .status-processing {
                background: #dbeafe;
                color: #1e40af;
            }

            .btn-sm {
                padding: 4px 8px;
                font-size: 12px;
                border-radius: 4px;
                text-decoration: none;
                background: #f1f5f9;
                color: #475569;
                border: 1px solid #e2e8f0;
            }

            .btn-sm:hover {
                background: #e2e8f0;
                text-decoration: none;
            }

            
        </style>

    </head>
    <body>
        <div class="container">
            <!-- Include Sidebar -->
            <jsp:include page="sideBar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <!-- Header -->
                <div class="header">
                    <h1>Staff Dashboard</h1>
                    <div class="user-info">
                        <div class="user-avatar">
                            ${not empty sessionScope.user.firstName ? sessionScope.user.firstName.charAt(0) : 'S'}${not empty sessionScope.user.lastName ? sessionScope.user.lastName.charAt(0) : 'T'}
                        </div>
                        <div>
                            <h4>${not empty sessionScope.user ? sessionScope.user.firstName : 'John'} ${not empty sessionScope.user ? sessionScope.user.lastName : 'Smith'}</h4>
                            <p>Sales Staff</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin: 0;">
                            <button type="submit" class="logout-btn">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Dashboard Content -->
                <div class="dashboard-content">
                    <!-- Quick Actions -->
                    <div class="quick-actions">
                        <a href="${pageContext.request.contextPath}/staff/orders/create" class="action-btn">
                            <i class="fas fa-plus-circle"></i>
                            <strong>Create Order</strong>
                        </a>
                        <a href="${pageContext.request.contextPath}/staff/stock/view" class="action-btn">
                            <i class="fas fa-search"></i>
                            <strong>Check Stock</strong>
                        </a>
                        <a href="${pageContext.request.contextPath}/staff/customers/add" class="action-btn">
                            <i class="fas fa-user-plus"></i>
                            <strong>Add Customer</strong>
                        </a>
                        <a href="${pageContext.request.contextPath}/staff/feedback/view" class="action-btn">
                            <i class="fas fa-star"></i>
                            <strong>View Feedback</strong>
                        </a>
                    </div>

                    <!-- Stats Grid -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-info">
                                <h3>Today's Orders</h3>
                                <div class="number">${todayOrders != null ? todayOrders : 0}</div>
                            </div>
                            <div class="stat-icon orders">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <h3>Products Sold</h3>
                                <div class="number">${productsSold != null ? productsSold : 0}</div>
                            </div>
                            <div class="stat-icon products">
                                <i class="fas fa-box"></i>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <h3>Low Stock</h3>
                                <div class="number">${lowStockAlerts != null ? lowStockAlerts : 0}</div>
                            </div>
                            <div class="stat-icon stock">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <h3>New Customers</h3>
                                <div class="number">${newCustomers != null ? newCustomers : 0}</div>
                            </div>
                            <div class="stat-icon customers">
                                <i class="fas fa-users"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Activities -->
                    <div class="activity-section">
                        <div class="activity-header">
                            <i class="fas fa-clock"></i> Recent Activities
                        </div>
                        <table class="activity-table">
                            <thead>
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
                                                          ${activity.status == 'Completed' ? 'status-success' : 
                                                            activity.status == 'Pending' ? 'status-pending' : 
                                                            'status-processing'}">
                                                              ${activity.status}
                                                          </span>
                                                    </td>
                                                    <td><a href="${activity.actionUrl}" class="btn-sm">View</a></td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" class="text-center text-muted">No recent activities available.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </body>
    </html>
