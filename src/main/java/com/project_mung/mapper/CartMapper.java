package com.project_mung.mapper;


import com.project_mung.domain.Cart;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CartMapper {

    //장바구니에 상품 추가
    void addToCart(Cart cartItem);

    //장바구니 상품 추가 항목 존재여부 확인
    int getCart(Cart cartItem);

    //항목이 존재하면 아이템개수 증가
    void plusOneItem(Cart cartItem);

    //장바구니에 담긴 상품 목록 조회
    List<Cart> getCartItems(String userid);

    //장바구니 삭제
    void removeFromCart(int cartid);

    //수량변경
    boolean updateItemCnt(int cartid, int newQuantity);

    //아이템가격변경
    boolean updatePrice(int cartid);

    void removeAllFromCart(String userid);

    // 장바구니에서 특정 상품의 수량 변경
    boolean changeQuantity(int cartid, int amount);

    void removeSelectedItems(List<Long> selectedItems);
}
