<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Address" %>
<%
    Address address = (Address) request.getAttribute("address");
    boolean hasDefault = false;
    if (request.getAttribute("hasDefault") != null) {
        hasDefault = (Boolean) request.getAttribute("hasDefault");
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Update Address</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .address-form-container {
                max-width: 480px;
                margin: 40px auto;
                padding: 24px 32px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 2px 14px 2px #d1d1e6;
            }
            .form-title {
                font-weight: 700;
                margin-bottom: 18px;
            }
            .form-label {
                font-weight: 500;
            }
            .btn-row {
                display: flex;
                gap: 10px;
                justify-content: flex-end;
                margin-top: 16px;
            }
        </style>
    </head>
    <body style="background: #f5f7fa; font-family: Arial,sans-serif;">
        <div class="address-form-container">
            <h2 class="form-title">Update Address</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form method="post" action="UpdateAddress" id="formAddress">
                <input type="hidden" name="id" value="${address.addressId}" />
                <div class="mb-3">
                    <label for="province" class="form-label">Province</label>
                    <select name="province" id="province" class="form-select" required>
                        <option value="" disabled>Select Province</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="district" class="form-label">District</label>
                    <select name="district" id="district" class="form-select" required>
                        <option value="" disabled>Select District</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="ward" class="form-label">Ward</label>
                    <select name="ward" id="ward" class="form-select" required>
                        <option value="" disabled>Select Ward</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="addressDetails" class="form-label">Detailed Address</label>
                    <input type="text" name="addressDetails" id="addressDetails" class="form-control" required minlength="5"
                           value="${address.addressDetails}">
                    <small id="error-message" class="form-text text-danger"></small>
                </div>
                <c:choose>
                    <c:when test="${hasDefault}">
                        <div class="mb-3 form-check form-switch">
                            <input class="form-check-input" name="isDefault" type="checkbox" role="switch"
                                   id="isDefaultSwitch" <c:if test="${address['default']}">checked</c:if>>

                                   <label class="form-check-label" for="isDefaultSwitch">Set as default</label>
                            </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mb-3 form-check form-switch">
                            <input type="hidden" name="isDefault" value="1">
                            <input class="form-check-input" type="checkbox" id="isDefaultSwitch" checked disabled>
                            <label class="form-check-label" for="isDefaultSwitch">Set as default (auto for first address)</label>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="btn-row">
                    <a href="ViewShippingAddress" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-danger">Save</button>
                </div>
            </form>
        </div>

        <!-- Địa giới hành chính API -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script>
            // Fill dữ liệu cũ nếu có
            var oldProvince = '<%= address != null ? address.getProvinceName() : ""%>';
            var oldDistrict = '<%= address != null ? address.getDistrictName() : ""%>';
            var oldWard = '<%= address != null ? address.getWardName() : ""%>';

            // Validation JS phía client
            document.getElementById('formAddress').addEventListener('submit', function (event) {
                const addressInput = document.getElementById('addressDetails');
                const errorMessage = document.getElementById('error-message');
                errorMessage.textContent = '';
                if (addressInput.value.trim().length < 5) {
                    errorMessage.textContent = 'Detailed Address must be at least 5 characters.';
                    addressInput.focus();
                    event.preventDefault();
                    setTimeout(() => {
                        errorMessage.textContent = '';
                    }, 3000);
                }
            });

            // Load Province/District/Ward
            let allData = [];
            let provinceSel = document.getElementById("province");
            let districtSel = document.getElementById("district");
            let wardSel = document.getElementById("ward");

            axios.get("https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json")
                    .then(function (result) {
                        allData = result.data;
                        renderProvinces();
                    });

            function renderProvinces() {
                allData.forEach(function (p) {
                    let option = new Option(p.Name, p.Name);
                    if (p.Name === oldProvince)
                        option.selected = true;
                    provinceSel.options[provinceSel.options.length] = option;
                });
                if (oldProvince)
                    loadDistricts();
            }
            provinceSel.onchange = function () {
                loadDistricts();
            };

            function loadDistricts() {
                districtSel.length = 1; // reset
                wardSel.length = 1;
                let p = allData.find(x => x.Name === provinceSel.value);
                if (p) {
                    p.Districts.forEach(function (d) {
                        let option = new Option(d.Name, d.Name);
                        if (d.Name === oldDistrict)
                            option.selected = true;
                        districtSel.options[districtSel.options.length] = option;
                    });
                    if (oldDistrict)
                        loadWards();
                }
            }
            districtSel.onchange = function () {
                loadWards();
            };

            function loadWards() {
                wardSel.length = 1;
                let p = allData.find(x => x.Name === provinceSel.value);
                if (p) {
                    let d = p.Districts.find(x => x.Name === districtSel.value);
                    if (d) {
                        d.Wards.forEach(function (w) {
                            let option = new Option(w.Name, w.Name);
                            if (w.Name === oldWard)
                                option.selected = true;
                            wardSel.options[wardSel.options.length] = option;
                        });
                    }
                }
            }
        </script>
    </body>
</html>
