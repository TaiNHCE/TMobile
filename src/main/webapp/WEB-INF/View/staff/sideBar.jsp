<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
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
            <a href="StaffProduct" class="nav-link">
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
                
                <style> .sidebar {
    width: 220px;
    background: #232946;
    color: #fff;
    min-height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    z-index: 10;
}
.sidebar-header {
    padding: 20px;
    font-size: 1.3rem;
    font-weight: 700;
    letter-spacing: 1px;
    border-bottom: 1px solid #2e3652;
    display: flex;
    align-items: center;
    gap: 10px;
}
.nav-menu {
    list-style: none;
    padding: 0;
    margin: 0;
}
.nav-item {
    margin: 0;
}
.nav-link {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 14px 25px;
    color: #ffffff;
    text-decoration: none;
    font-size: 1rem;
    border-left: 4px solid transparent;
    transition: background .2s, border-left .2s, color .2s;
}
.nav-link:hover,
.nav-link.active {
    background: #35377e;
    color: #fff;
    border-left: 4px solid #eebbc3;
}
</style>
