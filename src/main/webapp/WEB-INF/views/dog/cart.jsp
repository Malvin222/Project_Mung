<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<html>
<head>
    <title>장바구니</title>
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

<div class="title-container">
    <h2>장바구니</h2>
</div>

<!-- 전체 삭제 버튼 -->
<div class="remove-all-container" align="right">
    <button class="remove-all-button" onclick="confirmRemoveAll()">전체 삭제</button>
</div>

<!-- 장바구니 목록 표시 -->
<div class="cart-container">

    <table class="cart-table">
        <thead>
        <tr>
            <th>상품명</th>
            <th>가격</th>
            <th>수량</th>
            <th>총 가격</th>
            <th>삭제</th>
        </tr>
        </thead>
        <tbody>
        <!-- 장바구니에 담긴 각 상품에 대한 정보를 반복해서 표시 -->
        <c:forEach var="item" items="${cartItems}">
            <tr>
                <td>${item.dogfoodname}</td>
                <td>${item.dogfoodprice}</td>
                <td>
                    <!-- - 버튼을 누르면 수량 감소 -->
                    <button class="quantity-btn" onclick="changeQuantity(${item.cartid}, -1)" ${item.itemcnt == 1 ? 'disabled' : ''}>-</button>
                    <input type="text" name="itemcnt" value="${item.itemcnt}" min="1" class="quantity-input" onchange="updateCnt(${item.cartid}, this.value < 1 ? 1 : this.value)">
                    <!-- + 버튼을 누르면 수량 증가 -->
                    <button class="quantity-btn" onclick="changeQuantity(${item.cartid}, 1)">+</button>
                </td>
                <td>${item.totalprice}</td>
                <td><button class="remove-button" onclick="removeFromCart(${item.cartid})">삭제</button></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>

<div align="right">
    <table class="total-container" >
        <tr><td><h2 class="total-price">주문금액 <strong style="font-size: 28px;">${totalPrice}</strong>원</h2></td></tr>
        <tr><td><button class="order-button" onclick="placeOrder()">주문하기</button></td></tr>
    </table>
</div>
<!-- Footer -->
<footer>
    &copy; 2024 Your Website Name. All rights reserved.
</footer>
</body>


<script>
    // 장바구니에서 상품 삭제 함수
    function removeFromCart(cartid) {
        // AJAX를 사용하여 서버에 삭제 요청 전송
        $.ajax({
            url: "/cart/removeFromCart",
            type: "POST",
            data: {
                cartid: cartid
            },
            success: function (data) {
                // 삭제 성공 시 페이지 새로고침
                alert("삭제되었습니다.");
                location.reload();
            },
            error: function () {
                alert("삭제 중 오류가 발생했습니다.");
            }
        });
    }

    // 전체 삭제 함수 호출 전 확인 알림창 띄우기
    function confirmRemoveAll() {
        // 확인 창을 띄우고 확인을 누르면 removeAllFromCart 함수 호출
        if (confirm("정말로 장바구니를 비우시겠습니까?")) {
            removeAllFromCart();
        }
    }

    // 전체 삭제 함수
    function removeAllFromCart() {
        // AJAX를 사용하여 서버에 전체 삭제 요청 전송
        $.ajax({
            url: "/cart/removeAllFromCart",
            type: "POST",
            data: {
                userid: '${sessionScope.user.userid}' // 세션에서 사용자 아이디 가져와 전달
            },
            success: function (data) {
                // 삭제 성공 시 페이지 새로고침
                alert("전체 삭제되었습니다.");
                location.reload();
            },
            error: function () {
                alert("전체 삭제 중 오류가 발생했습니다.");
            }
        });
    }


    // 주문하기 함수
    function placeOrder() {
        // 주문하기 관련 로직을 추가
        // 예: 주문 확인 페이지로 이동 또는 주문 처리 로직 실행
    }

    function updateCnt(cartid,newQuantity){

        $.ajax({
            url: '/cart/updateItemCnt',
            type: "POST",
            data: {
                cartid: cartid,
                newQuantity:newQuantity

            },
            success: function (data) {
                // 성공 시 수행할 동작
                if(data === "success"){
                    alert("수량이 성공적으로 변경되었습니다.");
                    location.reload();
                }
            },
            error: function (error) {
                // 오류 발생 시 수행할 동작
                alert("에러가 발생했습니다"+ error.responseText);
                console.log(error.responseText);
            }
        });
    }


    // 수량 변경 함수
    function changeQuantity(cartid, amount) {
        // AJAX를 사용하여 서버에 수량 변경 요청 전송
        $.ajax({
            url: '/cart/changeQuantity',
            type: "POST",
            data: {
                cartid: cartid,
                amount: amount
            },
            success: function (data) {
                // 성공 시 수행할 동작
                if(data === "success"){
                    location.reload();
                }
            },
            error: function (error) {
                // 오류 발생 시 수행할 동작
                alert("에러가 발생했습니다" + error.responseText);
                console.log(error.responseText);
            }
        });
    }



</script>
</html>
