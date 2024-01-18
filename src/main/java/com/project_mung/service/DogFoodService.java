package com.project_mung.service;

import com.project_mung.domain.DogFood;
import com.project_mung.mapper.DogFoodMapper;

import java.util.List;

public interface DogFoodService {
    DogFoodMapper getDogFoodById(int dogfoodid);

    List<DogFood> getAllDogFood();
}
