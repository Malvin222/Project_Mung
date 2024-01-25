package com.project_mung.service;

import com.project_mung.domain.Cart;
import com.project_mung.mapper.CartMapper;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j2
@Service
public class CartServiceImpl implements CartService{

    private final CartMapper cartMapper;

    @Autowired
    public CartServiceImpl(CartMapper cartMapper){
        this.cartMapper = cartMapper;
    }
    //장바구니 추가
    @Override
    public void addToCart(Cart cartItem) {
        cartMapper.addToCart(cartItem);
    }

    //중복 목록 조회
    @Override
    public int getCart(Cart cartItem) {
        return cartMapper.getCart(cartItem);
    }

    //장바구니 아이템 하나 추가
    @Override
    public void plusOneItem(Cart cartItem) {
        cartMapper.plusOneItem(cartItem);
    }

    //장바구니 아이템 삭제
    @Override
    public void removeFromCart(int cartid) {
        cartMapper.removeFromCart(cartid);
    }

    //장바구니 목록조회
    @Override
    public List<Cart> getCartItems(String userid) {
        return cartMapper.getCartItems(userid);
    }

    //장바구니 총 가격
    @Override
    public int totalPrice(List<Cart> cartItems) {
        int totalPrice = 0;

        for(Cart cart : cartItems){
            totalPrice += cart.getTotalprice();
        }
        return totalPrice;
    }

    //주문
    @Override
    public void placeOrder(String userid) {
        // 주문 처리 로직 구현
        // 주문 정보를 데이터베이스에 저장하고 장바구니 비우기 등의 작업 수행
    }

    //장바구니 수량변경
    @Override
    public boolean updateItemCnt(int cartid, int newQuantity) {
        return cartMapper.updateItemCnt(cartid,newQuantity);
    }

    @Override
    public boolean updatePrice(int cartid) {
        return cartMapper.updatePrice(cartid);
    }

    @Override
    public void removeAllFromCart(String userid)  {
        cartMapper.removeAllFromCart(userid);
    }

    @Override
    public boolean changeQuantity(int cartid, int amount) {
        // amount가 음수이면 수량을 감소시키고, 양수이면 수량을 증가시킵니다.
        cartMapper.changeQuantity(cartid, amount);
        return true; // 성공하면 true를 반환
    }

    @Override
    public void removeSelectedItems(List<Long> selectedItems) {
        cartMapper.removeSelectedItems(selectedItems);

    }


}
