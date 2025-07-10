<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Add Shipping Address</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-content {
            flex: 1 0 auto;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 50px 0 40px 0;
        }
        .address-card {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.10);
            padding: 40px 40px 30px 40px;
            width: 100%;
            max-width: 480px;
            border: none;
        }
        .address-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px 20px 0 0;
            padding: 25px 30px 18px 30px;
            margin: -40px -40px 30px -40px;
            border: none;
            box-shadow: 0 6px 12px -8px #aaa3;
        }
        .address-header h3 {
            margin: 0;
            font-weight: 600;
            display: flex;
            align-items: center;
        }
        .btn-row {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 16px;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/View/customer/homePage/header.jsp" />

<div class="main-content">
    <div class="address-card">
        <div class="address-header">
            <h3>
                <i class="bi bi-plus-lg me-2"></i>
                Add New Address
            </h3>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger mt-3">${error}</div>
        </c:if>

        <form method="post" action="AddAddress" id="formAddress">
            <div class="mb-3">
                <label for="province" class="form-label">Province</label>
                <select name="province" id="province" class="form-select" required>
                    <option value="" selected>Select Province</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="district" class="form-label">District</label>
                <select name="district" id="district" class="form-select" required>
                    <option value="" selected>Select District</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="ward" class="form-label">Ward</label>
                <select name="ward" id="ward" class="form-select" required>
                    <option value="" selected>Select Ward</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="addressDetails" class="form-label">Detailed Address</label>
                <input type="text" name="addressDetails" id="addressDetails" class="form-control" required minlength="5">
                <small id="error-message" class="form-text text-danger"></small>
            </div>
            <c:choose>
                <c:when test="${not empty hasDefault && hasDefault}">
                    <div class="mb-3 form-check form-switch">
                        <input class="form-check-input" name="isDefault" type="checkbox" role="switch" id="isDefaultSwitch">
                        <label class="form-check-label" for="isDefaultSwitch">Set as default</label>
                    </div>
                </c:when>
                <c:otherwise>
                    <input type="hidden" name="isDefault" value="1">
                    <div class="mb-3 form-check form-switch">
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
</div>

<jsp:include page="/WEB-INF/View/customer/homePage/footer.jsp" />

<!-- Địa giới hành chính -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
<script>
    // Validation JS phía client
    document.getElementById('formAddress').addEventListener('submit', function (event) {
        const addressInput = document.getElementById('addressDetails');
        const errorMessage = document.getElementById('error-message');
        errorMessage.textContent = '';
        if (addressInput.value.trim().length < 5) {
            errorMessage.textContent = 'Detailed Address must be at least 5 characters.';
            addressInput.focus();
            event.preventDefault();
            setTimeout(() => { errorMessage.textContent = ''; }, 3000);
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
            provinceSel.options[provinceSel.options.length] = new Option(p.Name, p.Name);
        });
    }
    provinceSel.onchange = function () {
        districtSel.length = 1;
        wardSel.length = 1;
        if (this.value) {
            let obj = allData.find(x => x.Name === this.value);
            obj.Districts.forEach(function (d) {
                districtSel.options[districtSel.options.length] = new Option(d.Name, d.Name);
            });
        }
    };
    districtSel.onchange = function () {
        wardSel.length = 1;
        let p = allData.find(x => x.Name === provinceSel.value);
        if (p && this.value) {
            let d = p.Districts.find(x => x.Name === this.value);
            d.Wards.forEach(function (w) {
                wardSel.options[wardSel.options.length] = new Option(w.Name, w.Name);
            });
        }
    };
</script>
</body>
</html>
