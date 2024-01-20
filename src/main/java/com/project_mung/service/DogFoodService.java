package com.project_mung.service;

import com.project_mung.domain.DogFood;
import com.project_mung.mapper.DogFoodMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface DogFoodService {
    DogFood getDogFoodById(int dogfoodid);

    List<DogFood> getAllDogFood();

    List<DogFood> selectDogFoodByKeyword(String dogfoodname);

    List<String> getAllDogFoodBrands();

}
