package com.project_mung.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DogController {

    @GetMapping("/dog/dogSearch")
    public String dogSearch(){

        return "dog/dogSearch";
    }
}
