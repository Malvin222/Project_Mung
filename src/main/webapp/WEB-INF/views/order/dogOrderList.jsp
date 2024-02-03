
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<html>
<head>
    <title>주문조회</title>
    <link rel="stylesheet" type="text/css" href="/css/order.css">
</head>
<body>

<%-- 로그인 --%>
<div class="login-container">
    <div><a href="/dog/dogFoodSearch"><img src="/imgs/home.png" height="40px"></a></div>
    <div><a href="/order/dogOrderList"><img src="/imgs/user.png" height="40px"></a></div>
    <div><a href="/cart/dogCart"><img src="/imgs/shopping-cart.png" height="40px"></a></div>
</div>

<div class="login-container">
    <c:if test="${not empty sessionScope.user}">
        <div><a href="/user/modify">${sessionScope.user.userid}</a></div>
        <div>|</div>
        <div id="logout"><a href="/user/logout">로그아웃</a></div>
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

<div class="orderList-h2-container">
    <h2>주문내역</h2>
</div>

<table class="order-info">
    <!-- 각 배송지에 대한 루프 -->
    <c:forEach var="order" items="${userOrderList}">
        <tr>
            <td align="center">
                <label for="${order.orderdate}" class="order-status">결제완료</label>
            </td>
            <td>
                <button type="button" class="orderDetail" onclick="location='/order/dogOrderDetail/${order.orderid}'">결제상세</button>
                <div class="order-date">${order.orderdate}<span> 결제</span></div>
                <div class="order-item">${order.dogfoodname}
                    <c:if test="${order.countOrder-1 != 0}">
                        외 ${order.countOrder-1}건
                    </c:if>
                </div>
                <div class="order-price">${order.totalprice}<span>원</span></div>
            </td>
        </tr>
    </c:forEach>
</table>

<!-- 페이징 처리 -->
<div class="pagination">
    <!-- 이전 페이지로 이동하는 화살표 -->
    <a href="javascript:void(0);" onclick="goToPage(${currentPage - 5})" class="arrow ${currentPage > 1 ? '' : 'disabled'}">❮</a>

    <!-- 페이지 버튼 표시 -->
    <c:forEach var="pageNumber" begin="1" end="${totalPages}" varStatus="loop">
        <c:if test="${pageNumber >= currentPage - 5 && pageNumber <= currentPage + 5}"> <!-- 현재 페이지 기준 전후 5개까지만 표시 -->
            <a href="javascript:void(0);" onclick="goToPage(${pageNumber})" class="page-number ${pageNumber eq currentPage ? 'active' : ''}">${pageNumber}</a>
        </c:if>
    </c:forEach>

    <!-- 다음 페이지로 이동하는 화살표 -->
    <a href="javascript:void(0);" onclick="goToPage(${currentPage + 5})" class="arrow ${currentPage < totalPages ? '' : 'disabled'}">❯</a>
</div>


<script>
    var totalPages = ${totalPages}; // 전체 페이지 수

    function goToPage(pageNumber) {
        var pageSize = 10; // 페이지 당 아이템 수

        if (pageNumber >= 1 && pageNumber <= totalPages) {
            // 현재 페이지에서 가져올 주문 목록의 시작 인덱스 계산
            var startIndex = (pageNumber - 1) * pageSize;

            // 페이지 이동을 위한 URL 생성
            var url = "/order/dogOrderList?page=" + pageNumber;

            // 페이지 이동
            window.location.href = url;



        }
    }
</script>





<!-- Footer -->
<footer>
    &copy; 2024 Your Website Name. All rights reserved.
</footer>

</body>


</html>
