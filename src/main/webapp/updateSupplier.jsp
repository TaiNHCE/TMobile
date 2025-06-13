<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Suppliers" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Supplier</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        .form-label {
            color: #2471A3;
            font-weight: bold;
            width: 130px;
        }
        .form-check-label {
            color: #2471A3;
        }
        .btn-update {
            background-color: #c00;
            color: white;
        }
        .btn-cancel {
            background-color: #888;
            color: white;
        }
        .card {
            margin-top: 40px;
            max-width: 600px;
        }
        .required {
            color: red;
        }
        .form-check-inline .form-check-input {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card shadow">
        <div class="card-body">
            <h3 class="mb-4" style="color:#19335D;">Update Supplier</h3>
            <hr style="border: 2px solid #2471A3; margin-top:-15px;">
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                String successMessage = (String) request.getAttribute("successMessage");
                Suppliers supplier = (Suppliers) request.getAttribute("supplier");
                if (errorMessage != null) {
            %>
                <div class="alert alert-danger"><%= errorMessage %></div>
            <%
                }
                if (successMessage != null) {
            %>
                <div class="alert alert-success"><%= successMessage %></div>
            <%
                }
                if (supplier != null) {
            %>
            <form method="post" action="UpdateSupplier">
                <input type="hidden" name="supplierID" value="<%= supplier.getSupplierID() %>">

                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label form-label">Tax ID:</label>
                    <div class="col-sm-9">
                        <input type="text" name="taxId" class="form-control" value="<%= supplier.getTaxId() %>" readonly>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label form-label">Company Name:</label>
                    <div class="col-sm-9">
                        <input type="text" name="name" class="form-control" value="<%= supplier.getName() %>" required>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label form-label">Email:</label>
                    <div class="col-sm-9">
                        <input type="email" name="email" class="form-control" value="<%= supplier.getEmail() %>" required>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label form-label">Phone:</label>
                    <div class="col-sm-9">
                        <input type="text" name="phoneNumber" class="form-control" value="<%= supplier.getPhoneNumber() == null ? "" : supplier.getPhoneNumber() %>">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label form-label">Address:</label>
                    <div class="col-sm-9">
                        <input type="text" name="address" class="form-control" value="<%= supplier.getAddress() == null ? "" : supplier.getAddress() %>">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label form-label">Status:</label>
                    <div class="col-sm-9 d-flex align-items-center">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="activate" id="active" value="1" <%= supplier.getActivate() == 1 ? "checked" : "" %> required>
                            <label class="form-check-label" for="active" style="color:#2471A3;">Activate</label>
                        </div>
                        <div class="form-check form-check-inline ms-3">
                            <input class="form-check-input" type="radio" name="activate" id="inactive" value="0" <%= supplier.getActivate() == 0 ? "checked" : "" %>>
                            <label class="form-check-label" for="inactive" style="color:#2471A3;">Deactivate</label>
                        </div>
                    </div>
                </div>
                <div class="mb-3 row">
                    <div class="offset-sm-3 col-sm-9">
                        <button type="submit" class="btn btn-update me-2">Update</button>
                        <a href="ViewSupplier" class="btn btn-cancel">Cancel</a>
                    </div>
                </div>
            </form>
            <%
                } else {
            %>
            <div class="alert alert-danger">Supplier not found!</div>
            <a href="ViewSupplier" class="btn btn-secondary">Back to List</a>
            <%
                }
            %>
        </div>
    </div>
</div>
</body>
</html>
