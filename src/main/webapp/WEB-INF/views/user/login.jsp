<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" type="text/css" href="/css/join.css">
</head>
<body>
<!-- 메인 로고 -->
<div class="main-logo" align="center">
    <a href="/"><img src="/imgs/mung-logo.png" width="250"></a>
</div>

<!-- 로그인 폼 -->
<form method="post" action="/user/login">
    <label for="userid">아이디</label>
    <input type="text" id="userid" name="userid" required>

    <label for="userpass">비밀번호</label>
    <input type="password" id="userpass" name="userpass" required>

    <div  style="text-align:center">
        <button type="submit">로그인</button>
        <button type="button"><a href="/user/join">회원가입</a></button>
    </div>

    <div>
        <a href="/oauth2/authorization/kakao">카카오로그인</a>
    </div>
</form>



<!-- Footer -->
<footer>
    &copy; 2024 Your Website Name. All rights reserved.
</footer>

</body>

</html>
