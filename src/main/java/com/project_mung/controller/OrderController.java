package com.project_mung.controller;

import com.project_mung.domain.Cart;
import com.project_mung.domain.Delivery;
import com.project_mung.domain.Order;
import com.project_mung.domain.User;
import com.project_mung.service.OrderService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Bool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@Log4j2
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

    //배송지 관리
    @GetMapping("/user/delivery")
    public String delivery(HttpSession session,Model model){

        User user = (User) session.getAttribute("user");
        String userid = user.getUserid();

        List<Delivery> deliveryList = orderService.getDelivery(userid);
        model.addAttribute("deliveryList",deliveryList);

        log.info(deliveryList);

        return "user/delivery";
    }

    @PostMapping("/user/deliverySave")
    @ResponseBody
    public String deliverySave(Delivery delivery){

        Boolean deleverySave = orderService.insertDelivery(delivery);

        if(deleverySave == true){
            return "success";
        }else {
            return "fail";
        }
    }

    @PostMapping("/user/deliveryModify")
    @ResponseBody
    public String deliveryModify(Delivery delivery){

        Boolean deliveryModify = orderService.modifyDelivery(delivery);

        if(deliveryModify == true){
            return "success";
        }else {
            return "fail";
        }
    }



    @PostMapping("/user/deliveryRemove")
    @ResponseBody
    public String deliveryRemove(int deliveryid){
        Boolean deliveryRemove = orderService.deleteDelivery(deliveryid);

        if(deliveryRemove == true){
            return "success";
        }else{
            return "fail";
        }
    }

    @Transactional
    @PostMapping("/order/saveOrder")
    @ResponseBody
    public String saveOrder(@RequestBody Order order,HttpSession session){

        //선택 주문목록 받아오기
        List<Integer> cartid = (List<Integer>) session.getAttribute("selectedItems");
        log.info("cartid:::::::::::::::::::::");
        log.info(cartid);
        String orderid = order.getUserid()+" "+order.getOrderid();
        order.setOrderid(orderid);

        log.info("orderid@@@@@@@@@@@@@@@@@@@@@@@");
        log.info(orderid);

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

}
