<%--<jsp:include page="/sideBar.jsp" />--%>

<head>
    <style>
        body {
            background-color: #F2F4F7 !important;
            padding: 0px !important;
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

    <jsp:include page="/WEB-INF/View/customer/homePage/section.jsp" />
    <div class = "container-fluid">
        <jsp:include page="/WEB-INF/View/customer/homePage/smallBanner.jsp" />
        <jsp:include page="/WEB-INF/View/customer/homePage/newProduct.jsp" />
        <jsp:include page="/WEB-INF/View/customer/homePage/bestSellerProduct.jsp" />
        <jsp:include page="/WEB-INF/View/customer/homePage/banner2.jsp" />
        <jsp:include page="/WEB-INF/View/customer/homePage/discountProduct.jsp" />
        <jsp:include page="/WEB-INF/View/customer/homePage/featuredProduct.jsp" />
    </div>
    <jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />
</body>



