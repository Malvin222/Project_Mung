package com.project_mung.service;

import com.project_mung.domain.Cart;

import java.util.List;

public interface OrderService {
    boolean placeOrder(List<Cart> selectedItems);

}
