package com.project_mung.controller;

import com.project_mung.domain.User;
import com.project_mung.domain.Cart;
import com.project_mung.service.CartService;
import com.project_mung.service.OrderService;
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
    private final OrderService orderService;

    @Autowired
    public CartController(CartService cartService, OrderService orderService) {

        this.cartService = cartService;
        this.orderService = orderService;
    }


    // 장바구니 추가
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

    // 장바구니 수량 변경(숫자로 입력 변경)
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

    // 장바구니 수량 변경(-,+ 버튼 변경)
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

    // 장바구니 선택 삭제
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

    // 장바구니 목록 조회
    @GetMapping("/cart/dogCart")
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
        return "cart/dogCart";
    }







}
