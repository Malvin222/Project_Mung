    package com.project_mung.controller;

    import com.project_mung.domain.*;
    import com.project_mung.service.CartService;
    import com.project_mung.service.DogFoodService;
    import com.project_mung.service.OrderService;
    import jakarta.servlet.http.HttpSession;
    import lombok.extern.log4j.Log4j2;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.stereotype.Controller;
    import org.springframework.ui.Model;
    import org.springframework.web.bind.annotation.*;

    import java.util.ArrayList;
    import java.util.Arrays;
    import java.util.List;
    import java.util.stream.Collectors;

    @Log4j2
    @Controller
    public class DogController {

        private final DogFoodService dogFoodService;
        private final CartService cartService;
        private final OrderService orderService;

        @Autowired
        public DogController(DogFoodService dogFoodService, CartService cartService, OrderService orderService) {
            this.dogFoodService = dogFoodService;
            this.cartService = cartService;
            this.orderService = orderService;
        }

        @GetMapping("/dog/dogFoodSearch")
        public String selectDogFoodByKeyword(
                @RequestParam(name = "searchKeyword", required = false) String searchKeyword,
                @RequestParam(name = "selectedBrands", required = false) List<String> selectedBrands,
                @RequestParam(name = "selectedAges", required = false) List<String> selectedAges,
                @RequestParam(name = "selectedFeatures", required = false) List<String> selectedFeatures,
                @RequestParam(name = "selectedNutrients", required = false) List<String> selectedNutrients,
                @RequestParam(name = "selectedPrices", required = false) List<String> selectedPrices,
                @RequestParam(name = "page", defaultValue = "1") int page,
                @RequestParam(name = "pageSize", defaultValue = "10") int pageSize,
                Model model) {

            List<DogFood> dogFoodList = dogFoodService.getAllDogFood();
            List<DogFood> dogFoodNutrients = dogFoodService.selectDogFoodbyNut();

            // 스트림을 사용하여 모든 필터를 적용
            dogFoodList = dogFoodList.stream()
                    .filter(dogFood ->
                            (searchKeyword == null || dogFood.getDogfoodname().toLowerCase().contains(searchKeyword.toLowerCase())) &&
                                    (selectedBrands == null || selectedBrands.contains(dogFood.getDogfoodbrand())) &&
                                    (selectedAges == null || selectedAges.contains(dogFood.getDogage())))
                    .collect(Collectors.toList());

            // 선택된 영양소에 기반하여 필터링
            if (selectedNutrients != null && !selectedNutrients.isEmpty()) {
                dogFoodList = dogFoodList.stream()
                        .peek(dogFood -> {
                            String[] nutrients = dogFood.getDogfoodnut().split(",\\s*");
                        })
                        .filter(dogFood -> {
                            String[] nutrients = dogFood.getDogfoodnut().split(",\\s*");
                            return Arrays.asList(nutrients).containsAll(selectedNutrients);
                        })
                        .collect(Collectors.toList());
            }

            // 선택된 특징에 기반하여 필터링
            if (selectedFeatures != null && !selectedFeatures.isEmpty()) {
                dogFoodList = dogFoodList.stream()
                        .peek(dogFood -> {
                            String[] features = dogFood.getDogfoodfeat().split(",\\s*");
                        })
                        .filter(dogFood -> {
                            String[] features = dogFood.getDogfoodfeat().split(",\\s*");
                            return Arrays.asList(features).containsAll(selectedFeatures);
                        })
                        .collect(Collectors.toList());
            }

            // 가격대를 필터링하는 부분
            if (selectedPrices != null && !selectedPrices.isEmpty()) {
                dogFoodList = dogFoodList.stream()
                        .filter(dogFood -> {
                            int prices = dogFood.getDogfoodprice();
                            // DogFood 객체의 가격 정보와 선택된 가격대를 비교하여 필터링
                            return Arrays.asList(prices).stream()
                                    .anyMatch(price -> selectedPrices.contains(getPriceRange(price)));
                        })
                        .collect(Collectors.toList());
            }

            // 컨트롤러 메서드 내부
            List<String> dogFoodBrands = dogFoodService.getAllDogFoodBrands();

            // 전체 페이지 수 계산
            int totalPage = (int) Math.ceil((double) dogFoodList.size() / pageSize);

            // 현재 페이지의 시작 인덱스와 끝 인덱스 계산
            int startIndex = (page - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, dogFoodList.size());

            // 현재 페이지에 해당하는 부분집합 추출
            List<DogFood> currentPageList = dogFoodList.subList(startIndex, endIndex);

            model.addAttribute("dogfoodBrands", dogFoodBrands);
            model.addAttribute("dogFoodNutrients", dogFoodNutrients);
            model.addAttribute("dogFoodList", currentPageList);

            // 페이징
            model.addAttribute("totalPage", totalPage);
            model.addAttribute("currentPage", page);

            return "dog/dogFoodSearch";
        }


        // DogFood 객체의 가격을 가격대로 변환하는 메서드
        private String getPriceRange(Integer price) {
            int priceValue = Integer.parseInt(String.valueOf(price));
            if (priceValue < 10000) {
                return "1만원 미만";
            } else if (priceValue < 20000) {
                return "1만원대";
            } else if (priceValue < 30000) {
                return "2만원대";
            } else if (priceValue < 40000) {
                return "3만원대";
            } else if (priceValue < 50000) {
                return "4만원대";
            } else {
                return "5만원 이상";
            }
        }


        //장바구니 목록조회
        @GetMapping("/dog/cart")
        public String dogCartPage(Model model, HttpSession session){

            //세션에서 사용자 아이디 가져오기
            User user = (User) session.getAttribute("user");

            // 세션에 사용자 정보가 없을 경우 로그인 페이지로 리다이렉트
            if (user == null) {
                return "redirect:/user/login";
            }

            String userid = user.getUserid();

            //세션에서 사용자 아이디를 통해 장바구니에 담김 상품 목록 조회
            List<Cart> cartItems =cartService.getCartItems(userid);

            //총 금액 계산
            int totalPrice = cartService.totalPrice(cartItems);

            //모델에 데이터 추가
            model.addAttribute("cartItems",cartItems);
            model.addAttribute("totalPrice",totalPrice);
            return "dog/cart";
        }


        // 주문 처리
        @GetMapping("/dog/order")
        public String placeOrder(HttpSession session, Model model) {
            // 세션에서 사용자 아이디 가져오기
            User user = (User) session.getAttribute("user");

            String userid = user.getUserid();

            //선택 주문목록 받아오기
            List<Integer> cartid = (List<Integer>) session.getAttribute("selectedItems");

            //주문목록 가져오기
            List<Cart> orderItems = orderService.getOrderItems(cartid);
            int totalPrice = cartService.totalPrice(orderItems);

            //배송지 정보 가져오기
            List<Delivery> deliveryList = orderService.getDelivery(userid);

            model.addAttribute("orderItems",orderItems);
            model.addAttribute("totalPrice",totalPrice);
            model.addAttribute("deliveryList",deliveryList);


//            Enumeration<String> attributeNames = session.getAttributeNames();
//
//            // 각 속성에 대한 정보 출력
//            while (attributeNames.hasMoreElements()) {
//                String attributeName = attributeNames.nextElement();
//                Object attributeValue = session.getAttribute(attributeName);
//                System.out.println("Attribute Name: " + attributeName + ", Attribute Value: " + attributeValue);
//            }

            return "dog/order";
        }

        //선택된 목록이 세션에 저장
        @PostMapping("/dog/addToOrder")
        @ResponseBody
        public String addToOrder(@RequestBody List<Integer> selectedItems, HttpSession session) {

            // 세션에서 선택된 상품들 가져오기
            List<Integer> orderItems = (List<Integer>) session.getAttribute("selectedItems");

            // 선택된 상품들이 없으면 새로운 리스트 생성
            if (orderItems == null) {
                orderItems = new ArrayList<>();
            } else {
                // 이미 선택된 항목이 있다면 세션에서 제거하여 초기화
                orderItems.clear();
                session.removeAttribute("selectedItems");
            }

            // 선택된 항목들을 기존 리스트에 추가
            orderItems.addAll(selectedItems);

            // 세션에 업데이트된 선택된 상품들 저장
            session.setAttribute("selectedItems", orderItems);

            return "success";
        }

//        @RequestMapping("/dog/orderList")
//        public String getUserOrderList(HttpSession session, Model model) {
//
//            User user = (User) session.getAttribute("user");
//            String userid = user.getUserid();
//
//            List<Order> userOrderList = orderService.getUserOrders(userid);
//            model.addAttribute("userOrderList", userOrderList);
//            return "dog/orderList";
//        }

        @RequestMapping("/dog/orderList")
        public String getUserOrderList(HttpSession session, Model model,
                                       @RequestParam(name = "page", defaultValue = "1") int page) {
            // 세션에서 사용자 정보 가져오기
            User user = (User) session.getAttribute("user");
            String userid = user.getUserid();

            // 페이지당 아이템 수
            int pageSize = 10;

            // 전체 주문 수 가져오기
            int totalOrders = orderService.getTotalUserOrders(userid);

            // 전체 페이지 수 계산
            int totalPages = (int) Math.ceil((double) totalOrders / pageSize);

            // 현재 페이지에서 가져올 주문 목록의 시작 인덱스 계산
            int startIndex = (page - 1) * pageSize;

            // 현재 페이지의 시작 인덱스와 끝 인덱스 계산
            int endIndex = Math.min(startIndex + pageSize, totalOrders);

            // 주문 목록 가져오기
            List<Order> userOrderList = orderService.getUserOrders(userid);

            // 현재 페이지에 해당하는 부분집합 추출
            List<Order> currentPageList = userOrderList.subList(startIndex, endIndex);

            // 모델에 필요한 데이터 추가
            model.addAttribute("userOrderList", currentPageList);
            model.addAttribute("currentPage", page); // 현재 페이지 번호
            model.addAttribute("totalPages", totalPages); // 전체 페이지 수

            return "dog/orderList";
        }


        @RequestMapping("/dog/orderDetail/{orderId}")
        public String getOrderDetail(@PathVariable String orderId, Model model, HttpSession session) {

            User user = (User) session.getAttribute("user");
            String userid = user.getUserid();

            List<Order> userOrderList = orderService.getUserOrders(userid);
            model.addAttribute("userOrderList", userOrderList);

            List<Cart> cart = orderService.getOrderById(orderId);
            model.addAttribute("cart", cart);
            return "dog/orderDetail";
        }


    }
