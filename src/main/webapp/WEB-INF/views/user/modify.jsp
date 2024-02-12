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



<form action="/user/modifySave" method="post" id="frm">
  <label for="userid">회원아이디</label>
  <input type="text" id="userid" name="userid" value="${sessionScope.user.userid}" readonly><br>

  <!-- 비밀번호 입력 상자 -->
  <label for="currentPassword">현재 비밀번호</label>
  <input type="password" id="currentPassword" name="currentPassword" value="" required><br>
  <div id="passwordSection" style="display: none;">
    <label for="newPassword">새 비밀번호</label>
    <input type="password" id="newPassword" name="newPassword"><br>
    <label for="confirmPassword">새 비밀번호 확인</label>
    <input type="password" id="confirmPassword" name="confirmPassword"><br>
  </div>

  <!-- 비밀번호 수정 버튼 -->
  <button type="button" id="modifypass">비밀번호 수정</button><br>


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

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // 비밀번호 수정 버튼 클릭 시 비밀번호 입력 상자를 표시하고 버튼을 숨깁니다.
    document.getElementById('modifypass').addEventListener('click', function() {
      document.getElementById('passwordSection').value="";
      document.getElementById('passwordSection').style.display = 'block';
      document.getElementById('modifypass').style.display = 'none';
    });
  });
</script>
<script>
  var error = "${error}";
  if (error && error.trim() !== "") {
    alert(error);
  }
  var message = "${message}";
  if (message && message.trim() !== "") {
    alert(message);
  }
</script>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/joinPost.js"></script>

</html>