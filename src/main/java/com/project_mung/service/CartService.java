package com.project_mung.service;

import com.project_mung.domain.Cart;

import java.util.List;

public interface CartService {

    //장바구니 추가
    void addToCart(Cart cartItem);

    //장바구니 추가 항목 존재여부 확인
    int getCart(Cart cartItem);

    //항목이 존재하면 아이템개수 증가
    void plusOneItem(Cart cartItem);

    //장바구니에서 상품삭제
    void removeFromCart(int cartid);

    //장바구니에 담긴 상품 목록 조회
    List<Cart> getCartItems(String userid);

    //총 금액 계산
    int totalPrice(List<Cart> cartItem);

    // 주문 처리
    void placeOrder(String userid);
    // 주문 처리 로직 구현
    // 주문 정보를 데이터베이스에 저장하고 장바구니 비우기 등의 작업 수행

    //아이템 수량 변경
    boolean updateItemCnt(int cartid, int newQuantity);

    //아이템 가격변경
    boolean updatePrice(int cartid);

    void removeAllFromCart(String userid);

    boolean changeQuantity(int cartid, int amount);

    void removeSelectedItems(List<Long> selectedItems);
}
