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
            <td><button type="button" id="delivaryManage">배송지 관리</button></td>
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
                                   , '${delivery.deliverydetailaddr}')"
                           <c:if test="${delivery.deliveryname eq '기본배송지'}">checked</c:if>>
                    <label for="${delivery.deliveryname}">${delivery.deliveryname}</label>
                </c:forEach>
            </td>
        </tr>


        <tr>
            <td><input type="text" name="cusomerphone" id="customerphone" placeholder="전화번호를 입력해주세요"></td>
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
                <td>${item.totalprice}</td>
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
    function setDeliveryInfo(deliveryName, customerPhone, deliveryPostcode, deliveryAddress, deliveryDetailAddr) {
        document.getElementById('customerphone').value = customerPhone;
        document.getElementById('deliverypostcode').value = deliveryPostcode;
        document.getElementById('deliveryaddress').value = deliveryAddress;
        document.getElementById('deliverydetailaddr').value = deliveryDetailAddr;
    }

</script>

<!-- 팝업 창이 닫힐 때 부모 창 리로드 스크립트 추가 -->
<script>
    $(document).ready(function(){
        $("#delivaryManage").click(function(){
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


<%--<script>--%>
<%--    // 구매자 정보--%>
<%--    const userid = document.getElementById('userid').value;--%>

<%--    // 결제창 함수 넣어주기--%>
<%--    const buyButton = document.getElementById('payment')--%>
<%--    buyButton.setAttribute('onclick', `kakaoPay('${userid}')`)--%>

<%--    var IMP = window.IMP;--%>

<%--    var today = new Date();--%>
<%--    var hours = today.getHours(); // 시--%>
<%--    var minutes = today.getMinutes();  // 분--%>
<%--    var seconds = today.getSeconds();  // 초--%>
<%--    var milliseconds = today.getMilliseconds();--%>
<%--    var makeMerchantUid = `${hours}` + `${minutes}` + `${seconds}` + `${milliseconds}`;--%>

<%--    function kakaoPay(userid) {--%>
<%--        if (confirm("구매 하시겠습니까?")) { // 구매 클릭시 한번 더 확인하기--%>
<%--            if (localStorage.getItem("access")) { // 회원만 결제 가능--%>
<%--                // const emoticonName = document.getElementById('title').innerText--%>

<%--                IMP.init('imp58014382'); // 가맹점 식별코드--%>
<%--                IMP.request_pay({--%>
<%--                    pg: 'kakaopay.TC0ONETIME', // PG사 코드표에서 선택--%>
<%--                    pay_method: 'card', // 결제 방식--%>
<%--                    merchant_uid: "IMP" + makeMerchantUid, // 결제 고유 번호--%>
<%--                    name: '상품명', // 제품명--%>
<%--                    amount: 100, // 가격--%>
<%--                    //구매자 정보 ↓--%>
<%--                    buyer_id: `${userid}`,--%>
<%--                    // buyer_tel : '010-1234-5678',--%>
<%--                    // buyer_addr : '서울특별시 강남구 삼성동',--%>
<%--                    // buyer_postcode : '123-456'--%>
<%--                }, async function (rsp) { // callback--%>
<%--                    if (rsp.success) { //결제 성공시--%>
<%--                        console.log(rsp);--%>
<%--                        //결제 성공시 프로젝트 DB저장 요청--%>
<%--                        if (response.status == 200) { // DB저장 성공시--%>
<%--                            alert('결제 완료!')--%>
<%--                            window.location.reload();--%>
<%--                        } else { // 결제완료 후 DB저장 실패시--%>
<%--                            alert(`error:[${response.status}]\n결제요청이 승인된 경우 관리자에게 문의바랍니다.`);--%>
<%--                            // DB저장 실패시 status에 따라 추가적인 작업 가능성--%>
<%--                        }--%>
<%--                    } else if (rsp.success == false) { // 결제 실패시--%>
<%--                        alert(rsp.error_msg)--%>
<%--                    }--%>
<%--                });--%>
<%--            }--%>
<%--            else { // 비회원 결제 불가--%>
<%--                alert('로그인이 필요합니다!')--%>
<%--            }--%>
<%--        } else { // 구매 확인 알림창 취소 클릭시 돌아가기--%>
<%--            return false;--%>
<%--        }--%>
<%--    }--%>

<%--</script>--%>
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

    // KakaoPay 함수 정의
    function kakaoPay(userid) {
        if (confirm("구매 하시겠습니까?")) {
            IMP.init('imp58014382'); // IMP.init 함수에 가맹점 식별코드를 넣어야 합니다.

            // 결제 요청 로직
            IMP.request_pay({
                // 결제 정보 설정
                pg: 'kakaopay.TC0ONETIME',
                pay_method: 'card',
                merchant_uid: "고유 주문번호", // 고유한 주문번호로 변경해야 합니다. //orderid
                // name: '상품명', // 구매하는 상품명으로 변경해야 합니다.
                amount: 100, // 결제할 금액으로 변경해야 합니다.
                buyer_email: '구매자 이메일', // 구매자의 이메일 주소로 변경해야 합니다.
                buyer_name: '구매자 이름', // 구매자의 이름으로 변경해야 합니다.
                buyer_tel: '구매자 전화번호' // 구매자의 전화번호로 변경해야 합니다.
            }, function (rsp) { // 콜백 함수
                if (rsp.success) { // 결제 성공 시
                    console.log(rsp);
                    // 결제 성공 처리 로직 추가
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

    // 문서가 준비되면 실행되는 함수
    //     $(document).ready(function(){
    //     // 결제하기 버튼 클릭 시 handlePayment 함수 실행
    //     $("#payment").click(function(){
    //         handlePayment();
    //     });
    // });
</script>


</html>