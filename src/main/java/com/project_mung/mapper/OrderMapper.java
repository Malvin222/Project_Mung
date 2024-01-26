package com.project_mung.mapper;

import com.project_mung.domain.Cart;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrderMapper {

    boolean placeOrder(List<Cart> selectedItems);

}
