package com.project_mung.controller;

import com.project_mung.domain.DogFood;
import com.project_mung.service.DogFoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class DogController {

    private final DogFoodService dogFoodService;

    @Autowired
    public DogController(DogFoodService dogFoodService) {
        this.dogFoodService = dogFoodService;
    }

    @GetMapping("/dog/dogFoodSearch")
    public String selectDogFoodByKeyword(
            @RequestParam(name = "searchKeyword", required = false) String searchKeyword,
            @RequestParam(name = "selectedBrands", required = false) List<String> selectedBrands,
            @RequestParam(name = "selectedAges", required = false) List<String> selectedAges,
            @RequestParam(name = "selectedFeatures", required = false) List<String> selectedFeatures,
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "pageSize", defaultValue = "10") int pageSize,
            Model model) {

        List<DogFood> dogFoodList = dogFoodService.getAllDogFood();

        // 스트림을 사용하여 모든 필터를 적용
        dogFoodList = dogFoodList.stream()
                .filter(dogFood ->
                        (searchKeyword == null || dogFood.getDogfoodname().toLowerCase().contains(searchKeyword.toLowerCase())) &&
                                (selectedBrands == null || selectedBrands.contains(dogFood.getDogfoodbrand())) &&
                                (selectedAges == null || selectedAges.contains(dogFood.getDogage())) &&
                                (selectedFeatures == null || selectedFeatures.contains(dogFood.getDogfoodfeat())))
                .collect(Collectors.toList());

        // 컨트롤러 메서드 내부
        List<String> dogFoodBrands = dogFoodService.getAllDogFoodBrands();

        // 전체 페이지 수 계산
        int totalPage = (int) Math.ceil((double) dogFoodList.size() / pageSize);

        // 현재 페이지의 시작 인덱스와 끝 인덱스 계산
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, dogFoodList.size());

        // 현재 페이지에 해당하는 부분집합 추출
        List<DogFood> currentPageList = dogFoodList.subList(startIndex, endIndex);


        model.addAttribute("dogfoodBrands", dogFoodBrands);
        model.addAttribute("dogFoodList", dogFoodList);

        // 페이징
        model.addAttribute("dogFoodList", currentPageList);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("currentPage", page);


        return "dog/dogFoodSearch";
    }


}