package com.project_mung.controller;

import com.project_mung.domain.User;
import com.project_mung.domain.Cart;
import com.project_mung.service.CartService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Log4j2
@Controller
public class CartController {

    private final CartService cartService;

    @Autowired
    public CartController(CartService cartService) {
        this.cartService = cartService;
    }


    //장바구니 추가
    @PostMapping("/cart/addToCart")
    @ResponseBody
    public String addToCart(@RequestParam int dogfoodid,
                            @RequestParam int dogfoodprice,
                            @RequestParam String dogfoodname,
                            @RequestParam String userid) {
        try {
            Cart cartItem = Cart.builder()
                    .dogfoodid(dogfoodid)
                    .dogfoodprice(dogfoodprice)
                    .dogfoodname(dogfoodname)
                    .userid(userid)
                    .build();
            if(cartService.getCart(cartItem)==0){
                cartService.addToCart(cartItem);
            }else {
                cartService.plusOneItem(cartItem);
            }
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    // 장바구니에서 상품 삭제
    @PostMapping("/cart/removeFromCart")
    @ResponseBody
    public String removeFromCart(@RequestParam("cartid") int cartid) {
        // 장바구니에서 상품 삭제 로직 수행
        cartService.removeFromCart(cartid);

        // 삭제 성공 메시지 반환
        return "success";
    }

    // 장바구니에서 전체 상품 삭제
    @PostMapping("/cart/removeAllFromCart")
    @ResponseBody
    public String removeAllFromCart(@RequestParam("userid") String userid) {
        // 장바구니에서 상품 삭제 로직 수행
        cartService.removeAllFromCart(userid);

        // 삭제 성공 메시지 반환
        return "success";
    }


    // 주문 처리
    @PostMapping("/placeOrder")
    public String placeOrder(HttpSession session) {
        // 세션에서 사용자 아이디 가져오기
        String userid = (String) session.getAttribute("userid");

        // 주문 처리 로직 수행
        cartService.placeOrder(userid);

        // 주문 완료 페이지로 이동
        return "/order/success";
    }

    //장바구니 수량 변경
    @PostMapping("/cart/updateItemCnt")
    @ResponseBody
    public String updateItemCnt(@RequestParam int cartid,
                                @RequestParam int newQuantity) {
        // itemId와 newQuantity를 받아와서 수량 업데이트 로직을 수행
        boolean updateSuccessCnt = cartService.updateItemCnt(cartid,newQuantity);
        boolean updateSuccessPrice = cartService.updatePrice(cartid);

        if (updateSuccessCnt && updateSuccessPrice) {
            return "success";
        } else {
            return "수량 업데이트 중 오류가 발생했습니다.";
        }
    }

    // 장바구니 수량 변경
    @PostMapping("/cart/changeQuantity")
    @ResponseBody
    public String changeQuantity(@RequestParam int cartid,
                                 @RequestParam int amount) {
        // cartid와 amount를 받아와서 수량 변경 로직을 수행
        boolean updateSuccess = cartService.changeQuantity(cartid, amount);

        if (updateSuccess) {
            return "success";
        } else {
            return "수량 변경 중 오류가 발생했습니다.";
        }
    }


    // 선택 삭제
    @PostMapping("/cart/removeSelected")
    @ResponseBody
    public String removeSelectedItems(@RequestBody List<Long> selectedItems) {
        try {
            cartService.removeSelectedItems(selectedItems);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

}
