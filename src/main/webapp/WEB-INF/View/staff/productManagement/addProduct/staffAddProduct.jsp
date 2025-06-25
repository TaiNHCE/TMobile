<%-- 
    Document   : staffAddProduct
    Created on : Jun 24, 2025, 10:43:57 AM
    Author     : HP - Gia Khiêm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="addProduct" method="post" enctype="multipart/form-data">
            <div class = "container" style = "display: flex">
                <jsp:include page="/WEB-INF/View/staff/productManagement/addProduct/imgProduct.jsp" />
                <jsp:include page="/WEB-INF/View/staff/productManagement/addProduct/productInfo.jsp" />
                <jsp:include page="/WEB-INF/View/staff/productManagement/addProduct/productDetail.jsp" />
            </div>
            <button type="submit">Add</button>
        </form>
    </body>
</html>
