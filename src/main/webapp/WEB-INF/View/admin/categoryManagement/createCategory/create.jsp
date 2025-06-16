<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create New Category</title>
</head>
<body>
    <div style="display: flex; align-items: center; gap: 10px; margin-left: 21.5%; margin-bottom: 3%; margin-top: 3%">
        <h1 class="display-5 fw-bold" style="font-size: 320%; margin: 0;">Category</h1>
        <span style="font-size: 120%; color: gray; margin-top: 4%;">Add New Category</span>
    </div>

    <form action="${pageContext.request.contextPath}/CreateCategory" method="post" style="margin-left: 21.5%; width: 75%;">
        <!-- Category Name -->
        <div style="border-radius: 12px; border: 1px solid #ccc; margin-bottom: 3%; padding: 10px;">
            <h2 style="margin-left: 1%;">Category Name</h2>
            <hr>
            <div class="mb-3">
                <label for="categoryName" class="form-label">Category Name</label>
                <input type="text" class="form-control" name="categoryName" id="categoryName" placeholder="Enter the name of category" required />
            </div>
        </div>

        <!-- Category Detail -->
        <div style="border-radius: 12px; border: 1px solid #ccc; padding: 10px; margin-bottom: 20px;">
            <h2 style="margin-left: 1%;">Category Detail</h2>
            <hr>
            <div class="mb-3">
                <label for="categoryDetail" class="form-label">Category Detail</label>
                <input type="text" class="form-control" name="categoryDetail" id="categoryDetail" placeholder="Enter the category detail" required />
            </div>
        </div>

        <button type="submit" style="padding: 10px 20px; font-size: 16px; border-radius: 6px; cursor: pointer;">
            Create Category
        </button>
    </form>
</body>
</html>
