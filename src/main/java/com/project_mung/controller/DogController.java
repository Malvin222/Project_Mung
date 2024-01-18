package com.project_mung.controller;

import com.project_mung.domain.DogFood;
import com.project_mung.service.DogFoodService;
import org.springframework.beans.factory.annotation.Autowired;
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

    @GetMapping("/dog/dogSearch")
    public String getAllDogFoods(@RequestParam(name = "page", defaultValue = "1") int page,
                                 @RequestParam(name = "pageSize", defaultValue = "10") int pageSize,
                                 Model model) {
        // 전체 강아지 음식 리스트 가져오기
        List<DogFood> dogFoodList = dogFoodService.getAllDogFood();

        // 전체 페이지 수 계산
        int totalPage = (int) Math.ceil((double) dogFoodList.size() / pageSize);

        // 현재 페이지의 시작 인덱스와 끝 인덱스 계산
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, dogFoodList.size());

        // 현재 페이지에 해당하는 부분집합 추출
        List<DogFood> currentPageList = dogFoodList.subList(startIndex, endIndex);

        // dogfoodbrands 가져오기 및 중복 제거
        List<String> dogfoodbrands = dogFoodList.stream()
                .map(DogFood::getDogfoodbrand)
                .distinct()
                .collect(Collectors.toList());

        model.addAttribute("dogFoodList", currentPageList);
        model.addAttribute("dogfoodbrands", dogfoodbrands);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("currentPage", page);

        return "dog/dogSearch"; // JSP 페이지의 이름 (dogSearch.jsp)
    }
}