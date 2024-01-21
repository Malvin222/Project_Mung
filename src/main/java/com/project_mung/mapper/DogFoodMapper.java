package com.project_mung.mapper;

import com.project_mung.domain.DogFood;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface DogFoodMapper {
    DogFood selectDogFoodById(int id);
    List<DogFood> getAllDogFood();

    List<DogFood> selectDogFoodByKeyword(String searchKeyword);

    List<String> getAllDogFoodBrands();

    List<DogFood> selectDogFoodbyNut();
}
