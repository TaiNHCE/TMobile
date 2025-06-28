<body>

    <div class="main-content">
        <jsp:include page="/sideBar.jsp"/>
        <div>
            <jsp:include page="/WEB-INF/View/admin/productManagement/updateProduct/updateInfo/productTitle.jsp" />
        </div>
        <div style = "margin-left: 4%;">
            <jsp:include page="/WEB-INF/View/admin/productManagement/updateProduct/updateInfo/update.jsp" />
        </div>
    </div>

    <style>
        .sidebar-wrapper {
            width: 220px;
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            background-color: #232946;
            z-index: 10;
        }

        .main-content {
            margin-left: 220px; /* Phù h?p v?i chi?u r?ng sidebar */
            padding: 30px;
            min-height: 100vh;
            background-color: #f8f9fa;
            overflow-x: hidden;
        }

    </style>
</body>
