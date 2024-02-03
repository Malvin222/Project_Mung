package com.project_mung.controller;

import com.project_mung.domain.Cart;
import com.project_mung.domain.Delivery;
import com.project_mung.domain.Order;
import com.project_mung.domain.User;
import com.project_mung.service.CartService;
import com.project_mung.service.OrderService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Log4j2
@Controller
public class OrderController {

    private final OrderService orderService;
    private final CartService cartService;

    @Autowired
    public OrderController(OrderService orderService, CartService cartService) {
        this.orderService = orderService;
        this.cartService = cartService;
    }

    // 결제시 주문 정보 저장
    @Transactional
    @PostMapping("/order/saveOrderInfo")
    @ResponseBody
    public String saveOrderInfo(@RequestBody Order order,HttpSession session){

        //선택 주문목록 받아오기
        List<Integer> cartid = (List<Integer>) session.getAttribute("selectedItems");
        String orderid = order.getUserid()+" "+order.getOrderid();
        order.setOrderid(orderid);

        try {

            Boolean saveOrder = orderService.saveOrder(order);

            if (saveOrder) {
                Boolean updateCart = orderService.updateCart(cartid, orderid);
                if (updateCart) {
                    log.info("Order and cart updated successfully.");
                    return "success";
                } else {
                    log.error("Failed to update cart.");
                }
            } else {
                log.error("Failed to save order.");
            }
        } catch (Exception e) {
            log.error("Exception occurred: " + e.getMessage(), e);
        }

        return "fail";
    }

    // 주문 처리 화면 // 주문하기 버튼 눌렀을시
    @GetMapping("/order/dogOrder")
    public String dogOrder(HttpSession session, Model model) {
        // 세션에서 사용자 아이디 가져오기
        User user = (User) session.getAttribute("user");

        String userid = user.getUserid();

        // 선택 주문목록 받아오기
        List<Integer> cartid = (List<Integer>) session.getAttribute("selectedItems");

        // 주문목록 가져오기
        List<Cart> orderItems = orderService.getOrderItems(cartid);
        int totalPrice = cartService.totalPrice(orderItems);

        // 배송지 정보 가져오기
        List<Delivery> deliveryList = orderService.getDelivery(userid);

        model.addAttribute("orderItems",orderItems);
        model.addAttribute("totalPrice",totalPrice);
        model.addAttribute("deliveryList",deliveryList);

        return "order/dogOrder";
    }


    // 선택된 목록이 세션에 저장 // 주문하기 눌렀을때
    @PostMapping("/order/dogOrderSave")
    @ResponseBody
    public String dogOrderSave(@RequestBody List<Integer> selectedItems, HttpSession session) {

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





    // 개 사료 주문 리스트
    @RequestMapping("/order/dogOrderList")
    public String selectDogOrderList(HttpSession session, Model model,
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

        return "order/dogOrderList";
    }


    // 주문 정보 상세
    @RequestMapping("/order/dogOrderDetail/{orderId}")
    public String getOrderDetail(@PathVariable String orderId, Model model, HttpSession session) {

        User user = (User) session.getAttribute("user");
        String userid = user.getUserid();

        List<Order> userOrderList = orderService.getUserOrders(userid);
        model.addAttribute("userOrderList", userOrderList);

        List<Cart> cart = orderService.getOrderById(orderId);
        model.addAttribute("cart", cart);
        return "order/dogOrderDetail";
    }

}
