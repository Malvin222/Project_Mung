# 🐶 Project Mung
<img src="https://github.com/zzheek/Project_Hitrip/assets/133830185/dae221b3-a1e5-4359-a0e4-ff7898ab301d" width="300">
<br><br>

## ✔️ 프로젝트 소개
- 반려견 사료 선택/키워드 검색 및 페이징  @@@@@@@@@@@@@@@@@
- 결제 API(포트원)을 통한 카카오페이 결제 기능
- 스프링 시큐리티를 이용한 로그인/로그아웃 기능 및 카카오 로그인 기능
<br><br>

## ✔️ 프로젝트 계기
현재까지 프로젝트를 해오면서 학습한 기술에 더 익숙해지고자
키워드 선택만으로 간단하게 원하는 사료를 검색할 수 있는 사이트를 개발하였습니다.<br>
Spring Boot, JSP, MySQL 그리고 Spring Security를 사용하였고 AWS EC2를 통하여 배포하였습니다.
<br><br>

## ✔️ 팀 구성
강주희 외 1명
<br><br>

## ✔️ 개발 기간
2024.01.15 - 2024.01.25
<br><br>

## ✔️ 개발 환경
* Java 17.0
* Front : JSP / Javascript / jQuery
* Server : Apache Tomcat 9.0 / AWS EC2 / AWS RDS
* Framework : SpringBoot 3.1.0 / Spring Security 6.0
* Database : MYSQL 8.0.36
* ORM : MyBatis
* IDE : IntelliJ
* API : PortOne API / Daum Postcode Service API
* VCS : GIT
<br><br>

## ✔️ 주요 기능
*기능 클릭시 해당 코드로 이동합니다.

* ### <a href="https://github.com/zzheek/Project_Mung/blob/fa8857cbcdab2799f4d20f0a7599a3164616e5b3/src/main/java/com/project_mung/controller/DogController.java#L35-L118">검색 페이지</a>
  * 선택한 브랜드, 연령, 특징, 주성분, 가격대에 따라 사료를 필터링하여 검색 결과를 제공합니다.
  *  jQuery를 포함한 다양한 JavaScript 라이브러리를 사용하여 클라이언트 측 기능을 구현하고, Spring MVC를 통해 서버 측 기능을 구현하였습니다.


|<b>검색 전</b>|<b>검색 후</b>|
|:--:|:--:|
|<img src="https://github.com/zzheek/Project_Mung/assets/133830185/85172791-5ec5-4d1c-a73d-47c72410f09f">|<img src="https://github.com/zzheek/Project_Mung/assets/133830185/56bef86b-3bce-4f34-90bb-ac6a479931d9">|

<br><br><br>


* ### <a href="https://github.com/zzheek/Project_Mung/blob/main/src/main/java/com/project_mung/controller/CartController.java">장바구니</a>
  * 장바구니에 상품을 추가, 삭제 및 상품의 수량을 변경하거나 전체수량을 수정할 수 있습니다.
  * JavaScript와 jQuery를 사용하여 프론트엔드를 처리함으로써 서버와 클라이언트 간의 통신을 효율적으로 관리하고, 더 빠르게 동작할 수 있습니다.
 
<p align="center">
  <img src="https://github.com/zzheek/Project_Mung/assets/133830185/ecc13ae0-e3d0-4298-adb0-049e1c154f26" width="70%">
</p>
<br><br><br>


* ### <a href="https://github.com/zzheek/Project_Mung/blame/fa8857cbcdab2799f4d20f0a7599a3164616e5b3/src/main/webapp/WEB-INF/views/order/dogOrder.jsp#L230-L333">카카오페이 결제</a>
  * 포트원 API를 활용하여 카카오페이와의 결제 플로우를 구현하였습니다.
  * 결제가 성공한 경우, 해당 주문에 대한 정보를 데이터에 저장하여 주문 이력을 관리하고, 사용자에게 주문 정보를 제공할 수 있습니다.
 

<p align="center">
  <img src="https://github.com/zzheek/Project_Mung/assets/133830185/3d3b1363-53dc-4309-9a86-512206378a60" width="70%">
</p>
<br><br><br>


* ### <a href="https://github.com/zzheek/Project_Mung/blob/fa8857cbcdab2799f4d20f0a7599a3164616e5b3/src/main/java/com/project_mung/controller/OrderController.java#L122-L173">주문 내역 및 주문 상세</a>
  * 사용자 세션에서 사용자 정보를 가져오고, 해당 사용자의 주문 목록을 데이터베이스에서 조회합니다.<br>
  요청된 페이지에 해당하는 주문 목록을 추출하고, 모델에 추가하여 화면에 표시합니다.
  * 전체 주문 수를 계산하고, 페이지당 아이템 수를 설정하여 전체 페이지 수를 계산합니다.
 

|<b>주문 내역</b>|<b>주문 상세</b>|
|:--:|:--:|
|<img src="https://github.com/zzheek/Project_Mung/assets/133830185/454f8ab0-aeb3-426b-9ed3-294aa1fe814b">|<img src="https://github.com/zzheek/Project_Mung/assets/133830185/ccd8bfa6-1106-487c-979d-e88f572a268b">|

<br><br><br>


* ### <a href="https://github.com/zzheek/Project_Mung/blob/main/src/main/webapp/WEB-INF/views/user/delivery.jsp">배송지 관리 및 우편번호 API</a>
  * Daum 우편번호 서비스 API를 이용하여 사용자가 입력한 주소의 우편번호를 검색하고, 주소를 입력할 수 있습니다.
  * 배송지 관리를 클릭하면 Ajax를 사용하여 배송지 정보를 추가, 수정, 삭제할 때 비동기적으로 서버와 통신합니다.
 
<p align="center">
  <img src="https://github.com/zzheek/Project_Mung/assets/133830185/664c90e8-d41b-4364-b580-5cda14c95ce3" width="70%">
</p>    
<br><br><br>





## ✔️ 프로젝트 후기
Spring Boot, MyBatis, MySQL, Spring Security 등 이전에 경험한 기술들을 이번 프로젝트에서 다시 활용함으로써
그 활용법과 동작 원리에 대한 이해도가 높아졌습니다.<br><br>

Spring Boot와 MyBatis를 이용하여 데이터베이스와의 상호작용을 구현하는 과정에서, 
이전 프로젝트에서 쌓은 경험을 바탕으로 보다 효율적인 코드를 작성할 수 있었습니다. 
Spring Boot의 자동 설정과 MyBatis의 ORM 기능을 최대한 활용하여 개발 생산성을 높이고, 유지 보수성을 향상시켰습니다.<br><br>

MySQL 데이터베이스를 다루는 데에 있어서도 이전 경험이 큰 도움이 되었습니다. <br>
첫 프로젝트 때는 데이터베이스 설계에 대한 이해가 부족하여 마구잡이로 데이터베이스를 구성하였습니다. 
이로 인해 프로젝트 진행 중에 데이터베이스 구조를 수정하고, 불필요한 데이터를 삭제하는 등의 작업으로 인해 많은 시간을 투자해야 했습니다<br>
이전 경험을 통해 이번 프로젝트에서는 데이터베이스 설계, 쿼리 작성, 인덱싱 등을 통해 데이터베이스의 성능을 최적화하고, 
안정적인 데이터 관리를 목표로 하여 최대한 실현하였습니다.<br><br>

또한, 포트원(PortWine) 결제 API를 처음으로 사용했습니다.
이를 통해 외부 결제 시스템과의 연동 방법을 익히고, 실제 결제 프로세스를 구현하는 경험을 쌓을 수 있었습니다.<br><br>

이번 프로젝트 또한 팀원과 함께 Git을 이용하여 협업하며 Git 사용에 대한 숙련도를 향상시켰습니다. 
또한, AWS EC2를 활용하여 프로젝트를 배포함으로써 배포 프로세스에 대한 이해와 경험을 쌓을 수 있었습니다.






