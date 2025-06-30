<%-- 
    Document   : banner
    Created on : Jun 16, 2025, 11:48:37 AM
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

        <!-- Banner -->
<<<<<<<< HEAD:src/main/webapp/WEB-INF/View/customer/homePage/section.jsp
        <div class="col-md-12" style = "margin-top: 0.5%">
            <img style = "width: 100%;" src="https://res.cloudinary.com/dgnyskpc3/image/upload/v1750922275/Banner1Dai_zpslth.png" alt="Banner" class="img-fluid">
========
        <div class="col-md-12 category-banner-full2" style = "margin-top: 1%">
            <div class="blue-overlay"></div>
            <div class="banner-text">
                <p class="welcom">Welcome to TShop!</p>
            <p class="Intro">Explore our premium selection of TVs, Refrigerators, Air Conditioners & more</p>

            </div>
>>>>>>>> 36acf90ce7660cfc809f245f3cda279840ec6ce5:target/TMobile-1.0-SNAPSHOT/WEB-INF/View/customer/homePage/banner.jsp
        </div>

    </body>
</html>


<style>
    .category-banner-full2 {
        position: relative;
        border-radius: 15px;
        margin: 0;
        padding: 0;
        max-height: 350px;
        overflow: hidden;
    }

    .category-banner-full2 img {
        width: 99%;
        height: auto;
        display: block;
        border-radius: 15px;
    }

    .blue-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(to right, #B2CFDE, #B8C9D0);
        opacity: 0.6; /* điều chỉnh độ mờ */
        z-index: 1;
        border-radius: 15px;
    }

    .banner-text {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 2;
        text-align: center;
        
    }

    .welcom {
        font-size: 4rem;
        font-weight: 500;
        text-transform: uppercase;
        color: #000000;
        text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
        letter-spacing: 2px;
        white-space: nowrap;
    }
    
    .Intro{
        font-size: 1rem;
        font-weight: 100;
        text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
        letter-spacing: 2px;
        white-space: nowrap;
    }

</style>
