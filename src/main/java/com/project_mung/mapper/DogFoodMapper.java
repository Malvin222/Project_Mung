package com.project_mung.mapper;

import com.project_mung.domain.DogFood;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface DogFoodMapper {
    DogFoodMapper selectDogFoodById(int id);
    List<DogFood> getAllDogFood();
}
