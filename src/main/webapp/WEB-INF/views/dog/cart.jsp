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
    <a href="/"><img src="/imgs/mung-logo.png" width="250"></a>
</div>

<!-- 장바구니 목록 표시 -->
<div class="cart-container">
    <h2>장바구니</h2>

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
                <td> <input type="number" name="itemcnt" value="${item.itemcnt}" min="1" class="quantity-input"></td>
                <td><button class="update-quantity-btn" onclick="updateCnt(${item.cartid},$('input[name=itemcnt]').val())">수량 변경</button></td>
                <td>${item.totalprice}</td>
                <td><button onclick="removeFromCart(${item.cartid})">삭제</button></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <p>총 금액: ${totalPrice}</p>

    <!-- 주문 버튼 -->
    <button onclick="placeOrder()">주문하기</button>
</div>

<div>
    <c:if test="${not empty sessionScope.user}">
        <h2>로그인된 사용자 정보</h2>
        <p>사용자 아이디: ${sessionScope.user.userid}</p>
        <p>사용자 이름: ${sessionScope.user.username}</p>
        <!-- 기타 사용자 정보를 필요에 따라 출력 -->
    </c:if>
</div>

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

    // 주문하기 함수
    function placeOrder() {
        // 주문하기 관련 로직을 추가
        // 예: 주문 확인 페이지로 이동 또는 주문 처리 로직 실행
    }
</script>

<script>
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
</script>

</body>
</html>
