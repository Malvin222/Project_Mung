package com.project_mung.service;

import com.project_mung.domain.DogFood;
import com.project_mung.mapper.DogFoodMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DogFoodServiceImpl implements DogFoodService {


    private final DogFoodMapper dogFoodMapper;
    @Autowired
    public DogFoodServiceImpl(DogFoodMapper dogFoodMapper) {
        this.dogFoodMapper = dogFoodMapper;
    }


    @Override
    public DogFoodMapper getDogFoodById(int dogfoodid) {
        return dogFoodMapper.selectDogFoodById(dogfoodid);
    }

    @Override
    public List<DogFood> getAllDogFood() {
        return dogFoodMapper.getAllDogFood();
    }
}
