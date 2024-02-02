package com.project_mung.controller;

import com.project_mung.domain.User;
import com.project_mung.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/user")
@Log4j2
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
            userService.insertUserDelivery(user);
            model.addAttribute("message", "회원 가입이 완료되었습니다.");
            return "redirect:/user/login";
        } catch (DuplicateKeyException e) {
            model.addAttribute("error", "이미 가입된 회원입니다.");
            return "user/join";
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("error", "데이터 무결성 오류가 발생했습니다.");
            return "user/join";
        } catch (Exception e) {
            model.addAttribute("error", "회원 가입 중 오류가 발생했습니다.");
            return "user/join";
        }
    }

    @GetMapping("/modify")
    public String usermodify() {

        return "user/modify";
    }

//    @PostMapping("/modifySave")
//    public String modifySave(@ModelAttribute User user,Model model,HttpSession session){
//        try {
//            userService.modifyUser(user);
//
//            User updatedUser = userService.getUserById(user.getUserid());
//            session.setAttribute("user", updatedUser);
//            model.addAttribute("message", "회원 정보가 수정되었습니다.");
//            return "redirect:/";
//        } catch (DataIntegrityViolationException e) {
//            model.addAttribute("error", "데이터 무결성 오류가 발생했습니다.");
//            return "user/modify";
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.addAttribute("error", "회원 정보 수정중 오류가 발생했습니다.");
//            return "user/modify";
//        }
//    }

    @PostMapping("/modifySave")
    public String modifySave(@ModelAttribute User user, Model model, HttpSession session,
                             @RequestParam("currentPassword") String currentPassword,
                             @RequestParam("newPassword") String newPassword,
                             @RequestParam("confirmPassword") String confirmPassword) {
        // 세션에서 현재 사용자 정보를 가져옵니다.
        User currentUser = (User) session.getAttribute("user");

        // 사용자가 입력한 현재 비밀번호가 올바른지 확인합니다.
        if (!passwordEncoder.matches(currentPassword, currentUser.getUserpass())) {
            model.addAttribute("error", "현재 비밀번호가 일치하지 않습니다.");
            return "user/modify";
        }

        // 새로운 비밀번호와 확인 비밀번호가 일치하는지 확인합니다.
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "새로운 비밀번호가 일치하지 않습니다.");
            return "user/modify";
        }

        try {
            // 새로운 비밀번호를 암호화하여 사용자 정보에 설정합니다.
            user.setUserpass(passwordEncoder.encode(newPassword));
            // UserService를 통해 사용자 정보를 수정합니다.
            userService.modifyUser(user);

            // 수정된 사용자 정보를 세션에 설정합니다.
            User updatedUser = userService.getUserById(user.getUserid());
            session.setAttribute("user", updatedUser);

            model.addAttribute("message", "회원 정보가 수정되었습니다.");
            return "redirect:/";
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("error", "데이터 무결성 오류가 발생했습니다.");
            return "user/modify";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "회원 정보 수정 중 오류가 발생했습니다.");
            return "user/modify";
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

        if (passwordEncoder.matches(userpass, user.getUserpass())) {
            session.setAttribute("user", user);

            return "redirect:/dog/dogFoodSearch";
        } else {
            model.addAttribute("error", "잘못된 인증 정보입니다. 다시 시도해주세요.");
            return "user/login";
        }
    }

    @GetMapping("/logout")
    public String logoutUser(HttpSession session) {
        // 세션에서 사용자 정보 제거
        session.invalidate();
        return "redirect:/";
    }


}
