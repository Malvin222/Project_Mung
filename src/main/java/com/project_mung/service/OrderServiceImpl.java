package com.project_mung.service;

import com.project_mung.domain.Cart;
import com.project_mung.domain.Delivery;
import com.project_mung.domain.Order;
import com.project_mung.mapper.OrderMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService{

    private final OrderMapper orderMapper;

    public OrderServiceImpl(OrderMapper orderMapper) {
        this.orderMapper = orderMapper;
    }

    @Override
    public List<Cart> getOrderItems(List<Integer> cartids) {
        return orderMapper.getOrderItems(cartids);
    }

    @Override
    public boolean placeOrder(List<Cart> selectedItems) {
        // 주문 처리 로직을 구현합니다.
        // 여기에서는 단순히 주문 정보를 출력하는 예시를 작성합니다.
        System.out.println("주문 내역:");

        for (Cart item : selectedItems) {
            System.out.println("상품명: " + item.getDogfoodname() +
                    ", 가격: " + item.getDogfoodprice() +
                    ", 수량: " + item.getItemcnt() +
                    ", 총 가격: " + item.getTotalprice());
        }

        // 실제 주문 처리 로직을 구현하고 성공 여부를 반환합니다.
        return true; // 간단한 예시로 항상 주문이 성공한다고 가정합니다.
    }

    @Override
    public List<Delivery> getDelivery(String userid) {
        return orderMapper.getDelivery(userid);
    }

    @Override
    public boolean insertDelivery(Delivery delivery) {
        return orderMapper.insertDelivery(delivery);
    }

    @Override
    public Boolean deleteDelivery(int deliveryid) {
        return orderMapper.deleteDelivery(deliveryid);
    }

    @Override
    public Boolean modifyDelivery(Delivery delivery) {
        return orderMapper.modifyDelivery(delivery);
    }

    @Override
    public Boolean saveOrder(Order order) {
        return orderMapper.saveOrder(order);
    }

    @Override
    public Boolean updateCart(List<Integer> cartid) {
        return orderMapper.updateCart(cartid);
    }


}
