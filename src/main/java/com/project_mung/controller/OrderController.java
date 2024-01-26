package com.project_mung.controller;

import com.project_mung.domain.Cart;
import com.project_mung.service.OrderService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class OrderController {

    private final OrderService orderService;

    @Autowired
    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping("/dog/placeOrder")
    public String placeOrder(HttpSession session) {
        // 세션에서 선택된 상품들의 정보를 가져오기
        List<Cart> selectedItems = (List<Cart>) session.getAttribute("selectedItems");

        if (selectedItems != null && !selectedItems.isEmpty()) { // cartItems가 null이 아니고 비어있지 않은 경우
            // 주문 서비스로 주문 처리 요청
            boolean orderPlaced = orderService.placeOrder(selectedItems);

            if (orderPlaced) {
                // 주문 성공 시 세션에서 장바구니 비우고 주문 완료 페이지로 이동
                session.removeAttribute("selectedItems");
                return "redirect:/dog/order";
            } else {
                // 주문 실패 시 오류 페이지로 이동
                return "redirect:/dog/cart";
            }
        } else {
            // 장바구니가 비어있는 경우에 대한 처리
            return "redirect:/dog/cart"; // 예: 장바구니가 비어있으면 다시 장바구니 페이지로 이동
        }
    }




}
