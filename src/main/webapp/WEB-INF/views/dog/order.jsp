<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<html>
<head>
    <title>주문결제</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <!-- 포트원 결제 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <!-- 포트원 결제 -->
</head>
<body>
<!-- 메인 로고 -->
<div class="main-logo" align="center">
    <a href="/dog/dogFoodSearch"><img src="/imgs/mung-logo.png" width="250"></a>
</div>

<div class="login-container" style="text-align:right; margin-right:50px;">
    <c:if test="${not empty sessionScope.user}">
        ${sessionScope.user.userid}
        <!-- 기타 사용자 정보를 필요에 따라 출력 -->
    </c:if>
</div>

<div class="h2-container">
    <h2>배송정보</h2>
</div>

<div class="addr-container">
    <table>
        <tr>
            <td><button type="button" id="deliveryManage">배송지 관리</button></td>
        <tr>
            <td>
                <!-- 각 배송지에 대한 루프 -->
                <c:forEach var="delivery" items="${deliveryList}">
                    <!-- 각 배송지에 대한 라디오 버튼 및 라벨 -->
                    <input type="radio" id="${delivery.deliveryname}" name="address" value="${delivery.deliveryname}"
                           style="width: 10px; height: 15px;"
                           onclick="setDeliveryInfo('${delivery.deliveryname}'
                                   , '${delivery.customerphone}'
                                   , '${delivery.deliverypostcode}'
                                   , '${delivery.deliveryaddress}'
                                   , '${delivery.deliverydetailaddr}'
                                   , '${delivery.deliveryid}')"
                           <c:if test="${delivery.deliveryname eq '기본배송지'}">checked</c:if>>
                    <label for="${delivery.deliveryname}">${delivery.deliveryname}</label>
                </c:forEach>
            </td>
        </tr>


        <tr>
            <td><input type="text" name="customerphone" id="customerphone" placeholder="전화번호를 입력해주세요"></td>
        </tr>
        <tr>
            <td><input type="text" name="deliverypostcode" id="deliverypostcode" placeholder="우편번호를 입력해주세요">
            </td>
        </tr>
        <tr>
            <td><input type="text" name="deliveryaddress" id="deliveryaddress" placeholder="주소를 입력해주세요"></td>
        </tr>
        <tr>
            <td><input type="text" id="deliverydetailaddr" name="deliverydetailaddr"  placeholder="상세주소"></td>
        </tr>
        <input type="hidden" id="deliveryid" name="deliveryid" value="deliveryid">
        <tr>
            <td>
                <select id="deliveryoption" name="deliveryoption">
                    <option value="door">부재 시 문 앞에 놓아주세요.</option>
                    <option value="call">배송 전 연락바랍니다.</option>
                    <option value="security">부재 시 경비실에 맡겨주세요.</option>
                    <option value="custom">직접 입력</option>
                </select>
            </td>
        </tr>
        <tr id="custom-input" style="display:none;">
            <td>
                <input type="text" id="custom-text" name="custom-text" placeholder="배송메모를 입력해주세요.">
            </td>
        </tr>
    </table>
</div>

<div class="h2-container">
    <h2>주문상품</h2>
</div>

<div class="items-container">
    <table>
        <tr>
            <th>상품명</th>
            <th>가격</th>
            <th>수량</th>
            <th>총 가격</th>
        </tr>
        <c:forEach var="item" items="${orderItems}">
            <tr>
                <td>${item.dogfoodname}</td>
                <td>${item.dogfoodprice}</td>
                <td>${item.itemcnt}</td>
            </tr>
        </c:forEach>
    </table>
</div>
<div class="total-price-container">
    <table >
        <tr align="right">
            <td><h2 class="total-price"> 총 결제금액 ${totalPrice}원</h2> </td>
        </tr>
    </table>
</div>

<div class="h2-container">
    <h2>결제수단</h2>
</div>

<div class="method-container">
    <table >
        <tr>
            <td><input type="radio" checked>카카오페이</td>
        </tr>
    </table>
</div>
<div align="center">
    <h3>주문 내용을 확인하였으며, 정보 제공 등에 동의합니다.</h3>
</div>

<div class="pay-container" align="center">
    <input type="hidden" id="userid" value="${sessionScope.user.userid}">
    <button type="button" id="payment" onclick="kakaoPay()">결제하기</button>
</div>

<!-- Footer -->
<footer>
    &copy; 2024 Your Website Name. All rights reserved.
</footer>



</body>
<script>
    $(document).ready(function(){
        $("#deliveryoption").change(function(){
            if ($(this).val() === "custom") {
                $("#custom-input").show();
            } else {
                $("#custom-input").hide();
            }
        });
    });
</script>

<script>
    <!--라디오 버튼 클릭 시 해당 배송지의 정보를 인풋 상자에 설정하는 함수-->
    function setDeliveryInfo(deliveryName, customerPhone, deliveryPostcode, deliveryAddress, deliveryDetailAddr,deliveryId) {
        document.getElementById('customerphone').value = customerPhone;
        document.getElementById('deliverypostcode').value = deliveryPostcode;
        document.getElementById('deliveryaddress').value = deliveryAddress;
        document.getElementById('deliverydetailaddr').value = deliveryDetailAddr;
        document.getElementById('deliverydetailaddr').value = deliveryDetailAddr;
        document.getElementById('deliveryid').value = deliveryId;
    }

</script>

<!-- 팝업 창이 닫힐 때 부모 창 리로드 스크립트 추가 -->
<script>
    $(document).ready(function(){
        $("#deliveryManage").click(function(){
            // 팝업 창을 띄우기 위한 URL
            var url = "/user/delivery";

            // 팝업 창을 띄우기
            var popup = window.open(url, "_blank", "width=600,height=800");

            // 팝업이 닫힐 때 실행되는 코드 추가
            popup.onbeforeunload = function() {
                if (window.opener && !window.opener.closed) {
                    window.opener.location.reload();
                }
            };
        });
    });
</script>

<script>
    // 결제하기 버튼 클릭 시 실행되는 함수
    function handlePayment() {
        // 사용자의 세션 상태를 확인하여 로그인되어 있는지 확인
        if (${not empty sessionScope.user}) {
            const userid = "${sessionScope.user.userid}";

            // 결제하기 함수 호출
            kakaoPay(userid);
        } else {
            // 사용자가 로그인되어 있지 않은 경우 경고 메시지 표시
            alert('로그인이 필요합니다!');
        }
    }

    // 현재 날짜와 시간을 가져오는 부분
    var currentDate = new Date();
    var formattedDate = currentDate.toISOString().slice(0, 19).replace("T", " "); // ISO 형식에서 필요한 부분만 추출
    var seconds = currentDate.getSeconds();

    // 랜덤 숫자를 생성하는 부분 (예: 1부터 100까지의 랜덤 숫자)
    var randomNum = Math.floor(Math.random() * 1000) + 1;

    // 현재 날짜, 시간, 초, 그리고 랜덤 숫자를 합치는 부분
    var combinedResult = formattedDate + ' ' + seconds + ' ' + randomNum;
    var merchant_uid = combinedResult;


    var dogfoodNames = '${orderItems[0].dogfoodname}'

    var totalPrice = '${totalPrice}';   //총결제금액
    var buyer_email = '${sessionScope.user.useremail}';
    var buyer_name = '${sessionScope.user.username}';
    var buyer_tel = '${sessionScope.user.userphone}';
    var userid = '${sessionScope.user.userid}';

    // 배송지 정보
    var deliveryid = document.getElementById('deliveryid').value;
    var orderdate = formattedDate + ' ' + seconds;

    // KakaoPay 함수 정의
    function kakaoPay() {
        if (confirm("구매 하시겠습니까?")) {
            IMP.init('imp58014382'); // IMP.init 함수에 가맹점 식별코드를 넣어야 합니다.
            // 결제 요청 로직
            IMP.request_pay({
                // 결제 정보 설정
                pg: 'kakaopay.TC0ONETIME',
                pay_method: 'card',
                merchant_uid: merchant_uid, // 고유한 주문번호로 변경해야 합니다. //orderid
                name: dogfoodNames, // 구매하는 상품명으로 변경해야 합니다.
                amount: totalPrice, // 결제할 금액으로 변경해야 합니다.
                buyer_email: buyer_email, // 구매자의 이메일 주소로 변경해야 합니다.
                buyer_name: buyer_name, // 구매자의 이름으로 변경해야 합니다.
                buyer_tel: buyer_tel // 구매자의 전화번호로 변경해야 합니다.
            }, function (rsp) { // 콜백 함수
                if (rsp.success) { // 결제 성공 시
                    console.log(rsp);
                    // 결제 성공 처리 로직 추가

                    // 루프 외부에서 saveOrder 호출
                    saveOrder(userid, '카카오페이', deliveryid, orderdate, rsp.merchant_uid);

                    alert('결제가 완료되었습니다.');
                } else { // 결제 실패 시
                    console.log(rsp);
                    // 결제 실패 처리 로직 추가
                    alert('결제에 실패하였습니다.');
                }
            });
        } else {
            return false;
        }
    }
    <!-- 주문정보 저장 -->
    function saveOrder(userid, paymentMethod, deliveryid, orderdate, merchantuid) {
        $.ajax({
            type: 'POST',
            url: '/order/saveOrder',
            contentType: 'application/json', // 미디어 타입 설정
            data: JSON.stringify({
                userid: userid,
                paymentMethod: paymentMethod,
                deliveryid: deliveryid,
                orderdate :orderdate,
                merchantuid : merchantuid,
            }),
            success: function (response) {
                if (response === 'success') {
                    alert("저장성공")
                    // 여기에 필요한 추가 로직을 수행하세요.
                } else {
                    alert("저장실패"+response)
                    console.log('결제 정보 저장 실패');
                }
            },
            error: function (error) {
                alert("서버오류")
                console.log('서버 오류', error);
            }
        });
    }
</script>


</html>