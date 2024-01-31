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

<%-- 로그인 --%>
<div class="login-container">
    <c:if test="${not empty sessionScope.user}">
        <div><a href="/dog/dogFoodSearch">홈</a></div>
        <div>|</div>
        <div><a href="/dog/orderList">주문조회</a></div>
        <div>|</div>
        <div>${sessionScope.user.userid}</div>
        <div>|</div>
        <div><a href="/user/logout">로그아웃</a></div>
    </c:if>
    <c:if test="${empty sessionScope.user}">
        <script>
            window.location.href = "/user/login";
        </script>
    </c:if>
</div>

<!-- 메인 로고 -->
<div class="main-logo" align="center">
    <a href="/dog/dogFoodSearch"><img src="/imgs/mung-logo.png" width="250"></a>
</div>




<div class="title-container">
    <h2>장바구니</h2>
</div>

<!-- 전체 삭제 버튼 -->
<%--<div class="remove-all-container" align="right">--%>
<%--    <button class="remove-all-button" onclick="confirmRemoveAll()">전체 삭제</button>--%>
<%--</div>--%>

<!-- 전체 선택 및 선택 삭제 버튼 추가 -->
<div class="remove-all-container" style="display:flex; align-items:center;">
    <button class="remove-all-button" onclick="toggleSelectAll()">전체 선택</button>
    <button class="remove-all-button" onclick="confirmRemoveSelected()">선택 삭제</button>
    <div style="margin-left:auto; margin-right:20px;">
        <button class="remove-all-button" onclick="confirmRemoveAll()">전체 삭제</button>
    </div></div>

<!-- 장바구니 목록 표시 -->
<div class="cart-container">

    <table class="cart-table">
        <thead>
        <tr>
            <th>선택</th>
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
                <td><input type="checkbox" id="selectedItem_${item.cartid}" name="selectedItems" value="${item.cartid}"></td>
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
                <td><button class="remove-button" onclick="removeFromCart(${item.cartid})">X</button></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>

<%--<div align="right">--%>
<%--    <table class="total-container" >--%>
<%--        <tr><td><h2 class="total-price">주문금액 <strong id="orderTotalAmount" style="font-size: 28px;"></strong>원</h2></td></tr>--%>
<%--        <tr><td><button class="order-button" onclick="placeOrder()" style="text-align:center">주문하기</button></td></tr>--%>
<%--    </table>--%>
<%--</div>--%>

<div class="total-container" align="right">
    <h2 class="total-price">주문금액 <strong id="orderTotalAmount" style="font-size: 28px;"></strong>원</h2>
</div>
<div class="order-container" align="right">
    <button class="order-button" onclick="placeOrder()" style="text-align:center">주문하기</button>
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
<script>
    // 전체 선택 함수
    function toggleSelectAll() {
        // 현재 전체 선택 상태를 확인
        var allChecked = $('input[name="selectedItems"]:checked').length === $('input[name="selectedItems"]').length;

        // 모든 name이 selectedItems인 체크박스의 체크 상태를 변경
        $('input[name="selectedItems"]').prop('checked', !allChecked);

        // 주문금액 재계산
        calculateTotalPrice();
    }


    // 선택 삭제 함수 호출 전 확인 알림창 띄우기
    function confirmRemoveSelected() {
        // 체크된 항목이 하나 이상인지 확인
        if ($('input[name="selectedItems"]:checked').length > 0) {
            // 확인 창을 띄우고 확인을 누르면 removeSelected 함수 호출
            if (confirm("선택한 상품을 삭제하시겠습니까?")) {
                removeSelected();
            }
        } else {
            alert("선택한 상품이 없습니다.");
        }
    }

    // 선택한 상품 삭제 함수
    function removeSelected() {
        var selectedItems = [];
        $('input[name="selectedItems"]:checked').each(function () {
            selectedItems.push($(this).val());
        });

        $.ajax({
            url: "/cart/removeSelected",
            type: "POST",
            contentType: "application/json",  // 추가
            data: JSON.stringify(selectedItems),  // 변경
            success: function (data) {
                alert("선택한 상품이 삭제되었습니다.");
                location.reload();
            },
            error: function () {
                alert("선택한 상품 삭제 중 오류가 발생했습니다.");
            }
        });
    }


    $(document).ready(function() {
        // 페이지 로드 시 전체 선택 체크박스를 선택 상태로 변경
        toggleSelectAll();
    });
</script>

<script>
    // 상품 선택 상태 변경 시 주문금액 재계산
    $('input[name="selectedItems"]').change(function () {
        calculateTotalPrice();
    });

    function calculateTotalPrice() {
        var totalPrice = 0;
        // 각 선택된 상품의 총 가격을 계산
        $('input[name="selectedItems"]:checked').each(function () {
            var cartid = $(this).val();
            var itemPrice = parseFloat($('td:eq(2)', $(this).closest('tr')).text()); // 상품 가격 가져오기 (3번째 열)
            var quantity = parseInt($('input[name="itemcnt"]', $(this).closest('tr')).val()); // 상품 수량 가져오기
            totalPrice += itemPrice * quantity; // 총 가격 계산
        });
        // 주문금액을 업데이트
        $('#orderTotalAmount').text(totalPrice);
    }



    // 페이지 로드 시 초기 주문금액 계산
    $(document).ready(function () {
        calculateTotalPrice();
    });

</script>

<script>
    // 주문하기 함수
    function placeOrder() {
        // 선택된 상품들의 ID를 가져오기
        var selectedItems = [];
        $('input[name="selectedItems"]:checked').each(function () {
            selectedItems.push($(this).val());
        });
        // alert(selectedItems);

        // 선택된 상품이 없으면 알림 후 함수 종료
        if (selectedItems.length === 0) {
            alert("선택된 상품이 없습니다.");
            return;
        }

        // AJAX를 사용하여 서버에 선택된 상품들의 정보를 전송 ->dogCotroller addToOrder
        $.ajax({
            url: "/dog/addToOrder",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(selectedItems),
            success: function (data) {
                if(data === "success"){
                    window.location.href = "/dog/order";
                }
            },
            error: function () {
                alert("주문 처리 중 오류가 발생했습니다.");
            }
        });
    }
</script>
</html>
