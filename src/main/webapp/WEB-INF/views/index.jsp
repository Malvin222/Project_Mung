<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<html>
<head>
    <title>메인</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>

<!-- 메인 로고 -->
<div class="main-logo" align="center">
    <a href="/dog/dogFoodSearch"><img src="/imgs/m2.png" width="150"></a><br>
</div>

<div class="login" style="text-align:center">
    <c:if test="${not empty sessionScope.user}">
        ${sessionScope.user.userid}
        <!-- 기타 사용자 정보를 필요에 따라 출력 -->
    </c:if>
</div>

<div align="center">
    <c:choose>
        <c:when test="${empty sessionScope.user}">
            <a href="/user/join">회원가입</a>
            <a href="/user/login">로그인</a>
            <a href="/oauth2/authorization/kakao">카카오로그인</a>
        </c:when>
        <c:otherwise>
            <a href="/user/logout">로그아웃</a>
            <a href="/user/modify">회원정보수정</a>
        </c:otherwise>
    </c:choose>
</div>





</body>
</html>
