<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Sidebar -->
<div class="sidebar">
    <div class="logo">
        <h2><i class="fas fa-mobile-alt"></i> TMobile</h2>
    </div>
    <nav class="nav-menu">
        <div class="nav-item active">
            <a href="${pageContext.request.contextPath}/staff/dashboard" class="nav-link">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
        </div>
        
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/staff/orders/view" class="nav-link">
                <i class="fas fa-shopping-cart"></i>
                <span>Orders</span>
            </a>
        </div>
        
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/staff/products/view" class="nav-link">
                <i class="fas fa-box"></i>
                <span>Products</span>
            </a>
        </div>
        
        <div class="nav-item">
            <a href="ImportStatistic" class="nav-link">
                <i class="fas fa-warehouse"></i>
                <span>Stock</span>
            </a>
        </div>
        
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/staff/customers/view" class="nav-link">
                <i class="fas fa-users"></i>
                <span>Customers</span>
            </a>
        </div>
         
        
        
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/staff/feedback/view" class="nav-link">
                <i class="fas fa-comments"></i>
                <span>Feedback</span>
            </a>
        </div>
    </nav>
</div>
