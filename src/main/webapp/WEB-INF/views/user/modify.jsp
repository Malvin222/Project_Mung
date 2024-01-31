<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<html>
<head>
  <title>정보 수정</title>
  <link rel="stylesheet" type="text/css" href="/css/join.css">

</head>
<body>
<!-- 메인 로고 -->
<div class="main-logo" align="center">
  <a href="/"><img src="/imgs/mung-logo.png" width="250"></a>
</div>

<c:if test="${not empty message}">
  <div class="success-message">
      ${message}
  </div>
</c:if>

<c:if test="${not empty error}">
  <div class="error-message">
      ${error}
  </div>
</c:if>

<form action="/user/modifySave" method="post" id="frm">
  <label for="userid">회원아이디</label>
  <input type="text" id="userid" name="userid" value="${sessionScope.user.userid}" readonly><br>

  <label for="username">이름</label>
  <input type="text" id="username" name="username" value="${sessionScope.user.username}" readonly><br>

  <label for="userphone">전화번호</label>
  <input type="tel" id="userphone" name="userphone" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="010-1234-5678" value="${sessionScope.user.userphone}"><br>
  <label for="useremail">이메일</label>
  <input type="email" id="useremail" name="useremail" value="${sessionScope.user.useremail}">
  <!-- 우편번호 검색 관련 입력 -->
  <input type="text" id="sample6_postcode" name="userpostcode" placeholder="우편번호" value="${sessionScope.user.userpostcode}" readonly>
  <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
  <input type="text" id="sample6_address" name="useraddress" placeholder="주소" value="${sessionScope.user.useraddress}"><br>
  <input type="text" id="sample6_detailAddress" name="userdetailaddress" placeholder="상세주소" value="${sessionScope.user.userdetailaddress}">
  <input type="text" id="sample6_extraAddress" placeholder="참고항목">

  <div style="text-align:center">
    <button type="submit"  onclick="btn_submit()" id="btn_submit" name="btn_submit">정보수정</button>
  </div>


  <c:if test="${not empty message}">
    <input type="hidden" name="message" value="${message}">
  </c:if>

  <c:if test="${not empty error}">
    <input type="hidden" name="error" value="${error}">
  </c:if>
</form>

<!-- Footer -->
<footer>
  &copy; 2024 Your Website Name. All rights reserved.
</footer>


</body>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/joinPost.js"></script>

</html>