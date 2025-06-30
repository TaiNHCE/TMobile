<head>
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        
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
    </style>
</head>

<!-- Sidebar HTML Structure -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <h4>
            <i class="fas fa-mobile-alt"></i>
            TMobile
        </h4>
    </div>
    <div class="sidebar-menu">
    <a href="StaffDashboard" class="nav-link">
        <i class="fas fa-tachometer-alt"></i>
        Dashboard
    </a>
    <a href="/orders" class="nav-link">
        <i class="fas fa-shopping-cart"></i>
        Orders
    </a>
    <a href="/products" class="nav-link">
        <i class="fas fa-box"></i>
        Products
    </a>
    <a href="ImportStatistic" class="nav-link">
        <i class="fas fa-warehouse"></i>
        Stock
    </a>
    <a href="/customers" class="nav-link">
        <i class="fas fa-users"></i>
        Customers
    </a>
    <a href="/feedback" class="nav-link">
        <i class="fas fa-comments"></i>
        Feedback
    </a>
</div>

</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
    const path = window.location.pathname.toLowerCase();
    const navLinks = document.querySelectorAll(".nav-link");
    let found = false;
    navLinks.forEach(link => {
        const href = link.getAttribute("href").toLowerCase().replace(/^\//, '');
        const lastPath = path.split("/").filter(x => x).pop() || '';
        if (lastPath === href.toLowerCase()) {
            navLinks.forEach(l => l.classList.remove("active"));
            link.classList.add("active");
            found = true;
        }
    });
    if (!found && navLinks.length > 0) {
        navLinks.forEach(l => l.classList.remove("active"));
        navLinks[0].classList.add("active");
    }
});

</script>