<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String supplierID = (String) request.getAttribute("supplierID");
    String taxId = (String) request.getAttribute("taxId");

    if (supplierID == null) {
        supplierID = request.getParameter("supplierID");
    }
    if (taxId == null) {
        taxId = request.getParameter("taxId");
    }

    if (supplierID == null || taxId == null) {
        response.sendRedirect("ViewSupplier");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Confirm Delete</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            padding: 50px;
        }
        .delete-container {
            background: white;
            max-width: 450px;
            margin: auto;
            padding: 40px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .delete-icon {
            font-size: 50px;
            margin-bottom: 10px;
        }
        .delete-title {
            font-size: 24px;
            font-weight: bold;
            color: #c0392b;
            margin-bottom: 10px;
        }
        .delete-msg, .warning-text {
            font-size: 16px;
            margin-bottom: 15px;
        }
        .supplier-info {
            font-size: 18px;
            margin-bottom: 10px;
            color: #333;
        }
        .btn-group {
            display: flex;
            justify-content: center;
            gap: 20px;
        }
        .btn {
            padding: 10px 30px;
            font-size: 15px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-weight: bold;
        }
        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }
        .btn-cancel {
            background-color: #7f8c8d;
            color: white;
        }
    </style>
</head>
<body>
<div class="delete-container">
    <div class="delete-icon">⚠️</div>
    <div class="delete-title">Confirm Delete</div>
    <div class="delete-msg">
        Are you sure you want to delete this supplier?
    </div>

    <div class="supplier-info">
        <strong>Tax ID:</strong> <%= taxId %>
    </div>

    <div class="warning-text">
        This action cannot be undone!
    </div>

    <form method="post" action="DeleteSupplier">
        <input type="hidden" name="supplierID" value="<%= supplierID %>"/>
        <div class="btn-group">
            <button type="submit" class="btn btn-delete">Delete</button>
            <button type="button" class="btn btn-cancel" onclick="window.location='ViewSupplier'">Cancel</button>
        </div>
    </form>
</div>
</body>
</html>
