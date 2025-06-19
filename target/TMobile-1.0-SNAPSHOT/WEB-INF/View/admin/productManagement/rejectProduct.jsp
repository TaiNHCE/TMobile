<%-- 
    Document   : rejectProduct
    Created on : Jun 19, 2025
    Author     : [Your Name]
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reject Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Reject Product</h2>
        <form action="RejectProductServlet" method="post" onsubmit="return confirm('Are you sure you want to reject this product?');">
            <input type="hidden" name="productId" value="<%= request.getParameter("productId") %>">
            <div class="mb-3">
                <label for="title" class="form-label">Notification Title</label>
                <input type="text" class="form-control" id="title" name="title" value="Product Rejection" required>
            </div>
            <div class="mb-3">
                <label for="message" class="form-label">Reason for Rejection</label>
                <textarea class="form-control" id="message" name="message" rows="4" required>Product with ID <%= request.getParameter("productId") %> has been rejected.</textarea>
            </div>
            <button type="submit" class="btn btn-danger">
                <i class="fas fa-times"></i> Reject Product
            </button>
            <a href="ProductList?action=list" class="btn btn-secondary ms-2">
                <i class="fas fa-arrow-left"></i> Cancel
            </a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>