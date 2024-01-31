package com.project_mung.mapper;

import com.project_mung.domain.Cart;
import com.project_mung.domain.Delivery;
import com.project_mung.domain.Order;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrderMapper {

    List<Cart> getOrderItems(List<Integer> cartids);

    boolean placeOrder(List<Cart> selectedItems);

    List<Delivery> getDelivery(String userid);

    boolean insertDelivery(Delivery delivery);

    Boolean deleteDelivery(int deliveryid);

    Boolean saveOrder(Order order);

    Boolean updateCart(List<Integer> cartid, String orderid);

    Boolean modifyDelivery(Delivery delivery);
}
