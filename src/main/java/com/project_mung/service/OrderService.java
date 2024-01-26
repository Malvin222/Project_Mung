package com.project_mung.service;

import com.project_mung.domain.Cart;

import java.util.List;

public interface OrderService {

    List<Cart> getOrderItems(List<Integer> cartid);

    boolean placeOrder(List<Cart> selectedItems);

}
