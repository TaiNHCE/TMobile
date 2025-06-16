

<head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title></title>
        <!-- Bootstrap CDN -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <!-- Fontawesome CDN -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <!-- Sidebar CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/sideBar.css">

        <!-- Dashboard CSS -->
        
    </head>

<div class="sidebar-overlay" id="sidebarOverlay"></div>
<nav class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <h2><i class="fas fa-store"></i> <span>TMobile</span></h2>
    </div>
    <ul class="nav-menu">
        <li class="nav-item">
            <a href="adminDashboad.jsp" class="nav-link active">
                <i class="fas fa-tachometer-alt"></i> <span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="staff-management.jsp" class="nav-link">
                <i class="fas fa-user-tie"></i> <span>Staff Management</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="product-management.jsp" class="nav-link">
                <i class="fas fa-box"></i> <span>Product Management</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="customer-management.jsp" class="nav-link">
                <i class="fas fa-users"></i> <span>Customer Management</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="CategoryView" class="nav-link">
                <i class="fas fa-tags"></i> <span>Category Management</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="voucher-management.jsp" class="nav-link">
                <i class="fas fa-ticket-alt"></i> <span>Voucher Management</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="ViewSupplier" class="nav-link">
                <i class="fas fa-truck"></i> <span>Supplier Management</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="Inventory" class="nav-link">
                <i class="fas fa-warehouse"></i> <span>Inventory Statistics</span>
            </a>
        </li>
       
    </ul>
</nav>
