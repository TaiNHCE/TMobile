<%-- 
    Document   : adminDashboard
    Created on : Jun 13, 2025, 11:34:36 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Dashboard - E-commerce System</title>
        <!-- Bootstrap CDN -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <!-- Fontawesome CDN -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <!-- Sidebar CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css">

        <!-- Dashboard CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/adminDashboard.css">
    </head>
    <body>
        <div class="container">
            <jsp:include page="sideBar.jsp" />

            <main class="main-content">
                <header class="header">
                    <div class="header-left">
                        <h1>Dashboard</h1>
                    </div>
                    <div class="user-info">
                        <div class="user-avatar">AD</div>
                        <div class="user-details">
                            <h3>Admin User</h3>
                            <p>Administrator</p>
                        </div>
                        <button class="logout-btn" onclick="alert('Logged out successfully!'); window.location.href = 'login.jsp';">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </button>
                    </div>
                </header>

                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-header">
                            Total Staff
                            <span class="stat-icon"><i class="fas fa-user-tie"></i></span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-header">
                            Total Products
                            <span class="stat-icon"><i class="fas fa-box"></i></span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-header">
                            Total Customers
                            <span class="stat-icon"><i class="fas fa-users"></i></span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-header">
                            Monthly Revenue
                            <span class="stat-icon"><i class="fas fa-chart-line"></i></span>
                        </div>
                    </div>
                </div>

                <div class="content-area">
                    <div class="content-header">
                        Recent Admin Activities
                    </div>
                    <div class="content-body">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Time</th>
                                    <th>Activity</th>
                                    <th>User</th>
                                    <th>Module</th>
                                    <th>Status</th>
                                </tr>
                            </thead>

                        </table>
                    </div>
                </div>
            </main>
        </div>
    </body>
</html>