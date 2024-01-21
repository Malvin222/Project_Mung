package com.project_mung.service;

import com.project_mung.domain.DogFood;
import com.project_mung.mapper.DogFoodMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
    public DogFood getDogFoodById(int dogfoodid) {

        return dogFoodMapper.selectDogFoodById(dogfoodid);
    }

    @Override
    public List<DogFood> getAllDogFood() {

        return dogFoodMapper.getAllDogFood();
    }

    @Override
    public List<DogFood> selectDogFoodByKeyword(String dogfoodname) {
        return dogFoodMapper.selectDogFoodByKeyword(dogfoodname);
    }

    @Override
    public List<String> getAllDogFoodBrands() {
        return dogFoodMapper.getAllDogFoodBrands();

    }

    @Override
    public List<DogFood> selectDogFoodbyNut() {
        return dogFoodMapper.selectDogFoodbyNut();
    }


}