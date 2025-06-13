<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Suppliers" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Supplier</title>
    <style>
        /* Style giống UI bạn gửi */
        body { font-family: Arial, sans-serif; margin: 40px;}
        .form-container { width: 500px; margin: 0 auto; background: #fff; padding: 32px 40px; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.07);}
        .form-container h2 { margin-bottom: 16px; }
        .form-group { margin-bottom: 16px; }
        label { font-weight: 600; color: #1677ff; display: block; margin-bottom: 4px;}
        input[type="text"], input[type="email"] {
            width: 100%; padding: 8px 12px; border: 1px solid #ccc; border-radius: 6px; font-size: 15px;
        }
        .status-group { display: flex; gap: 24px; margin-top: 8px;}
        .btns { display: flex; gap: 16px; justify-content: center; margin-top: 20px;}
        .btn-create { background: #28a745; color: #fff; border: none; border-radius: 6px; font-weight: bold; padding: 10px 38px; cursor: pointer;}
        .btn-cancel { background: #757575; color: #fff; border: none; border-radius: 6px; font-weight: bold; padding: 10px 38px; cursor: pointer;}
        .error { color: #dc3545; margin-bottom: 10px; }
        .success { color: #28a745; margin-bottom: 10px; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Add Supplier</h2>
        <hr>
        <form method="post" action="CreateSupplier">
            <% if (request.getAttribute("errorMsg") != null) { %>
                <div class="error"><%= request.getAttribute("errorMsg") %></div>
            <% } %>
            <div class="form-group">
                <label for="taxId">Tax ID:</label>
                <input type="text" id="taxId" name="taxId" placeholder="Enter Tax ID" required>
            </div>
            <div class="form-group">
                <label for="name">Company Name:</label>
                <input type="text" id="name" name="name" placeholder="Enter Company Name" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" placeholder="Enter Email">
            </div>
            <div class="form-group">
                <label for="phoneNumber">Phone Number:</label>
                <input type="text" id="phoneNumber" name="phoneNumber" placeholder="Enter Phone Number">
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" placeholder="Enter Address">
            </div>
            <div class="form-group">
                <label>Status:</label>
                <div class="status-group">
                    <label><input type="radio" name="activate" value="1" checked> Activate</label>
                    <label><input type="radio" name="activate" value="0"> Deactivate</label>
                </div>
            </div>
            <div class="btns">
                <button type="submit" class="btn-create">Create</button>
                <button type="button" class="btn-cancel" onclick="window.location='ViewSupplier'">Cancel</button>
            </div>
        </form>
    </div>
</body>
</html>
