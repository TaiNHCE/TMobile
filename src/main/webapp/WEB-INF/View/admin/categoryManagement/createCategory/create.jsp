<%-- 
    Document   : createCategory
    Created on : Jun 15, 2025, 12:44:49 AM
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
        <div style="display: flex; align-items: center; gap: 10px; margin-left: 21.5%; margin-bottom: 3%;  margin-top: 3%">
            <h1 class = "display-5 fw-bold" style="font-size: 320%; margin: 0;">Category</h1>
            <span style="font-size: 120%; color: gray; margin-top: 4%;">Add New Category</span>
        </div>

        <!--            <== Category name==>-->
        <div style = "margin-left: 21.5%; border-radius: 12px; border: 1px solid #ccc; width: 75%; margin-bottom: 3%; ">
            <h2 style = "margin-left: 1%;">
                Category Name
            </h2>
            <hr>
            <div class="mb-3">
                <label class="form-label">Category Name</label>
                <input type="text" class="form-control" name="categoryName" id="categoryName"  placeholder="Enter the name of category" required  />
            </div>

        </div>
        <!--            <== Category name==>-->

        <!--            <== Category detail==>-->
        <div style="margin-left: 21.5%; border-radius: 12px; border: 1px solid #ccc; width: 75%;">

            <h2 style="margin-left: 1%;">Category Detail</h2>
            <hr>

            <div class="mb-3">
                <label class="form-label">Category Detail</label>
                <input type="text" class="form-control" name="categoryDetail" id="categoryDetail"  placeholder="Enter the category" required  />
            </div>

        </div>
        <!--            <== Category detail==>-->

    </body>
</html>
