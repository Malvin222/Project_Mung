<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
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
            text-align: center;
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

<!-- 로그인 폼 -->
<form>
    <label for="userid">아이디</label>
    <input type="text" id="userid" name="userid" required>

    <label for="userpass">비밀번호</label>
    <input type="password" id="userpass" name="userpass" required>

    <div  style="text-align:center">
        <button type="submit">로그인</button>
    </div>


</form>

<!-- Footer -->
<footer>
    &copy; 2024 Your Website Name. All rights reserved.
</footer>

</body>

</html>
