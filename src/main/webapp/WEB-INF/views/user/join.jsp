<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<html>
<head>
  <title>회원가입</title>
  <style>
    body {
      background: #f1eee9;
      font-family: "Noto Sans KR ExtraLight";
      color: #4b4a4a;
    }

    .main-logo {
      margin-top: 50px;
      align-items: center;

    }

    /* Footer 스타일 */
    footer {
      text-align: center;
      padding: 10px;
      bottom: 0;
      width: 98%;
    }
    /* 폼 스타일 */
    form {
      background: #fff; /* 폼 배경색 설정 */
      width: 30%;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
      margin: 20px auto; /* 수평 가운데 정렬 */
    }

    /* 레이블 스타일 */
    label {
      display: block;
      margin-top: 10px;
    }

    /* 입력 필드 스타일 */
    input {
      width: 100%;
      padding: 8px;
      margin-top: 5px;
      margin-bottom: 10px;
      box-sizing: border-box;
    }

    /* 버튼 스타일 */
    button {
      background-color: #4CAF50;
      color: white;
      padding: 10px 15px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    /* 버튼 호버 효과 */
    button:hover {
      background-color: #45a049;
    }
  </style>
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
<!-- 회원가입 폼 -->
<form action="/user/join" method="post" id="frm">
  <label for="userid">회원아이디</label>
  <input type="text" id="userid" name="userid" required><br>

  <label for="userpass">비밀번호</label>
  <input type="password" id="userpass" name="userpass" required><br>

  <label for="username">이름</label>
  <input type="text" id="username" name="username" required><br>

  <label for="userphone">전화번호</label>
  <input type="tel" id="userphone" name="userphone" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="010-1234-5678" required><br>
  <label for="useremail">이메일</label>
  <input type="email" id="useremail" name="useremail" required>
  <!-- 우편번호 검색 관련 입력 -->
  <input type="text" id="sample6_postcode" name="userpostcode" placeholder="우편번호" readonly>
  <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
  <input type="text" id="sample6_address" name="useraddress" placeholder="주소"><br>
  <input type="text" id="sample6_detailAddress" name="userdetailaddress" placeholder="상세주소">
  <input type="text" id="sample6_extraAddress" placeholder="참고항목">

  <div style="text-align:center">
    <button type="submit"  onclick="btn_submit()" id="btn_submit" name="btn_submit">회원가입</button>
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