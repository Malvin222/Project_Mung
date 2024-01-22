package com.project_mung.controller;

import com.project_mung.domain.User;
import com.project_mung.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("/join")
    public String userJoin() {
        return "user/join";
    }

    @PostMapping("/join")
    public String insertUser(@ModelAttribute User user, Model model) {
        try {
            userService.insertUser(user);
            model.addAttribute("message", "회원 가입이 완료되었습니다.");
            return "redirect:/dog/dogFoodSearch";
        } catch (Exception e) {
            model.addAttribute("error", "회원 가입 중 오류가 발생했습니다.");
            return "user/join";
        }
    }

    @GetMapping("/login")
    public String getLogin() {

        return "user/login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam("userid") String userid,
                            @RequestParam("userpass") String userpass,
                            Model model,
                            HttpSession session) {

        User user = userService.getLoginInfo(userid, userpass);

        if (user != null) {
            session.setAttribute("user", user);
            return "redirect:/dog/dogFoodSearch";
        } else {
            model.addAttribute("error", "잘못된 인증 정보입니다. 다시 시도해주세요.");
            return "user/login";
        }
    }

    @GetMapping("/logout")
    public String logoutUser(HttpSession session) {
        // 세션 무효화 또는 사용자 속성 제거
        session.invalidate();
        return "redirect:/";
    }

}
