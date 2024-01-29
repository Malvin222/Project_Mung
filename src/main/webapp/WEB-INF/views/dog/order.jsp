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
            <td><button type="button" id="delivaryManage">배송지 관리</button></td>
        <tr>
            <td>
                <!-- 각 배송지에 대한 루프 -->
                <c:forEach var="delivery" items="${deliveryList}">
                <!-- 각 배송지에 대한 라디오 버튼 및 라벨 -->
                <input type="radio" id="${delivery.deliveryname}" name="address" value="${delivery.deliveryname}"
                       style="width: 10px; height: 15px;"
                       onclick="setDeliveryInfo('${delivery.deliveryname}'
                               , '${delivery.customerphone}'
                               , '${delivery.deliverypostcode}'
                               , '${delivery.deliveryaddress}')">
                <label for="${delivery.deliveryname}">${delivery.deliveryname}</label>
                </c:forEach>
            </td>
        </tr>

        <tr>
            <td><input type="text" name="cusomerphone" id="customerphone" placeholder="전화번호를 입력해주세요"></td>
        </tr>
        <tr>
            <td><input type="text" name="deliverypostcode" id="deliverypostcode" placeholder="우편번호를 입력해주세요">
            </td>
        </tr>
        <tr>
            <td><input type="text" name="deliveryaddress" id="deliveryaddress" placeholder="주소를 입력해주세요"></td>
        </tr>

        <tr>
            <td>
                <select id="deliveryoption" name="deliveryoption">
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
        <c:forEach var="item" items="${orderItems}">
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
        $("#deliveryoption").change(function(){
            if ($(this).val() === "custom") {
                $("#custom-input").show();
            } else {
                $("#custom-input").hide();
            }
        });
    });
</script>

<script>
    <!--라디오 버튼 클릭 시 해당 배송지의 정보를 인풋 상자에 설정하는 함수-->
    function setDeliveryInfo(deliveryName, customerPhone, deliveryPostcode, deliveryAddress) {
        document.getElementById('customerphone').value = customerPhone;
        document.getElementById('deliverypostcode').value = deliveryPostcode;
        document.getElementById('deliveryaddress').value = deliveryAddress;
    }

</script>

<!-- 팝업 창이 닫힐 때 부모 창 리로드 스크립트 추가 -->
<script>
    $(document).ready(function(){
        $("#delivaryManage").click(function(){
            // 팝업 창을 띄우기 위한 URL
            var url = "/user/delivery";

            // 팝업 창을 띄우기
            var popup = window.open(url, "_blank", "width=600,height=800");

            // 팝업이 닫힐 때 실행되는 코드 추가
            popup.onbeforeunload = function() {
                if (window.opener && !window.opener.closed) {
                    window.opener.location.reload();
                }
            };
        });
    });
</script>


</html>
