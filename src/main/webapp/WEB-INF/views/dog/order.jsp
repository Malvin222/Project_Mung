<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<html>
<head>
    <title>주문결제</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<!-- 메인 로고 -->
<div class="main-logo" align="center">
    <a href="/dog/dogFoodSearch"><img src="/imgs/mung-logo.png" width="250"></a>
</div>

<div class="login-container" style="text-align:right; margin-right:50px;">
    <c:if test="${not empty sessionScope.user}">
        ${sessionScope.user.userid}
        <!-- 기타 사용자 정보를 필요에 따라 출력 -->
    </c:if>
</div>

<div class="h2-container">
    <h2>배송정보</h2>
</div>

<div class="addr-container">
    <table>
        <tr>
            <td>${user.username}</td>
            <td align="right"><button type="button">배송지 변경</button></td>
        </tr>
        <tr>
            <td>${user.userphone}</td>
        </tr>
        <tr>
            <td>${user.useraddress}</td>
        </tr>
        <tr>
            <td>
                <select id="delivery-option" name="delivery-option">
                    <option value="door">부재 시 문 앞에 놓아주세요.</option>
                    <option value="call">배송 전 연락바랍니다.</option>
                    <option value="security">부재 시 경비실에 맡겨주세요.</option>
                    <option value="custom">직접 입력</option>
                </select>
            </td>
        </tr>
        <tr id="custom-input" style="display:none;">
            <td>
                <input type="text" id="custom-text" name="custom-text" placeholder="배송메모를 입력해주세요.">
            </td>
        </tr>
    </table>
</div>

<div class="h2-container">
    <h2>주문상품</h2>
</div>

<div class="items-container">
    <table>
        <tr>
            <th>상품명</th>
            <th>가격</th>
            <th>수량</th>
            <th>총 가격</th>
        </tr>
        <c:forEach var="item" items="${selectedItems}">
            <tr>
                <td>${item.dogfoodname}</td>
                <td>${item.dogfoodprice}</td>
                <td>${item.itemcnt}</td>
                <td>${item.totalprice}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<div class="total-price-container">
    <table >
        <tr align="right">
            <td><h2 class="total-price"> 총 결제금액 ${totalPrice}원</h2> </td>
        </tr>
    </table>
</div>

<div class="h2-container">
    <h2>결제수단</h2>
</div>

<div class="method-container">
    <table >
        <tr>
            <td>일반결제</td>
        </tr>
    </table>
</div>
<div align="center">
    <h3>주문 내용을 확인하였으며, 정보 제공 등에 동의합니다.</h3>
</div>

<div class="pay-container" align="center">
    <button type="button">결제하기</button>
</div>

<!-- Footer -->
<footer>
    &copy; 2024 Your Website Name. All rights reserved.
</footer>



</body>
<script>
    $(document).ready(function(){
        $("#delivery-option").change(function(){
            if ($(this).val() === "custom") {
                $("#custom-input").show();
            } else {
                $("#custom-input").hide();
            }
        });
    });
</script>


</html>
