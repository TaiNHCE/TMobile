<html>
    <head>
        <title>Sidebar + Category View</title>

    </head>
    <body>
        <div class="container">
            <!-- Sidebar bên trái -->
            <div class="sidebar">
                <jsp:include page="/sideBar.jsp" />
            </div>

            <!-- Category View bên ph?i -->
            <div style = "margin-left: 20%;">
                <jsp:include page="/WEB-INF/View/admin/categoryManagement/viewCategoryList/CategoryView.jsp" />
            </div>
        </div>
    </body>
</html>
