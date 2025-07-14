<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Banner Page</title>

        <!-- Bootstrap CDN (nếu chưa có) -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

        <style>
            .category-banner-full2 {
                border-radius: 15px;
                overflow: hidden;
                margin: 1% 0;
            }

            .category-banner-full2 img {
                width: 100%;
                height: auto;
                border-radius: 15px;
                display: block;
            }
        </style>
    </head>
    <body>

        <!-- Banner -->
        <div class="row" style = "margin-left: 0.3%;">
            <div class="category-banner-full2" style="margin-top: 1%; width: 48%;">
                <img src="https://res.cloudinary.com/dgnyskpc3/image/upload/v1750919684/Banner5_scpip9.png" alt="Banner 1" class="img-fluid">
            </div>
            <div class="category-banner-full2" style="margin-top: 1%; width: 48%;">
                <img src="https://res.cloudinary.com/dgnyskpc3/image/upload/v1750919682/Banner_5_ayt9h5.png" alt="Banner 2" class="img-fluid">
            </div>
        </div>

    </body>
</html>
