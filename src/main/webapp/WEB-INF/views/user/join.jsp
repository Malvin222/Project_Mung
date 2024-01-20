<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<!-- 회원가입 폼 -->
<form action="/user/join" method="post">
  <label for="userid">회원아이디</label>
  <input type="text" id="userid" name="userid" required><br>

  <label for="userpass">비밀번호</label>
  <input type="password" id="userpass" name="userpass" required><br>

  <label for="username">이름</label>
  <input type="text" id="username" name="username" required><br>

  <label for="userphone">전화번호</label>
  <input type="tel" id="userphone" name="userphone" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="010-1234-5678" required><br>

  <!-- 우편번호 검색 관련 입력 -->
  <input type="text" id="sample6_postcode" name="userpostcode" placeholder="우편번호">
  <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
  <input type="text" id="sample6_address" name="useraddress" placeholder="주소"><br>
  <input type="text" id="sample6_detailAddress" name="userdetailaddress" placeholder="상세주소">
  <input type="text" id="sample6_extraAddress" name="useremail" placeholder="참고항목">

  <div style="text-align:center">
    <button type="submit">회원가입</button>
  </div>

</form>



<!-- Footer -->
<footer>
  &copy; 2024 Your Website Name. All rights reserved.
</footer>


</body>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
  function sample6_execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
        var addr = ''; // 주소 변수
        var extraAddr = ''; // 참고항목 변수

        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
          addr = data.roadAddress;
        } else { // 사용자가 지번 주소를 선택했을 경우(J)
          addr = data.jibunAddress;
        }

        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
        if(data.userSelectedType === 'R'){
          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
          if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
            extraAddr += data.bname;
          }
          // 건물명이 있고, 공동주택일 경우 추가한다.
          if(data.buildingName !== '' && data.apartment === 'Y'){
            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
          if(extraAddr !== ''){
            extraAddr = ' (' + extraAddr + ')';
          }
          // 조합된 참고항목을 해당 필드에 넣는다.
          document.getElementById("sample6_extraAddress").value = extraAddr;

        } else {
          document.getElementById("sample6_extraAddress").value = '';
        }

        // 우편번호와 주소 정보를 해당 필드에 넣는다.
        document.getElementById('sample6_postcode').value = data.zonecode;
        document.getElementById("sample6_address").value = addr;
        // 커서를 상세주소 필드로 이동한다.
        document.getElementById("sample6_detailAddress").focus();
      }
    }).open();
  }

</script>


</html>
