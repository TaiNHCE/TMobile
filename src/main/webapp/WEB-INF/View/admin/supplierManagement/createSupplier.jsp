
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Suppliers" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Supplier</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .form-label {
            color: #2471A3;
            font-weight: 600;
            width: 140px;
            white-space: nowrap;
        }
        .form-check-label {
            color: #2471A3;
            font-weight: 500;
        }
        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }
        .btn-create {
            background-color: #28a745;
            color: white;
            font-weight: 600;
            padding: 8px 24px;
            border: none;
            border-radius: 6px;
        }
        .btn-cancel {
            background-color: #888;
            color: white;
            font-weight: 600;
            padding: 8px 24px;
            border: none;
            border-radius: 6px;
        }
        .card {
            margin-top: 40px;
            max-width: 720px;
            margin-left: auto;
            margin-right: auto;
            padding: 20px;
        }
        .mb-3.row {
            align-items: center;
        }
        @media (max-width: 576px) {
            .form-label {
                width: 100%;
                margin-bottom: 6px;
            }
            .mb-3.row {
                display: block;
            }
            .col-sm-9 {
                width: 100%;
            }
        }
        .error {
            color: #dc3545;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card shadow">
        <div class="card-body">
            <h3 class="mb-4" style="color:#19335D;">Add Supplier</h3>
            <hr style="border: 2px solid #2471A3; margin-top:-15px;">

            <% if (request.getAttribute("errorMsg") != null) { %>
                <div class="alert alert-danger"><%= request.getAttribute("errorMsg") %></div>
            <% } %>

            <form method="post" action="CreateSupplier">

                <div class="mb-3 row">
                    <label for="taxId" class="col-sm-3 col-form-label form-label">Tax ID:</label>
                    <div class="col-sm-9">
                        <input type="text" id="taxId" name="taxId" class="form-control" required>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label for="name" class="col-sm-3 col-form-label form-label">Company Name:</label>
                    <div class="col-sm-9">
                        <input type="text" id="name" name="name" class="form-control" required>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label for="email" class="col-sm-3 col-form-label form-label">Email:</label>
                    <div class="col-sm-9">
                        <input type="email" id="email" name="email" class="form-control">
                    </div>
                </div>

                <div class="mb-3 row">
                    <label for="phoneNumber" class="col-sm-3 col-form-label form-label">Phone Number:</label>
                    <div class="col-sm-9">
                        <input type="text" id="phoneNumber" name="phoneNumber" class="form-control">
                    </div>
                </div>

                <div class="mb-3 row">
                    <label for="address" class="col-sm-3 col-form-label form-label">Address:</label>
                    <div class="col-sm-9">
                        <input type="text" id="address" name="address" class="form-control">
                    </div>
                </div>

                <div class="mb-3 row">
                    <label for="contactPerson" class="col-sm-3 col-form-label form-label">Contact Person:</label>
                    <div class="col-sm-9">
                        <input type="text" id="contactPerson" name="contactPerson" class="form-control">
                    </div>
                </div>

                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label form-label">Supply Group:</label>
                    <div class="col-sm-9">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="supplyGroup" value="Phones" id="sgPhones">
                            <label class="form-check-label" for="sgPhones">Phones</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="supplyGroup" value="Laptop" id="sgLaptop">
                            <label class="form-check-label" for="sgLaptop">Laptop</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="supplyGroup" value="Watch" id="sgWatch">
                            <label class="form-check-label" for="sgWatch">Watch</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="supplyGroup" value="Accessories" id="sgAccessories">
                            <label class="form-check-label" for="sgAccessories">Accessories</label>
                        </div>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label for="description" class="col-sm-3 col-form-label form-label">Description:</label>
                    <div class="col-sm-9">
                        <textarea id="description" name="description" class="form-control" rows="4" placeholder="Write something..."></textarea>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label class="col-sm-3 col-form-label form-label">Status:</label>
                    <div class="col-sm-9 d-flex align-items-center">
                        <div class="form-check form-check-inline">
                            <input type="radio" name="activate" id="active" value="1" class="form-check-input" checked>
                            <label for="active" class="form-check-label">Activate</label>
                        </div>
                        <div class="form-check form-check-inline ms-3">
                            <input type="radio" name="activate" id="inactive" value="0" class="form-check-input">
                            <label for="inactive" class="form-check-label">Deactivate</label>
                        </div>
                    </div>
                </div>

                <div class="mb-3 row">
                    <div class="offset-sm-3 col-sm-9 d-flex gap-3">
                        <button type="submit" class="btn-create">Create</button>
                        <button type="button" class="btn-cancel" onclick="window.location='ViewSupplier'">Cancel</button>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>
</body>
</html>
