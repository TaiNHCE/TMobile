
<html>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/supplierList5.css">

    </head>

    <body>

        <jsp:include page="/sideBar.jsp" />
        <div style = "margin-left: 23%; width: 71.5%">
            <jsp:include page="/WEB-INF/View/admin/productManagement/viewProductList/fillterProductList.jsp" />
            <jsp:include page="/WEB-INF/View/admin/productManagement/viewProductList/productList.jsp" />
        </div>
    </body>
</html>