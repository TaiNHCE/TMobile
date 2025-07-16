
<html>
    <head>
        <style>
            .divAll {
                background-color: #F2F4F7;
                margin: 0;
                padding: 0;
                min-height: 100vh; /* ??m b?o div cao b?ng toàn trang */
            }
        </style>
    </head>   

    <body>
        <div class = "divAll">
            <div class="container">
                <div>
                    <div style = "width: 100%" style = "display: flex">
                        <jsp:include page="/WEB-INF/View/admin/productManagement/updateProduct/updateTechnicalSpecs/productTitle.jsp" />
                    </div>

                    <div style = "width: 100%;">
                        <jsp:include page="/WEB-INF/View/admin/productManagement/updateProduct/updateTechnicalSpecs/update.jsp" />
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
