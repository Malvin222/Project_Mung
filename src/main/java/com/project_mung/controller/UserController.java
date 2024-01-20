package com.project_mung.controller;

import com.project_mung.domain.User;
import com.project_mung.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/join")
    public String userJoin() {
        return "user/join";
    }

    @PostMapping("/join")
    public String insertUser(@ModelAttribute User user, Model model) {
        try {
            userService.insertUser(user);
            model.addAttribute("message", "회원 가입이 완료되었습니다.");
            return "index";
        } catch (Exception e) {
            model.addAttribute("error", "회원 가입 중 오류가 발생했습니다.");
            return "user/join";
        }
    }

    @GetMapping("/login")
    public String login() {
        return "user/login";
    }

}
